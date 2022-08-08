<img src="https://user-images.githubusercontent.com/5424267/183344233-05793e9f-8dff-46ac-bbde-33a6072403b4.png" alt="Gugu logo" width="100" height="100" align="right" />


# Toktik

> Toktik is a TikTok clone built by Flutter and AWS Amplify.
>
> ‼️ **This project is better to be used as sample code for learning purpose, instead of an application in production.**

<p align="left">
  <img src="https://img.shields.io/badge/flutter->=2.12.0 <3.0.0-brightgreen"/>
  <img src="https://img.shields.io/badge/platforms-ios%20%7C%20android-blue"/>
  <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="Gugu is released under the MIT license." />
  <img src="https://img.shields.io/badge/maintained%3F-no-red.svg" alt="Gugu is not under maintained anymore." />
  <img src="https://img.shields.io/badge/ask%20me-anything-1abc9c.svg" alt="Ask Me Anything." />
</p>


<img src="https://user-images.githubusercontent.com/5424267/183352712-f76229ef-c18b-48fc-a5e4-fb25f4a78987.gif" alt="Gugu logo" width="20%" align="right" />

## Tech stack

- [flutter](https://flutter.dev/) - Android & iOS
- [AWS Amplify](https://aws.amazon.com/amplify/)
- [GraphQL](https://graphql.org/)

## Contribution

### Set up

1. IDE Set up - add support for [no sound null safety](
https://stackoverflow.com/questions/64917744/cannot-run-with-sound-null-safety-because-dependencies-dont-support-null-safety).
2. set up [amplify CLI](https://docs.amplify.aws/start/getting-started/installation/q/integration/flutter/#option-2-follow-the-instructions). When setting amplify, you will be asked to specify aws region, choose the following option: `us-west-2` or your desired AWS region.
3. init amplify by `amplify pull --appId YOUR_AWS_AMPLIFY_APP_ID --envName staging`


### Env
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

### FAQ
<details>
  <summary>Click to expand!</summary>
  
#### How to reset Amplify Auth?
1. `amplify remove auth`
2. `amplify add auth`
3. `amplify update api`

https://github.com/aws-amplify/amplify-cli/issues/1805
https://github.com/aws-amplify/amplify-cli/issues/3802 

#### How to auto generate model file under `lib/generated`?

> right click on package -> `New`->`Dart bean clas file from JSON`
> If you change the fields in the class, just press the shortcut alt + j to regenerate the tojson and fromjson methods. 

Please follow https://plugins.jetbrains.com/plugin/11415-flutterjsonbeanfactory


#### How to add Lambda and Lambda Layer?
https://docs.amplify.aws/cli/function/layers/#add-shared-code--assets
https://docs.amplify.aws/guides/functions/appsync-operations-to-lambda-layer/q/platform/js/#generate-compatible-code-for-your-layer

#### How to handle cocopod conflict error?
```Error: CocoaPods's specs repository is too out-of-date to satisfy dependencies.
To update the CocoaPods specs, run:
pod repo update

Error running pod install
Error launching application on iPhone 13.
```
Delete the `Podfile.lock`, then run `pod instal` under `/ios` folder.

https://docs.amplify.aws/cli/teams/overview/

#### How to switch amplify backend?

`amplify env checkout prod`

If the backend is not successfully switched, but without seeing any error. Please follow below steps,

1. delete `amplify/#current-cloud-backend` folder.
2. run `amplify init`, and you may see error message here.
3. run `amplify pull --appId YOUR_APP_ID --envName YOUR_ENV`

https://docs.amplify.aws/cli/teams/overview/
https://docs.aws.amazon.com/amplify/latest/userguide/team-workflows-with-amplify-cli-backend-environments.html

#### How to build ios and apk?
`flutter clean && flutter build apk`
`flutter clean && flutter build ios`


#### How to update auth for a specific service?
Here is an example for Pinpoint Analytics.
```
    "PinpointAnalytics": {
        "Default": {
            "AppId": "c4924c6194264abc941704cf721dcf07",
            "Region": "us-west-2",
            "AuthMode": "API_KEY", // update the default auth method to API_KEY based
            "ApiKey": "da2-gtckkpdfdfc5ze2wcd6mbkjjoa",
            "ClientDatabasePrefix": "toktik_API_KEY"
        }
    },
```

#### How to set up S3 service logging?
https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-s3-access-logs-to-identify-requests.html#querying-s3-access-logs-for-requests

#### How to override Amplify config?
https://aws.amazon.com/blogs/mobile/override-amplify-generated-backend-resources-using-cdk/

#### How to solve the amplify push failure if schema.graphql syntax is wrong in cloud?
If the `schema.graphql` has syntax error, it may be abled to be deployed still. This will result in failure for all future amplify push. For example an error message,

`🛑 Your GraphQL schema is invalid. Update the schema to use proper syntax and try again.`

Solution: https://github.com/aws-amplify/amplify-cli/issues/8439

</details>

## Discussions

Please open an issue for any questions，and I will respond as soon as possible。

## Contributors

[@Pas0412](https://github.com/Pas0412), [@zhangqi444](https://github.com/zhangqi444), [@zyc95 修仙大橙子](https://github.com/zyc95)

## 📄 License

This project is MIT licensed.

