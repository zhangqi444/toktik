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

const { getCategoryByName, getTagByName, createCategory, createTag, createPost, getUserByUsername, createUser, listPosts } = require('/opt/internal/utils/graphqlUtil');
const { putObjectFromUrl, getObject } = require('/opt/internal/utils/s3Util');
const papa = require('papaparse'); 

const TOKTIK_BUCKET_USER_PORTRAIT_IMAGES_PATH = 'user-portrait-images';
const TOKTIK_VIDEOS_PATH = 'videos';

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
        const username = d.user.replace(/\s/g, '-');
        map[username] = null;
        userDataMap[username] = { 
            bio: d.userBio, 
            nickname: d.userNickname || d.user, 
            username,
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
                    input.portrait = await putObjectFromUrl(
                        portraitUrl, 
                        process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME, 
                        process.env.REGION,
                        portraitFileName
                    );
                }
                
            } catch(e) {
                console.error('Failed to parse portrait image: ', e);
            }
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
        const { tags } = d;
        tags.forEach(name => {
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

const airtableAttachmentRegexMatch = (url) => {
    return url.match(/[^()]+(?=\))/g);
}

const uploadAsset = async (airtableFieldValue, path) => {
    let url = airtableAttachmentRegexMatch(airtableFieldValue);
    url = url && url[0];
    let fileName = airtableFieldValue.split(' ');
    fileName = fileName && `${path}/${fileName[0]}`;

    return url && await putObjectFromUrl(
        url, 
        process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME, 
        process.env.REGION,
        fileName
    );
}

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {
    var params = {
        Bucket: process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME,
        Key: "postSource/test.csv"
    };

    let data = await getObject(params);
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
    
    if(!data) return;
    data.forEach(d => {
        d.tags = d.tags ? d.tags.split(',') : [];
    });

    data = data.sort((b, a) => {
        const ta = a.updatedAt;
        const tb = b.updatedAt;
        return ta.localeCompare(tb);
    });

    const categoryMap = await parseCategory(data);
    const tagMap = await parseTag(data);
    const userMap = await parseUser(data);
    
    let count = 0;
    try {
        let createPosts = await Promise.all(data.map(async d => {
            let { videoAttachments, videoURL, title, category, formatType, description, tags, user, source } = d;
            let url = await uploadAsset(videoAttachments, TOKTIK_VIDEOS_PATH);
            url = url || videoURL;
            if(!url) return;
            user = d.user.replace(/\s/g, '-');
            
            const existingPosts = await listPosts({ "filter": { "postUserId": { "eq": userMap[user] }, "text": { "eq": title } } });
            if(existingPosts && existingPosts.items && existingPosts.items.length > 0) return;

            const cp = await createPost({
                commentCount: 0, viewCount: 0, shareCount: 0, likeCount: Math.floor(Math.random() * 1000),
                text: title, description, formatType, source,
                attachments: JSON.stringify({ data: [ { url } ] }),
                postCategoryId: category && categoryMap[category], 
                postTagIds: tags.map(t => tagMap[t]), 
                postUserId: user && userMap[user]
            });
            count++
            
            return cp;
        }));
    } catch(e) {
        console.log('error: ' + e);
        return {
            statusCode: 500,
            body: JSON.stringify({ error }),
        };
    }
    
    return {
        statusCode: 200,
        body: JSON.stringify({ message: `${count} post added.` }),
    };
};
