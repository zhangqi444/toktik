/* Amplify Params - DO NOT EDIT
	API_TOKTIK_GRAPHQLAPIIDOUTPUT
	API_TOKTIK_POSTTABLE_ARN
	API_TOKTIK_POSTTABLE_NAME
	API_TOKTIK_VIEWTABLE_ARN
	API_TOKTIK_VIEWTABLE_NAME
	ENV
	REGION
Amplify Params - DO NOT EDIT */

const AWS = require('aws-sdk');
const dynamoDbClient = new AWS.DynamoDB();
const crypto = require('crypto');
const { constants } = require('/opt/internal/index');

exports.handler = async (event, context) => {

    const modelName = constants.GRAPHQL_MODEL_NAME.VIEW;
    const modelNameLowerCase = modelName.toLowerCase();
    const actionTableName = process.env.API_TOKTIK_VIEWTABLE_NAME;

    try {
        const input = event['arguments']['input'];
        const postIdKey = `${modelNameLowerCase}PostId`;
        const userIdKey = `${modelNameLowerCase}UserId`;
        const userId = input[userIdKey] || 'null';
        const postId = input[postIdKey];

        const response = {
            statusCode: 200,
            headers: { "Access-Control-Allow-Origin": "*", }
        };

        const actionId = crypto.randomUUID();

        let updateActionParam;
        const now = new Date();
        const nowTimestamp = '' + now.getTime();
        const nowISOString = now.toISOString();
        updateActionParam = {
            "Put": {
                "TableName": actionTableName,
                "Item": {
                    "id": { "S": actionId },
                    [postIdKey]: { "S": postId },
                    [userIdKey]: { "S": userId },
                    "createdAt": { "S": nowISOString },
                    "updatedAt": { "S": nowISOString },
                    "_lastChangedAt": { "N": nowTimestamp },
                    "_version": { "N": "1" },
                    "__typename": { "S": modelName },
                }
            }
        };

        const postValue = '1';
        const updatePostParam = {
            "Update": {
                "TableName": process.env.API_TOKTIK_POSTTABLE_NAME,
                "Key": { "id": { "S": postId } },
                "UpdateExpression": " ADD #count :count, #version :version SET #lastChangedAt = :lastChangedAt",
                "ExpressionAttributeValues": {
                    ":count": { "N": postValue },
                    ":lastChangedAt": { "N": nowTimestamp },
                    ":version": { "N": '1' }
                },
                "ExpressionAttributeNames": {
                    "#count": `${modelNameLowerCase}Count`,
                    "#lastChangedAt": "_lastChangedAt",
                    "#version": "_version",
                },
            }
        }

        const transactWriteItemsOutput = await dynamoDbClient.transactWriteItems({
            "TransactItems": [updateActionParam, updatePostParam]
        }).promise();

        return {
            upadtedAt: now,
            createdAt: now,
            postIdKey: postId,
            userIdKey: userId,
            id: actionId,
            ...response
        };
    } catch (err) {
        console.log(err);
        return { error: err };
    }
}