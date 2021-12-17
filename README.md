# toktik

## Set up
### 1. set up amplify CLI
https://docs.amplify.aws/start/getting-started/installation/q/integration/flutter/#option-2-follow-the-instructions

When setting amplify,you will be asked to specify aws region,choose the following option:
us-west-2

### 2. init amplify
`amplify pull --appId d1mt6rg0ztrl8w --envName staging`


## Env
1. feature branch -> amplify feature env
  - Any new code branch named as feature/** will be connected with an automatically created amplify env.
  - Please use this combination for any local feature testing.
  - Please remove the unused automatically created env whenever the feature branch is merged into master branch..
2. master branch -> amplify staging env
  - Please use this combination for any pre-prod testing. Any production release should be verified through this stage first. 
  - This is the default env connected to the frontend.
3. release branch -> amplify prod env
  - Please use this combination for any production release.
  - Any change must be verified in #2 env first, then merged/promoted into this env.
  - To each release, please create a tag to the commit for tracking the release version.
4. dev branch -> amplify dev env
  - Please use this combination for any local change testing, if you have to deploy it to server side to verify.
  - This is a shared env, so that your local change may be overridden by others. Please use #1 if you have any concern with this.

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

### How to handle cocopod conflict error?
```Error: CocoaPods's specs repository is too out-of-date to satisfy dependencies.
To update the CocoaPods specs, run:
pod repo update

Error running pod install
Error launching application on iPhone 13.
```
Delete the `Podfile.lock`, then run `pod instal` under `/ios` folder.

https://docs.amplify.aws/cli/teams/overview/

### How to switch amplify backend?

`amplify env checkout prod`

https://docs.amplify.aws/cli/teams/overview/

### How to build ios and apk?
`flutter clean && flutter build apk`
`flutter clean && flutter build ios`