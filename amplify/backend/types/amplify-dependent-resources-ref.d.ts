export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "toktikf7d4ff65": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string"
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
    }
}