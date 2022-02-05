import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toktik/controller/feed_controller.dart';
import 'package:toktik/controller/upload_controller.dart';
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
      margin: EdgeInsets.all(16),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
      ),
      child: Stack(
        children: [
          _topLayout(context),
          _bottomLayout(context),
        ],
      ),
    );
  }

  _topLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Episode added to your draft",
          style: TextStyle(
              fontSize: 16,
              color: ColorRes.light_foreground_color,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 27,
        ),
        Row(
          children: [
            Image.network(
              "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_1280.jpg",
              width: 45,
              height: 45,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "In Depth",
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorRes.light_foreground_color,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "First Round",
                  style: TextStyle(fontSize: 16, color: Color(0xff888888)),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
              color: Color(0xfff8f8f8), borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buy or build? Focus on the core product or innovate hey hey hey',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text('Dec 9, 2021',
                      style: TextStyle(fontSize: 10, color: Color(0xff888888))),
                ],
              )),
              Container(
                padding: EdgeInsets.fromLTRB(8, 4, 5, 4),
                decoration: BoxDecoration(
                  color: Color(0xfff4f4f4),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 4,
                        offset: Offset(0, 0)),
                  ],
                ),
                child: Text(
                  "60 min",
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 44,
        ),
        Text(
          "Where were you when you shared the above episode?",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorRes.light_foreground_color),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(23, 14, 23, 14),
          decoration: BoxDecoration(
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "00:00:00",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  _bottomLayout(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 18, 15, 18),
        alignment: Alignment.centerRight,
        child: TextButton(
          child: Text(
            "Next",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            // TODO: scroll forward page view
          },
          style: TextButton.styleFrom(
            backgroundColor: Color(0xff39CBE3),
          ),
        ),
      ),
      // child: InkWell(
      //   onTap: () async {
      //     VideoPlayerValue videoValue =
      //         await VideoUtil.getVideoValue(videoFile);

      //     print(
      //         '发布视频时长:${videoValue.duration.inSeconds}  width:${videoValue.size.width}  height:${videoValue.size.height}');
      //     bool? videoUpload =
      //         await _uploadController.uploadSingleFile('mp4', videoFile);
      //     String? videoUrl =
      //         _uploadController.uploadResponse.tokens![0]!.effectUrl;
      //     print('发布视频：$videoUpload 地址:$videoUrl');
      //     bool? imgUpload = await _uploadController.uploadSingleFile(
      //         CameraUtil.getImgSuffix(coverPath!), File(coverPath!));
      //     String? coverUrl =
      //         _uploadController.uploadResponse.tokens![0]!.effectUrl;
      //     print('发布封面图：$imgUpload 地址:$coverUrl');
      //     _feedController.publishFeed(
      //         _editingController.text,
      //         videoUrl,
      //         coverUrl,
      //         videoValue.duration.inSeconds.toInt(),
      //         videoValue.size.width.toInt(),
      //         videoValue.size.height.toInt());
      //   },
      //   child: Container(
      //     height: 60,
      //     decoration: BoxDecoration(
      //         color: ColorRes.color_3,
      //         borderRadius: BorderRadius.circular(5)),
      //     alignment: Alignment.center,
      //     child: Text(
      //       '发布',
      //       style: TextStyle(color: Colors.white, fontSize: 18),
      //     ),
      //   ),
      // )
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
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
                // TODO: scroll page view back
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
}
