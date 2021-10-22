/* Amplify Params - DO NOT EDIT
	API_TOKTIK_GRAPHQLAPIIDOUTPUT
	API_TOKTIK_LIKETABLE_ARN
	API_TOKTIK_LIKETABLE_NAME
	API_TOKTIK_POSTTABLE_ARN
	API_TOKTIK_POSTTABLE_NAME
	ENV
	REGION
Amplify Params - DO NOT EDIT */

const AWS = require('aws-sdk');
const dynamoDbClient = new AWS.DynamoDB();
const crypto = require('crypto');
const { constants } = require('/opt/internal/index');

exports.handler = async (event, context) => {
    try {
        const input = event['arguments']['input'];
        const likeUserId = input['likeUserId'];
        const likePostId = input['likePostId'];
        const value = input['value'];

        const response = {
            statusCode: 200,
            headers: { "Access-Control-Allow-Origin": "*", }
        };

        let existingLike = await dynamoDbClient.query({
            "TableName": process.env.API_TOKTIK_LIKETABLE_NAME,
            "ScanIndexForward": true,
            "IndexName": "likePostId-likeUserId-index",
            "KeyConditionExpression": "likeUserId = :likeUserId And likePostId = :likePostId",
            "ProjectionExpression": "#id,#value,updatedAt,createdAt",
            "ExpressionAttributeValues": {
              ":likeUserId": { "S": likeUserId },
              ":likePostId": { "S": likePostId },
            },
            "ExpressionAttributeNames": {
              "#id": "id",
              "#value": "value"
            }
        }).promise();
        existingLike = existingLike && existingLike['Count'] === 1 && existingLike['Items'][0];
        const viewId = (existingLike && existingLike.id) ? existingLike.id.S : crypto.randomUUID();
        if(existingLike && existingLike.value.BOOL === value) {
            return {
                value, updatedAt: existingLike.updatedAt.S, createdAt: existingLike.createdAt.S, likePostId, likeUserId, id: viewId,
                ...response
            };
        }

        let updateLikeParam;
        const now = new Date();
        const nowTimestamp = '' + now.getTime();
        const nowISOString = now.toISOString();
        if(existingLike) {
            updateLikeParam = {
                "Update": {
                    "TableName": process.env.API_TOKTIK_LIKETABLE_NAME,
                    "Key": {
                        "id": { "S": existingLike.id.S }
                    },
                    "UpdateExpression": "SET #value = :value, updatedAt = :updatedAt, #lastChangedAt = :lastChangedAt ADD #version :version",
                    "ExpressionAttributeValues": {
                        ":value": { "BOOL": value },
                        ":updatedAt": { "S": nowISOString },
                        ":lastChangedAt": { "N": nowTimestamp },
                        ":version": { "N": '1' }
                    },
                    "ExpressionAttributeNames": {
                        "#value": "value",
                        "#lastChangedAt": "_lastChangedAt",
                        "#version": "_version",
                    },
                }
            };
        } else {
            updateLikeParam = {
              "Put": {
                "TableName": process.env.API_TOKTIK_LIKETABLE_NAME,
                "Item": {
                    "id": { "S": viewId },
                    "value": { "BOOL": value },
                    "likePostId": { "S": likePostId },
                    "likeUserId": { "S": likeUserId },
                    "createdAt": { "S": nowISOString },
                    "updatedAt": { "S": nowISOString },
                    "_lastChangedAt": { "N": nowTimestamp },
                    "_version": { "N": "1" },
                    "__typename": { "S": constants.GRAPHQL_MODEL_NAME.LIKE },
                }
              }
            };
        }

        const updatePostParam = {
            "Update": {
                "TableName": process.env.API_TOKTIK_POSTTABLE_NAME,
                "Key": { "id": { "S": likePostId } },
                "UpdateExpression": " ADD likeCount :likeCount, #version :version SET #lastChangedAt = :lastChangedAt",
                "ExpressionAttributeValues": {
                    ":likeCount": { "N": value ? '1' : '-1' },
                    ":lastChangedAt": { "N": nowTimestamp },
                    ":version": { "N": '1' }
                },
                "ExpressionAttributeNames": {
                    "#lastChangedAt": "_lastChangedAt",
                    "#version": "_version",
                },
            }
        }

        const transactWriteItemsOutput = await dynamoDbClient.transactWriteItems({
            "TransactItems": [updateLikeParam, updatePostParam]
        }).promise();

        return {
            value, upadtedAt: now, createdAt: now, likePostId, likeUserId, id: viewId,
            ...response
        };
    } catch (err) {
        console.log(err);
        return { error: err };
    }
}