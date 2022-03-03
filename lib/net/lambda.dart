import 'dart:convert';
import 'dart:typed_data';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart';

class LambdaWrapper {
  static Future<String> transcribeAudioPart(
      String audioUrl, int startTimeSeconds, int lengthSeconds) async {
    CognitoAuthSession session = await Amplify.Auth.fetchAuthSession(
            options: CognitoSessionOptions(getAWSCredentials: true))
        as CognitoAuthSession;

    AwsClientCredentials cred = AwsClientCredentials(
        accessKey: session.credentials?.awsAccessKey ?? "",
        secretKey: session.credentials?.awsSecretKey ?? "",
        sessionToken: session.credentials?.sessionToken);
    final Lambda service = Lambda(region: "us-west-2", credentials: cred);

    List<int> list =
        '{"arguments": { "input": {"audioUrl": "$audioUrl", "startTime": $startTimeSeconds, "length": $lengthSeconds }}}'
            .codeUnits;
    InvocationResponse lambdaResponse = await service.invoke(
        functionName: "transcribeAudioPart",
        invocationType: InvocationType.requestResponse,
        payload: Uint8List.fromList(list));

    var respData = json.decode(String.fromCharCodes(lambdaResponse.payload!));

    if (respData["subtitleFileUri"] == null) {
      // ignore: todo
      // TODO: show error dialog
      throw Exception('cannot transcribe the input audio');
    }

    return respData["subtitleFileUri"] as String;
  }
}
