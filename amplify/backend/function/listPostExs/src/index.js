/* Amplify Params - DO NOT EDIT
	API_TOKTIK_COMMENTTABLE_ARN
	API_TOKTIK_COMMENTTABLE_NAME
	API_TOKTIK_GRAPHQLAPIENDPOINTOUTPUT
	API_TOKTIK_GRAPHQLAPIIDOUTPUT
	API_TOKTIK_GRAPHQLAPIKEYOUTPUT
	API_TOKTIK_LIKETABLE_ARN
	API_TOKTIK_LIKETABLE_NAME
	API_TOKTIK_MUSICTABLE_ARN
	API_TOKTIK_MUSICTABLE_NAME
	API_TOKTIK_NOTINTERESTEDTABLE_ARN
	API_TOKTIK_NOTINTERESTEDTABLE_NAME
	API_TOKTIK_POSTTABLE_ARN
	API_TOKTIK_POSTTABLE_NAME
	API_TOKTIK_SHARETABLE_ARN
	API_TOKTIK_SHARETABLE_NAME
	API_TOKTIK_USERTABLE_ARN
	API_TOKTIK_USERTABLE_NAME
	API_TOKTIK_VIEWTABLE_ARN
	API_TOKTIK_VIEWTABLE_NAME
	ENV
	REGION
Amplify Params - DO NOT EDIT */

const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient();
const axios = require('axios');
const gql = require('graphql-tag');
const graphql = require('graphql');
const { print } = graphql;
const { query, listCategorizations } = require('/opt/internal/utils/graphqlUtil');
const { constants } = require('/opt/internal/index');

const appconfig = new AWS.AppConfig();

const getPosts = async (args) => {
    const { nextToken, limit, filter } = args;
    const graphqlData = await axios({
        url: process.env.API_TOKTIK_GRAPHQLAPIENDPOINTOUTPUT,
        method: 'post',
        headers: { 'x-api-key': process.env.API_TOKTIK_GRAPHQLAPIKEYOUTPUT },
        data: {
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
        }
    });
    if(!graphqlData.data.errors) return graphqlData.data.data.listPosts;
}

const getNotInteresteds = async (userId) => {
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

const getIsLiked = async (requesterId, posts) => {
    const postIdMap = {};
    posts.forEach((post, index) => {
        postIdMap[`:postId${index}`] = post['id'];
        return post.id
    });
    let isLikeds = await docClient.query({
        TableName: process.env.API_TOKTIK_LIKETABLE_NAME,
        IndexName: 'likeUserId-index',
        KeyConditionExpression: '#likeUserId = :likeUserId',
        FilterExpression: `likePostId IN (${Object.keys(postIdMap).join(',')})`,
        ExpressionAttributeNames: { '#likeUserId': 'likeUserId'},
        ExpressionAttributeValues: { ':likeUserId': requesterId, ...postIdMap },
    }).promise();
    const isLikedMap = {};
    isLikeds['Items'].forEach(isLiked => {
        isLikedMap[isLiked['likePostId']] = {
            ...isLiked,
            user: { id: isLiked['likeUserId'], __typename: 'User', },
            post: { id: isLiked['likePostId'], __typename: 'Post', }
        };
    });
    return isLikedMap;
}

const check = (op, actual, expected) => {
    if (!op || !op.op) return false;

    switch (op.op) {
        case 'eq':
            return actual === expected;
        default:
            return false;
    }
}

const isEnabled = (config, param) => {
    if (config || !config.enabled) return false;

    let flag = true
    const keys = Object.keys(config);
    for (var i = 0; i < keys.length; i++) {
        const key = keys[i];
        switch (key) {
            case 'mobileAppVersion':
                if (!param.mobileAppVersion || !param.mobileAppVersion.op) {
                    flag = false;
                }
                flag &= check(param.mobileAppVersion.op, param.mobileAppVersion, param.mobileAppVersion.value);
                break;

            default:
                // code
                break;
        }
        if (!flag) break;
    }
    return flag;
}

exports.handler = async (event, context) => {
    var params = {
        Application: "Breeze",
        ClientId: "example-id",
        Configuration: "inv6u7k",
        Environment: "prod"
    };
    const getConfiguration = () => new Promise(
        (resolve, reject) => {
            appconfig.getConfiguration(params, function (err, data) {
                if (err) reject(err); // an error occurred
                else resolve(data);     // successful response
            });
        });

    let config = await getConfiguration();
    config = config && config.Content && JSON.parse(config.Content);


    try {
        const args = event['arguments'];
        const requesterId = args['userId'];

        const result = await Promise.all([
            getPosts(args), getNotInteresteds(requesterId)
        ]);
        const postsData = result[0];
        const notInteresteds = result[1];
        const { items, nextToken, startedAt } = postsData;
        const notInterestedPosts = {};
        const notInterestedTargetUsers = {};

        if(notInteresteds && notInteresteds.items) {
            notInteresteds.items.forEach(item => {
                if(item.type === constants.NOT_INTERESTED_TYPE.USER) {
                    notInterestedTargetUsers[item.notInterestedTargetUserId] = true;
                } else if(item.type === constants.NOT_INTERESTED_TYPE.POST) {
                    notInterestedPosts[item.notInterestedPostId] = true;
                }
            })
        }

        // The filtering logic of DDB query can't support too many parameters.
        // We have to submit multiple queries.
        let isLikedMap;
        if(requesterId) {
            isLikedMap = {};
            let startIndex = 0;
            const queries = [];
            while(startIndex < items.length) {
                queries.push(getIsLiked(requesterId, items.slice(startIndex, startIndex+100)));
                startIndex += 100;
                
            }
            const queryResults = await Promise.all(queries);
            queryResults.forEach(q => {
                isLikedMap = { ...isLikedMap, ...q };
            })
        }
        
        let categorizations;
        if (isEnabled(config, { mobileAppVersion: args.mobileAppVersion })) {
            categorizations = await listCategorizations(
                {
                    filter: {
                        or: [
                            { name: { eq: "Business & startup" } },
                            { name: { eq: "Science & Technology" } },
                        ]
                    }
                }
            );
            categorizations = categorizations && categorizations.data;
        }

        const posts = items
            .filter(post => {
                let res = !notInterestedPosts[post.id] && !notInterestedTargetUsers[post.postUserId];
                if (isEnabled(config, { mobileAppVersion: args.mobileAppVersion })) {
                    res &= post.postCategorizationId === categorizations[0].id || post.postCategorizationId === categorizations[1].id;
                }
                return res;
            })
            .map(post => {
                const result = { ...post };
                if(isLikedMap) result['isLiked'] = isLikedMap[post['id']];
                result['attachments'] = JSON.parse(result['attachments']);
                return result;
            });

        return {
            items: posts, nextToken, startedAt,
            statusCode: 200,
            headers: { "Access-Control-Allow-Origin": "*", }
        };
    } catch (err) {
        console.log(err);
        return { error: err };
    }
}