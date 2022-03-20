import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toktik/common/events.dart';
import 'package:toktik/common/strings.dart';
import 'package:toktik/controller/event_controller.dart';
import 'package:toktik/enum/report.dart';

import '../../controller/not_interested_controller.dart';
import '../../controller/report_controller.dart';

class VideoShareWidget extends StatefulWidget {
  final video;
  final Function? onNotInterested;
  final String pageType;
  VideoShareWidget(
      {Key? key, this.video, this.onNotInterested, required this.pageType})
      : super(key: key);

  @override
  _VideoShareWidgetState createState() {
    return _VideoShareWidgetState();
  }
}

class _VideoShareWidgetState extends State<VideoShareWidget> {
  final EventController eventController = Get.find();
  final ReportController reportController = Get.put(ReportController());
  final NotInterestedController notInterestedController = Get.put(NotInterestedController());

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 90, //设置最小高度（必要）
        maxHeight: 220, //设置最大高度（必要）
      ),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: [
          getTitleLayout(),
          SizedBox(height: 10),
          _getActionsLayout(),
          SizedBox(height: 10),
          Divider(height: 0.5,color: Colors.grey,),
          getCancelLayout()
        ],
      ),
    );
  }

  _getActionsLayout() {
    return Container(
      height: 80,
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          getMenu(_VideoShareWidgetMenuConfig.REPORT, () async {
            await reportController.reportPost(
                widget.video.id, ReportReason.OTHER);
            Navigator.pop(context);
            EasyLoading.showSuccess("Thanks for reporting.");
          }),
          getMenu(_VideoShareWidgetMenuConfig.NOT_INTERESTED, () async {
            var result = await notInterestedController
                .notInterestedPost(widget.video.id);
            if (result != null) {
              Navigator.pop(context);
              widget.onNotInterested?.call();
            }
          }),
          getMenu(_VideoShareWidgetMenuConfig.SHARE, () async {
            // todo: TO customize the bottomsheet with sharing target, we need to rely on this,
            // https://www.youtube.com/watch?v=bWehAFTFc9o
            // https://pub.dev/packages/url_launcher
            if (widget.video == null ||
                widget.video.content == null ||
                widget.video.user == null) return;
            Share.share("${widget.video.content.attachments[0].url}",
                subject:
                    "Check out ${widget.video.user.username}'s video on $APP_NAME.");
          }),
        ]),
      ),
    );
  }

  getMenu(config, callback) {
    return _VideoShareWidgetMenu(
        config: config,
        video: widget.video,
        pageType: widget.pageType,
        callback: callback);
  }

  getTitleLayout() {
    return Container(
      height: 30,
      child: Stack(
        alignment:Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Text('Share',style: TextStyle(fontWeight: FontWeight.normal,color: Color(0xff000000),fontSize: 12),),
          )
        ],
      ),
    );
  }

  getCancelLayout() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 10),
      child: TextButton(
        child: Text(
          _VideoShareWidgetMenuConfig.CANCEL['name']!,
          style: TextStyle(color: Color(0xff2a2a2a), fontSize: 14),
        ),
        onPressed: () {
          Get.back();
          eventController.recordEvent(Event.VIDEO_SHARE_WIDGET_PRESS, {
            EventKey.POST_ID: widget.video!.id,
            EventKey.PAGE_TYPE: widget.pageType,
            EventKey.NAME: _VideoShareWidgetMenuConfig.CANCEL['type'],
            EventKey.VALUE: 1,
          });
        },
      ),
    );
  }
}

class _VideoShareWidgetMenu extends StatelessWidget {
  final Map<String, dynamic> config;
  final video;
  final Function? callback;
  final String pageType;
  final EventController eventController = Get.find();

  _VideoShareWidgetMenu(
      {Key? key,
      required this.config,
      this.callback,
      this.video,
      required this.pageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 85,
        margin: EdgeInsets.only(left: 0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.white, elevation: 0),
          onPressed: () async {
            await callback!();
            eventController.recordEvent(Event.VIDEO_SHARE_WIDGET_PRESS, {
              EventKey.POST_ID: video!.id,
              EventKey.PAGE_TYPE: pageType,
              EventKey.NAME: config['type'],
              EventKey.VALUE: 1,
            });
          },
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffffffff),
                radius: 24,
                backgroundImage: AssetImage(config['img']),

              ),
              SizedBox(
                height: 5,
              ),
              Text(
                config['name'],
                style: TextStyle(color: Color(0xff5c5c5c), fontSize: 10),
                maxLines: 2,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}

class _VideoShareWidgetMenuConfig {
  static const REPORT = {
    'name': 'Report',
    'type': 'REPORT',
    "img": 'assets/images/video_share_widget/report.png',
  };

  static const NOT_INTERESTED = {
    'name': 'Not interested',
    'type': 'NOT_INTERESTED',
    "img": 'assets/images/video_share_widget/not_interested.png',
  };

  static const SHARE = {
    'name': 'Share',
    'type': 'SHARE',
    "img": 'assets/images/video_share_widget/share.png',
  };

  static const Map<String, String> CANCEL = {
    'name': 'Cancel',
    'type': 'CANCEL'
  };
}