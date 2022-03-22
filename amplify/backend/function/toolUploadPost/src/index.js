/* Amplify Params - DO NOT EDIT
	ENV
	REGION
	API_TOKTIK_GRAPHQLAPIIDOUTPUT
	API_TOKTIK_GRAPHQLAPIENDPOINTOUTPUT
	API_TOKTIK_GRAPHQLAPIKEYOUTPUT
	STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME
	API_TOKTIK_POSTTABLE_NAME
	API_TOKTIK_POSTTABLE_ARN
	API_TOKTIK_USERTABLE_NAME
	API_TOKTIK_USERTABLE_ARN
Amplify Params - DO NOT EDIT */

const AWS = require('aws-sdk');
const axios = require('axios');
const gql = require('graphql-tag');
const graphql = require('graphql');
const { print } = graphql;
const { query, getCategoryByName, getTagByName, createCategory, createTag, getUserByUsername, createUser } = require('/opt/internal/utils/graphqlUtil');
const { constants } = require('/opt/internal/index');
const papa = require('papaparse'); 
const s3 = new AWS.S3();
const { fileTypeFromFile } = require('file-type');

const TOKTIK_BUCKET_USER_PORTRAIT_IMAGES_PATH = 'user-portrait-images';
const TOKTIK_VIDEOS_VIDEO_PATH = 'videos';

const listPosts = async (args) => {
    const { nextToken, limit, filter } = args;
    return await query({
        query: print(gql`
            query listPosts($filter: ModelPostFilterInput, $limit: Int, $nextToken: String) {
                listPosts(filter: $filter, limit: $limit, nextToken: $nextToken) {
                    nextToken startedAt items {
                        id text attachments likeCount commentCount shareCount viewCount
                        user { id _deleted _lastChangedAt _version bio birth city
                            createdAt gender nickname portrait profession updatedAt username }
                        music { id _deleted _lastChangedAt _version img url createdAt updatedAt }
                    }
                }
            }
        `),
        variables: { filter, limit, nextToken }
    }, 'listPosts');
}

const createPost = async (input) => {
    const data = {
        query: print(gql`
            mutation createPost($input: createPostInput!) {
                createPost(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createPost");
}

const parseCategory = async (data) => {
    if(!data) return;

    const map = {};
    data.forEach(d => {
        if(!d || !d.category) return;
        map[d.category] = null;
    });
    
    await Promise.all(Object.keys(map).map(async name => {
        let res = await getCategoryByName(name);
        res = res && res.items && res.items[0];
        if(!res) {
            res = await createCategory({ name, isSubcategory: false });
        }
        map[name] = res.id;
    }));
    
    return map;
}

const parseUser = async (data) => {
    if(!data) return;
    
    const map = {};
    const userDataMap = {}
    data.forEach(d => {
        if(!d || !d.user) return;
        map[d.user] = null;
        userDataMap[d.user] = { 
            bio: d.userBio, 
            nickname: d.userNickname || d.user, 
            username: d.user,
            portrait: d.userPortrait,
        };
    });
    await Promise.all(Object.keys(map).map(async name => {
        const input = userDataMap[name];
        let res = await getUserByUsername(name);

        res = res && res.items && res.items[0];
        if(!res) {
            try {
                const { portrait } = input;
                if(portrait) {
                    let portraitUrl = airtableAttachmentRegexMatch(portrait);
                    portraitUrl = portraitUrl && portraitUrl[0];
                    let portraitFileName = portrait.split(' ');
                    portraitFileName = portraitFileName && `${TOKTIK_BUCKET_USER_PORTRAIT_IMAGES_PATH}/${portraitFileName[0]}`;
                    await putObjectFromUrl(portraitUrl, process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME, portraitFileName);
                    input.portrait = `https://${process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME}.s3.us-west-2.amazonaws.com/${portraitFileName}`;
                }
                
            } catch(e) {
                console.error('Failed to parse portrait image: ', e);
            }
            // res = await createUser(input);
        }
        map[name] = res.id;
    }));
    return map;
}

const parseTag = async (data) => {
    if(!data) return;
    
    const map = {};
    data.forEach(d => {
        const tags = d && d.tags && d.tags.split(',');
        tags && tags.forEach(name => {
            map[name] = null;
        })
    });
    await Promise.all(Object.keys(map).map(async name => {
        let res = await getTagByName(name);
        res = res && res.items && res.items[0];
        if(!res) {
            res = await createTag({ name });
        }
        map[name] = res.id;
    }));
    return map;
}

const putObjectFromUrl = async (url, bucket, path) => {
    
    return new Promise((resolve, reject) => {
        axios.get(url, {   
            decompress: false,
            // Ref: https://stackoverflow.com/a/61621094/4050261
            responseType: 'arraybuffer',
        }).then(async (resp) => {
                if(!resp.data) return;
                console.log(resp.data)
                const fileType = await fileTypeFromBuffer(resp.data)
                if(!path.endsWith(fileType)) {
                    path = path.split('.')[0] + fileType;
                }
            s3.putObject({
                Body: resp.data,
                Key: path,
                Bucket: bucket
            }, function(error, data) { 
                console.log(error, data)
                if (error) {
                    reject(error);
                } else {
                    resolve(`https://${process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME}.s3.${process.env.REGION}.amazonaws.com/${path}`);
                }
            });
        }).catch(error => reject(error));
    });
}

const airtableAttachmentRegexMatch = (url) => {
    return url.match(/[^()]+(?=\))/g);
}

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    var params = {
        Bucket: process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME,
        Key: "postSource/test.csv"
    };

    const s3GetObject = (params) => {
        return new Promise((resolve, reject) => {
            s3.getObject(params, async (error, data) => {
                data = new Buffer.from(data.Body).toString()
                data = papa.parse(data, {
                    header: true, 
                    skipEmptyLines: true,
                    delimiter: ",",
                    escapeChar: "_",
                    columns: [ 
                        "title", "uploaded", "videoURL", "videoAttachments",
                        "user", "formatType", "category", "source", "tags", "description", 
                        "userPortrait", "userNickname", "userBio", "userId", "createdAt", "updatedAt"
                    ]
                }).data;

                data = data.sort((b, a) => {
                    const ta = a.updatedAt;
                    const tb = b.updatedAt;
                    return ta.localeCompare(tb);
                });
                resolve(data);
            });
        })
    }
    
    let data = await s3GetObject(params);

    const categoryMap = await parseCategory(data);
    const tagMap = await parseTag(data);
    const userMap = await parseUser(data);
    console.log(categoryMap);
    console.log(tagMap);
    console.log(userMap)
    
    // const createPosts = await Promise.all(data.map(async d => {
    //     let { videoAttachments, videoURL, title, category, formatType, description, tags, user, source } = d;
    //     let url = videoAttachments;
    //     if(videoURL && (!url || !airtableAttachmentRegexMatch(url))) {
    //         url = videoURL;
    //     }

    //     const existingPosts = await listPosts({ filter: { postUserId: { eq: userMap[user] },  } });

    //     const cp = await createPost({
    //         commentCount: 0, viewCount: 0, shareCount: 0, likeCount: Math.floor(Math.random() * 1000),
    //         text: title, description, formatType, source,
    //         attachments: JSON.stringify({ data: [ { url } ] }),
    //         postCategoryId: categoryMap[category], 
    //         postTagIds: tags.map(t => tagMap[t]), 
    //         postUserId: userMap[user]
    //     });

    //     return cp;
    // }));

    
    return {
        statusCode: 200,
        body: JSON.stringify({ count: 1 }),
    };
};
