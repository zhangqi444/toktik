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
const { listPosts, listNotInterestedsByUserId } = require('/opt/internal/utils/graphqlUtil');
const { constants } = require('/opt/internal/index');
const { getConfig, CONFIG_CATEGORIZATION, CATEGORIZATION } = require('/opt/internal/config');
const { FEATURE_FLAGS, isEnabled } = require('/opt/internal/utils/featureFlagUtil');

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

    const args = event['arguments'];
    if (!args) return {
        error: "Bad Request",
        statusCode: 400,
    };

    try {
        const requesterId = args['userId'];

        const result = await Promise.all([
            listPosts(args), listNotInterestedsByUserId(requesterId)
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

        const sortedItems = items
            .filter(post => {
                return !notInterestedPosts[post.id] && !notInterestedTargetUsers[post.postUserId];
            })
            .map(post => {
                const result = { ...post };
                if(isLikedMap) result['isLiked'] = isLikedMap[post['id']];
                result['attachments'] = JSON.parse(result['attachments']);
                return result;
            })
            .sort(() => Math.random() - 0.5);
        
        let posts = sortedItems;
        let enabled = await isEnabled(FEATURE_FLAGS.BREEZE_CATEGORY_EXPERIMENT, args.metadata);
        if (enabled) {
            posts = [];
            const cateConfig = getConfig(CONFIG_CATEGORIZATION);
            const categorizations = [];
            [
                cateConfig[CATEGORIZATION.BUSINESS_AND_STARTUP],
                cateConfig[CATEGORIZATION.SCIENCE_AND_TECHNOLOGY],
            ].forEach(c => c && categorizations.push(c.id));
            categorizations && sortedItems.forEach(p => {
                if (categorizations.indexOf(p.postCategorizationId) !== -1) {
                    posts.unshift(p);
                } else {
                    posts.push(p);
                }
            }); 
        } 

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