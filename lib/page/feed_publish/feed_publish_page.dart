import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toktik/page/feed_publish/feed_draft_widget.dart';
import 'package:toktik/page/feed_publish/feed_post_widget.dart';
import 'package:toktik/page/feed_publish/feed_transcript_selection_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart' hide Response;

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
  List<String> titleList = ['', 'Select Clip like copy & paste', 'Share'];

  int currentScreenIdx = 0;
  late String podcastUrl;
  late File videoFile;
  String? coverPath;
  AppBar? _appBar;

  PodcastEpisodeData? podcastEpisodeData;

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

  _getDataFromPodcastUrl() async {
    Uri podcastUrlObj = Uri.parse(podcastUrl);
    if (podcastUrl.contains("podcasts.apple.com")) {
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

        var podcastEpisode = results.firstWhere((r) {
          var result = r as Map<String, Object>;
          return result['wrapperType'] == 'podcastEpisode' &&
              result['trackId'].toString() == podcastEpisodeId;
        }) as Map<String, dynamic>;
        var podcastCollection = results.firstWhere((r) {
          var result = r as Map<String, Object>;
          return result['wrapperType'] == 'track' &&
              result['trackId'].toString() == podcastId;
        }) as Map<String, dynamic>;
        setState(() {
          podcastEpisodeData = PodcastEpisodeData(
              name: podcastEpisode['trackName'] as String,
              author: podcastCollection['artistName'] as String,
              thumbnailUrl: podcastEpisode['artworkUrl160'] as String,
              description: podcastEpisode['description'] as String,
              lengthMillis: podcastEpisode['trackTimeMillis'] as int,
              releaseDate:
                  DateTime.parse(podcastEpisode['releaseDate'] as String),
              audioUrl: podcastEpisode["episodeUrl"] as String);
        });
      } catch (e) {}

      return;
    }

    // inform users that their URL is not yet supported
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content:
              Text('The URL that you share is not supported at the moment'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        titleList[currentScreenIdx],
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
        return podcastEpisodeData != null
            ? FeedDraftWidget(
                onNext: (String subtitleUri) {
                  setState(() {
                    this.subtitleFileUri = subtitleUri;
                    currentScreenIdx++;
                  });
                },
                podcastName: podcastEpisodeData!.name,
                podcastArtistName: podcastEpisodeData!.author,
                podcastLengthMillis: podcastEpisodeData!.lengthMillis,
                podcastDescription: podcastEpisodeData!.description,
                podcastReleaseDate: podcastEpisodeData!.releaseDate,
                podcastThumbnail: podcastEpisodeData!.thumbnailUrl,
                podcastAudioUrl: podcastEpisodeData!.audioUrl,
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

class PodcastEpisodeData {
  late String name;
  late String author;
  late String thumbnailUrl;
  late String description;
  late int lengthMillis;
  late DateTime releaseDate;
  late String audioUrl;

  PodcastEpisodeData({
    required this.name,
    required this.author,
    required this.thumbnailUrl,
    required this.description,
    required this.lengthMillis,
    required this.releaseDate,
    required this.audioUrl,
  });
}
