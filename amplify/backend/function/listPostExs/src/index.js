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

exports.handler = async (event, context) => {
    try {
        const args = event['arguments'];
        const requesterId = args['userId'];

        const { items, nextToken, startedAt } = await getPosts(args);

        let posts;
        if(requesterId) {
            const isLikedMap = await getIsLiked(requesterId, items);
            posts = items.map(post => {
                return { ...post, isLiked: isLikedMap[post['id']] };
            });
        }

        return {
            items: posts || items, nextToken, startedAt,
            statusCode: 200,
            headers: { "Access-Control-Allow-Origin": "*", }
        };
    } catch (err) {
        console.log(err);
        return { error: err };
    }
}