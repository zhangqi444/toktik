import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toktik/controller/feed_controller.dart';
import 'package:toktik/controller/upload_controller.dart';
import 'package:toktik/page/feed_publish/feed_draft_widget.dart';
import 'package:toktik/page/feed_publish/feed_post_widget.dart';
import 'package:toktik/page/feed_publish/feed_transcript_selection_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:toktik/util/camera_util.dart';
import 'package:toktik/util/video_util.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
  String? videoFilePath;
  late File videoFile;
  String? coverPath;
  AppBar? _appBar;
  TextEditingController _editingController = TextEditingController();
  UploadController _uploadController = Get.put(UploadController());
  FeedController _feedController = Get.put(FeedController());

  @override
  void initState() {
    super.initState();
    videoFilePath = Get.parameters['videoPath'];
    videoFile = File(videoFilePath!);
    _getCoverImgPath();
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
    await VideoThumbnail.thumbnailFile(video: videoFilePath!, quality: 100)
        .then((value) {
      setState(() {
        coverPath = value;
      });
    });
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

  Widget _getPage() {
    switch (currentScreenIdx) {
      case 0:
        return FeedDraftWidget(onNext: () {
          setState(() {
            currentScreenIdx++;
          });
        });
      case 1:
        return FeedTranscriptSelectionWidget(onNext: () {
          setState(() {
            currentScreenIdx++;
          });
        });
      case 2:
        return FeedPostWidget();
      default:
        throw UnimplementedError();
    }
  }
}
