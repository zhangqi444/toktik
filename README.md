# toktik

## Set up
### 1. set up amplify CLI
https://docs.amplify.aws/start/getting-started/installation/q/integration/flutter/#option-2-follow-the-instructions

When setting amplify,you will be asked to specify aws region,choose the following option:
us-west-2

### 2. init amplify
`amplify pull --appId d1mt6rg0ztrl8w --envName staging`


## FAQ

### how to reset Auth.
1. `amplify remove auth`
2. `amplify add auth`
3. `amplify update api`

https://github.com/aws-amplify/amplify-cli/issues/1805
https://github.com/aws-amplify/amplify-cli/issues/3802 