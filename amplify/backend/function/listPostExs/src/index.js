/* Amplify Params - DO NOT EDIT
	API_TOKTIK_COMMENTTABLE_ARN
	API_TOKTIK_COMMENTTABLE_NAME
	API_TOKTIK_GRAPHQLAPIIDOUTPUT
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

exports.handler = async (event) => {
    // TODO implement
    const response = {
        statusCode: 200,
    //  Uncomment below to enable CORS requests
    //  headers: {
    //      "Access-Control-Allow-Origin": "*",
    //      "Access-Control-Allow-Headers": "*"
    //  }, 
        body: JSON.stringify('Hello from Lambda!'),
    };
    return response;
};
