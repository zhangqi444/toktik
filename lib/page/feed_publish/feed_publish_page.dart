import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:aws_lambda_api/lambda-2015-03-31.dart' hide State;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toktik/net/api.dart';
import 'package:toktik/page/feed_publish/feed_draft_widget.dart';
import 'package:toktik/page/feed_publish/feed_post_widget.dart';
import 'package:toktik/page/feed_publish/feed_transcript_selection_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart' hide Response;
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../enum/navigation_argument.dart';

///发布视频页面
class FeedPublishPage extends StatefulWidget {
  FeedPublishPage({
    Key? key,
  }) : super(key: key);

  @override
  _FeedPublishPageState createState() {
    return _FeedPublishPageState();
  }
}

class _FeedPublishPageState extends State<FeedPublishPage> {
  int currentScreenIdx = 0;
  late String podcastUrl;
  late File videoFile;
  String? coverPath;
  AppBar? _appBar;
  // TextEditingController _editingController = TextEditingController();
  // UploadController _uploadController = Get.put(UploadController());
  // FeedController _feedController = Get.put(FeedController());

  Map<String, dynamic>? podcastEpisode;
  Map<String, dynamic>? podcastCollection;

  String? subtitleFileUri;

  @override
  void initState() {
    super.initState();
    podcastUrl = Get.parameters[NavigationArgument.PODCAST_URL.toShortString()]!;
    _getDataFromPodcastUrl();
    // _getCoverImgPath();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appBar = _getAppBar(context);

    return Scaffold(
      backgroundColor: ColorRes.light_background_color,
      appBar: _appBar,
      body: _getBody(context),
    );
  }

  _getCoverImgPath() async {
    await VideoThumbnail.thumbnailFile(video: podcastUrl, quality: 100)
        .then((value) {
      setState(() {
        coverPath = value;
      });
    });
  }

  _getDataFromPodcastUrl() async {
    if (podcastUrl.contains("podcasts.apple.com")) {
      Uri podcastUrlObj = Uri.parse(podcastUrl);

      // apple podcast url has the form of https://podcasts.apple.com/us/podcast/.../id<podcastId>?i=<podcastEpisodeId>
      String podcastId = podcastUrlObj
          .pathSegments[podcastUrlObj.pathSegments.length - 1]
          .substring(2);
      String podcastEpisodeId = podcastUrlObj.queryParameters['i'] ?? "";
      print("$podcastId $podcastEpisodeId");

      Dio dio = Dio();
      try {
        Response<String> response = await dio.get(
            'https://itunes.apple.com/lookup?id=$podcastId&entity=podcastEpisode&media=podcast');
        Map<String, Object> data = json.decode(response.data!);

        List<Object> results = data['results'] as List<Object>;

        setState(() {
          podcastEpisode = results.firstWhere((r) {
            var result = r as Map<String, Object>;
            return result['wrapperType'] == 'podcastEpisode' &&
                result['trackId'].toString() == podcastEpisodeId;
          }) as Map<String, dynamic>;
          podcastCollection = results.firstWhere((r) {
            var result = r as Map<String, Object>;
            return result['wrapperType'] == 'track' &&
                result['trackId'].toString() == podcastId;
          }) as Map<String, dynamic>;
        });
      } catch (e) {}

      return;
    }
  }

  _getBody(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
        ),
        child: _getPage());
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      elevation: currentScreenIdx == 0 ? 0 : 4,
      backgroundColor: ColorRes.light_background_color,
      title: Text(
        currentScreenIdx == 0
            ? ""
            : currentScreenIdx == 1
                ? "Select Clip like copy & paste"
                : "Share",
        style: TextStyle(color: ColorRes.light_foreground_color, fontSize: 16),
      ),
      leading: currentScreenIdx != 0
          ? TextButton(
              onPressed: () {
                setState(() {
                  currentScreenIdx--;
                });
              },
              child: Image.asset('assets/images/login/nav-arrow-left.png',
                  color: ColorRes.light_foreground_color,
                  width: 24,
                  height: 24),
            )
          : null,
      centerTitle: true,
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: ColorRes.light_foreground_color,
              size: 24,
            ))
      ],
    );
  }

  Widget? _getPage() {
    switch (currentScreenIdx) {
      case 0:
        return podcastEpisode != null
            ? FeedDraftWidget(
                onNext: () async {
                  //
                  CognitoAuthSession session =
                      await Amplify.Auth.fetchAuthSession(
                          options: CognitoSessionOptions(
                              getAWSCredentials: true)) as CognitoAuthSession;

                  AwsClientCredentials cred = AwsClientCredentials(
                      accessKey: session.credentials?.awsAccessKey ?? "",
                      secretKey: session.credentials?.awsSecretKey ?? "",
                      sessionToken: session.credentials?.sessionToken);
                  final Lambda service =
                      Lambda(region: "us-west-2", credentials: cred);

                  List<int> list =
                      '{"arguments": { "input": {"audioUrl": "https://rss.art19.com/episodes/fbc430c2-546e-424f-9528-ce3588fed951.mp3" }}}'
                          .codeUnits;
                  print("start lambda");
                  InvocationResponse lambdaResponse = await service.invoke(
                      functionName: "transcribeAudioPart-margit",
                      invocationType: InvocationType.requestResponse,
                      payload: Uint8List.fromList(list));

                  setState(() {
                    this.subtitleFileUri = json.decode(String.fromCharCodes(
                        lambdaResponse.payload!))['subtitleFileUri'];
                    currentScreenIdx++;
                  });
                },
                podcastName: podcastEpisode!['trackName'],
                podcastArtistName: podcastCollection!['artistName'],
                podcastLengthMillis: podcastEpisode!['trackTimeMillis'],
                podcastDescription: podcastEpisode!['description'],
                podcastReleaseDate: podcastEpisode!['releaseDate'],
              )
            : null;
      case 1:
        return subtitleFileUri != null
            ? FeedTranscriptSelectionWidget(
                onNext: () {
                  setState(() {
                    currentScreenIdx++;
                  });
                },
                subtitleFileUri: subtitleFileUri!)
            : null;
      case 2:
        return FeedPostWidget();
      default:
        throw UnimplementedError();
    }
  }
}
