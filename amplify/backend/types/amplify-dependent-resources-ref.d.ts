export type AmplifyDependentResourcesAttributes = {
    "api": {
        "toktik": {
            "GraphQLAPIIdOutput": "string",
            "GraphQLAPIEndpointOutput": "string"
        }
    },
    "auth": {
        "toktikf7d4ff65": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string",
            "CreatedSNSRole": "string"
        }
    },
    "analytics": {
        "toktik": {
            "Region": "string",
            "Id": "string",
            "appName": "string"
        }
    },
    "function": {
        "listPostExs": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "toktikgraphqlLambdaLayer": {
            "Arn": "string"
        },
        "likePost": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        },
        "viewPost": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        }
    },
    "predictions": {
        "toktikTranscription": {
            "region": "string",
            "language": "string"
        }
    }
}