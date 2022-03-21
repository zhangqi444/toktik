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
const docClient = new AWS.DynamoDB.DocumentClient();
const axios = require('axios');
const gql = require('graphql-tag');
const graphql = require('graphql');
const { print } = graphql;
const { query } = require('/opt/internal/utils/graphqlUtil');
const { constants } = require('/opt/internal/index');
const papa = require('papaparse'); 

const getPosts = async (userId) => {
    const data = {
        query: print(gql`
            query listNotInteresteds($filter: ModelNotInterestedFilterInput, $limit: Int, $nextToken: String) {
                listNotInteresteds(filter: $filter, limit: $limit, nextToken: $nextToken) {
                    nextToken startedAt items {
                        id notInterestedPostId notInterestedTargetUserId type
                    }
                }
            }
        `),
        variables: { filter: { notInterestedUserId: { eq: userId } } }
    };
    return await query(data, "listNotInteresteds");
}

const getCategory = async (name) => {
    const data = {
        query: print(gql`
            query getCategory($name: String) {
                getCategory(name: $name) {
                    id
                }
            }
        `),
        variables: { name }
    };
    return await query(data, "getCategory");
}

const getTag = async (name) => {
    const data = {
        query: print(gql`
            query getTag($name: String) {
                getTag(name: $name) {
                    id
                }
            }
        `),
        variables: { name }
    };
    return await query(data, "getTag");
}

const getUser = async (username) => {
    const data = {
        query: print(gql`
            query getUser($username: String) {
                getUser(username: $username) {
                    id
                }
            }
        `),
        variables: { username }
    };
    return await query(data, "getUser");
}



const createCategory = async (input) => {
    const data = {
        query: print(gql`
            mutation createCategory($input: CreateCategoryInput!) {
                createCategory(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createCategory");
}



const createTag = async (input) => {
    const data = {
        query: print(gql`
            mutation createTag($input: CreateTagInput!) {
                createTag(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createTag");
}

const createUser = async (input) => {
    const data = {
        query: print(gql`
            mutation createUser($input: CreateUserInput!) {
                createUser(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createUser");
}

const createPost = async (input) => {
    const graphqlData = await axios({
        url: process.env.API_TOKTIK_GRAPHQLAPIENDPOINTOUTPUT,
        method: 'post',
        headers: { 'x-api-key': process.env.API_TOKTIK_GRAPHQLAPIKEYOUTPUT },
        data: {
            query: print(gql`
                mutation CreatePost($input: CreatePostInput!) {
                    createPost(input: $input) {
                        id
                    }
                }
            `),
            variables: { input }
        }
    });
    if(!graphqlData.data.errors) return graphqlData.data.data.createPost;
}

const parseCategory = async (data) => {
    if(!data) return;

    const map = {};
    data.forEach(d => {
        if(!d || !d.category) return;
        map[d.category] = d.category;
    });
    
    await Promise.all(Object.keys(map).map(async name => {
        let res = await getCategory(name);
        console.log('zzz', res)
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
    data.forEach(d => {
        if(!d || !d.user) return;
        map[d.user] = { 
            bio: d.userBio, 
            nickname: d.userNickname || d.user, 
            username: d.user,
            portrait: d.userPortrait,
        };
    });
    await Promise.all(Object.keys(map).map(async name => {
        const input = map[name];
        let res = await getUser(name);
        if(!res) {
            res = await createUser(input);
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
            map[name] = { name };
        })
    });
    await Promise.all(Object.keys(map).map(async name => {
        let res = await getTag(name);
        if(!res) {
            res = await createTag({ name });
        }
        map[name] = res.id;
    }));
    return map;
}

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    var s3 = new AWS.S3();
    var params = {
        Bucket: process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME,
        Key: "postSource/test.csv"
    };

    const s3GetObject = (params) => {
        return new Promise((resolve, reject) => {
            s3.getObject(params, (error, data) => {
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
                    const ta = a.createdAt;
                    const tb = b.createdAt;
                    return ta.localeCompare(tb);
                });
                resolve(data);
            });
        })
    }
    
    let data = await s3GetObject(params);

    const categoryMap = await parseCategory(data);
    // const tagMap = await parseTag(data);
    // const userMap = await parseUser(data);
    
    console.log(categoryMap)
    // console.log(tagMap)
    // console.log(userMap)
    // const createPosts = await Promise.all(data.map(async d => {
    //     let { videoAttachments, videoURL, title, category, formatType, description, tags, user, source } = d;
    //     let url = videoAttachments;
    //     if(videoURL && (!url || !url.match(/[^()]+(?=\})/g))) {
    //         url = videoURL;
    //     }

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

    
    console.log(createPosts);

    return {
        statusCode: 200,
    //  Uncomment below to enable CORS requests
    //  headers: {
    //      "Access-Control-Allow-Origin": "*",
    //      "Access-Control-Allow-Headers": "*"
    //  }, 
        body: JSON.stringify(),
    };
};
