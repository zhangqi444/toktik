import { AmplifyAuthCognitoStackTemplate } from '@aws-amplify/cli-extensibility-helper';

export function override(resources: AmplifyAuthCognitoStackTemplate) {
    resources.userPool.aliasAttributes = ['email', 'phone_number', 'preferred_username'];
}
