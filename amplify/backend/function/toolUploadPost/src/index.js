/* Amplify Params - DO NOT EDIT
	API_TOKTIK_CATEGORIZATIONTABLE_ARN
	API_TOKTIK_CATEGORIZATIONTABLE_NAME
	API_TOKTIK_GRAPHQLAPIENDPOINTOUTPUT
	API_TOKTIK_GRAPHQLAPIIDOUTPUT
	API_TOKTIK_GRAPHQLAPIKEYOUTPUT
	API_TOKTIK_POSTTABLE_ARN
	API_TOKTIK_POSTTABLE_NAME
	API_TOKTIK_TAGTABLE_ARN
	API_TOKTIK_TAGTABLE_NAME
	API_TOKTIK_USERTABLE_ARN
	API_TOKTIK_USERTABLE_NAME
	ENV
	REGION
	STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME
Amplify Params - DO NOT EDIT */

const { query, getCategorizationByName, getTagByName, createCategorization, createTag, createPost, getUserByUsername, createUser, listPosts, getPostsOrderedByCreatedAt, updatePost } = require('/opt/internal/utils/graphqlUtil');
const { putObjectFromUrl, getObject, listObjects } = require('/opt/internal/utils/s3Util');
const { constants } = require('/opt/internal/index');
const papa = require('papaparse'); 

const TOKTIK_BUCKET_USER_PORTRAIT_IMAGES_PATH = 'user-portrait-images';
const TOKTIK_VIDEOS_PATH = 'videos';
const STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME = "toktik-storage-55239e9360500-staging";
const STORAGE_S3TOKTIKSTORAGED847E71C_BUCKETNAME = "toktik-storage-d847e71c175430-prod";
const STORAGE_S3TOKTIKSTORAGE_BUCKETNAME = process.env.ENV === "prod" 
    ? process.env.STORAGE_S3TOKTIKSTORAGED847E71C_BUCKETNAME
    : process.env.STORAGE_S3TOKTIKSTORAGE55239E93_BUCKETNAME;

const parseCategorization = async (data) => {
    if(!data) return;

    const map = {};
    data.forEach(d => {
        if(!d || !d.categorization) return;
        map[d.categorization] = null;
    });
    
    let count = 0;
    await Promise.all(Object.keys(map).map(async name => {
        let res = await getCategorizationByName(name);
        res = res && res.items && res.items[0];
        if(!res) {
            res = await createCategorization({ name, isSubcategorization: false });
            count++;
        }
        map[name] = res.id;
    }));
    
    console.log(`Loaded ${count} of ${Object.keys(map).length} new categories.`);
    
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
    
    let count = 0;
    
    await Promise.all(Object.keys(map).map(async name => {
        const input = userDataMap[name];
        let res = await getUserByUsername(name);

        res = res && res.items && res.items[0];
        if(!res) {
            try {
                const { portrait } = input;
                if(portrait) {
                    const { fileName, url } = parseAirtableAttachmentPath(portrait, TOKTIK_BUCKET_USER_PORTRAIT_IMAGES_PATH);
                    input.portrait = await putObjectFromUrl(
                        url, 
                        STORAGE_S3TOKTIKSTORAGE_BUCKETNAME, 
                        process.env.REGION,
                        fileName,
                        // { ACL: "public-read" }
                    );
                }
            } catch(e) {
                console.error('Failed to parse portrait image: ', e);
            }
            res = await createUser(input);
            count++;
        }
        map[name] = res.id;
    }));
    
    console.log(`Loaded ${count} of ${Object.keys(map).length} new users.`);
    
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
    let count = 0;
    await Promise.all(Object.keys(map).map(async name => {
        let res = await getTagByName(name);
        res = res && res.items && res.items[0];
        if(!res) {
            res = await createTag({ name });
            count++;
        }
        map[name] = res.id;
    }));
    
    console.log(`Loaded ${count} of ${Object.keys(map).length} new tags.`);
    
    return map;
}

const parseAirtableAttachmentPath = (airtableFieldValue, path = "") => {
    airtableFieldValue = airtableFieldValue.replace(/"/g, '');
    let lastIndexOf = airtableFieldValue.lastIndexOf('(');
    let fileName = airtableFieldValue.slice(0, lastIndexOf) || '';
    fileName = fileName && `${path}/${fileName.trim().replace(/ /g, '+')}`;
    let url = airtableFieldValue.slice(lastIndexOf+1, airtableFieldValue.length-1);
    
    return { fileName, url };
}

const uploadAsset = async (airtableFieldValue, path) => {
    const { fileName, url } = parseAirtableAttachmentPath(airtableFieldValue, path);

    return url && await putObjectFromUrl(
        url, 
        STORAGE_S3TOKTIKSTORAGE_BUCKETNAME, 
        process.env.REGION,
        fileName,
        // { ACL: "public-read" },
    );
}

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
exports.handler = async (event) => {

    let objects = await listObjects(
        STORAGE_S3TOKTIKSTORAGE_BUCKETNAME,
        "post-source/",
    );
    objects = objects.Contents
    objects = objects.sort((a, b) => b.LastModified - a.LastModified);
    const key = objects[0].Key;
    
    console.log(`Loading file ${key}...`);

    let data = await getObject({
        Bucket: STORAGE_S3TOKTIKSTORAGE_BUCKETNAME,
        Key: key
    });
    data = papa.parse(data, {
        header: true, 
        skipEmptyLines: true,
        delimiter: ",",
        escapeChar: "_",
        columns: [ 
            "title", "uploaded", "videoURL", "videoAttachments",
            "user", "formatType", "categorization", "source", "tags", "description", 
            "userPortrait", "userNickname", "userBio", "userId", "createdAt", "updatedAt"
        ]
    }).data;
    
    if(!data) {
        console.log(`Failed to parse the data.`);
        return;
    }
    
    let lastUpdatedPost = await getPostsOrderedByCreatedAt(constants.GRAPHQL_MODEL_SORT_DIRECTION.DESC, 1);
    lastUpdatedPost = lastUpdatedPost && lastUpdatedPost.items && lastUpdatedPost.items[0] && lastUpdatedPost.items[0].createdAt;
    data = data.filter(d => {
        let valid = !lastUpdatedPost || (Date.parse(`${d.updatedAt} GMT`) > Date.parse(lastUpdatedPost));
        valid = valid && d.user && d.title && d.formatType && d.categorization && (d.videoURL || d.videoAttachments) && !d.uploaded;
        return valid;
    });
    
    data.forEach(d => {
        d.tags = d.tags ? d.tags.split(',') : [];
    });
    
    console.log(`Loaded ${data.length} rows of data.`);
    if(data.length <= 0) return;

    const categorizationMap = await parseCategorization(data);
    const tagMap = await parseTag(data);
    const userMap = await parseUser(data);
    
    let count = 0;
    try {
        for (var i = 0; i < data.length; i++) {
            const d = data[i];
            let { videoAttachments, videoURL, title, categorization, formatType, description, tags, user, source } = d;
            let url = await uploadAsset(videoAttachments, TOKTIK_VIDEOS_PATH);
            url = url || videoURL;
            if(!url) return;
            user = d.user.replace(/\s/g, '-');
            
            let input = {
                text: title, description, formatType, source,
                attachments: JSON.stringify({ data: [ { url } ] }),
                postCategorizationId: categorization && categorizationMap[categorization], 
                postTagIds: tags.map(t => tagMap[t]), 
                postUserId: user && userMap[user],
                sortier: constants.GRAPHQL_SORTIER,
            };
            
            const existingPosts = await listPosts({ "filter": { "postUserId": { "eq": userMap[user] }, "text": { "eq": title } } });
            let cp;
            if(existingPosts && existingPosts.items && existingPosts.items.length > 0) {
                input.updatedAt = new Date().toISOString();
                input.id = existingPosts.items[0].id;
                cp = await updatePost(input);
            } else {
                count++;
                input = { 
                    ...input,
                    commentCount: 0, viewCount: 0, shareCount: 0, 
                    likeCount: Math.floor(Math.random() * 1000), 
                    isImported: true, isBlocked: false,
                    status: constants.INITIALIZED, 
                }; 
                cp = await createPost(input);
            }
            console.log(`Loaded post: ${title}.`);
        }
            
        console.log(`Loaded ${count} of ${data.length} new posts.`);
    
        return {
            statusCode: 200,
            body: JSON.stringify({ message: `${count} post added.` }),
        };
    } catch(e) {
        console.error('error: ' + JSON.stringify(e));
        return {
            statusCode: 500,
            body: JSON.stringify({ e }),
        };
    }
};
