# toktik

## Set up
### 1. set up amplify CLI
https://docs.amplify.aws/start/getting-started/installation/q/integration/flutter/#option-2-follow-the-instructions

When setting amplify,you will be asked to specify aws region,choose the following option:
us-west-2

### 2. init amplify
`amplify pull --appId d1mt6rg0ztrl8w --envName staging`


## FAQ

### How to reset Amplify Auth?
1. `amplify remove auth`
2. `amplify add auth`
3. `amplify update api`

https://github.com/aws-amplify/amplify-cli/issues/1805
https://github.com/aws-amplify/amplify-cli/issues/3802 

### How to auto generate model file under `lib/generated`?

> right click on package -> `New`->`Dart bean clas file from JSON`
> If you change the fields in the class, just press the shortcut alt + j to regenerate the tojson and fromjson methods. 

Please follow https://plugins.jetbrains.com/plugin/11415-flutterjsonbeanfactory


### How to add Lambda and Lambda Layer?
https://docs.amplify.aws/cli/function/layers/#add-shared-code--assets
https://docs.amplify.aws/guides/functions/appsync-operations-to-lambda-layer/q/platform/js/#generate-compatible-code-for-your-layer