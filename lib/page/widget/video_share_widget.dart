import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toktik/common/events.dart';
import 'package:toktik/controller/event_controller.dart';
import 'package:toktik/enum/report.dart';

import '../../controller/not_interested_controller.dart';
import '../../controller/report_controller.dart';

class VideoShareWidget extends StatefulWidget {
  var video;
  Function? onNotInterested;
  String? pageType;
  VideoShareWidget({Key? key, this.video, this.onNotInterested, this.pageType}) : super(key: key);

  @override
  _VideoShareWidgetState createState() {
    return _VideoShareWidgetState();
  }
}

class _VideoShareWidgetState extends State<VideoShareWidget> {
  final ReportController reportController = Get.put(ReportController());
  final EventController eventController = Get.find();
  final NotInterestedController notInterestedController = Get.put(NotInterestedController());

  //私信好友名字
  List<String> nameList = [
    '爱丽丝',
    '一条小团团',
    '伊素婉',
    '超级马里奥',
    '肖了个邦',
    '惠子',
  ];
  //分享app名称
  List<String> nameApps = [
    'Facebook',
    'Twitter',
    '朋友圈',
    '微信朋友',
    'QQ空间',
    'QQ好友',
    '多闪',
    '今日头条',
    '微博'
  ];
  //分享app图标
  List<String> imgApps = [
    'assets/images/share_app_sixin.webp',
    'assets/images/share_app_zhuanfa.webp',
    'assets/images/share_app_wx_zone.webp',
    'assets/images/share_app_wx.webp',
    'assets/images/share_app_qq_zone.webp',
    'assets/images/share_app_qq.webp',
    'assets/images/share_app_duoshan.webp',
    'assets/images/share_app_toutiao.webp',
    'assets/images/share_app_weibo.webp',
  ];

  //操作名称
  List<Map<String, dynamic>> actions = [
      {
        "text": _VideoShareWidgetMenuName.REPORT,
        "img": 'assets/images/video_share_widget/report.png',
        "onPressed": (video, reportController, notInterestedController, widget, context, recordEvent) async {
          recordEvent(_VideoShareWidgetMenuName.REPORT);
          await reportController.reportPost(video.id, ReportReason.OTHER);
          Navigator.pop(context);
          EasyLoading.showSuccess("Thanks for reporting.");
        }
      },
    // '保存本地',
    // '收藏',
    // '合拍',
    // '动态壁纸',
    // '不感兴趣',
    // '复制链接',
    // '抖音码',
      {
        "text": _VideoShareWidgetMenuName.NOT_INTERESTED,
        "img": 'assets/images/video_share_widget/not_interested.png',
        "onPressed": (video, reportController, notInterestedController, widget, context, recordEvent) async {
          recordEvent(_VideoShareWidgetMenuName.NOT_INTERESTED);
          var result = await notInterestedController.notInterestedPost(video.id);
          if(result != null) {
            Navigator.pop(context);
            widget.onNotInterested?.call();
          }
        }
      },
      {
        "text": _VideoShareWidgetMenuName.SHARE,
        "img": 'assets/images/video_share_widget/share.png',
        "onPressed": (video, reportController, notInterestedController, widget, context, recordEvent) {
          // todo: TO customize the bottomsheet with sharing target, we need to rely on this,
          // https://www.youtube.com/watch?v=bWehAFTFc9o
          // https://pub.dev/packages/url_launcher
          recordEvent(_VideoShareWidgetMenuName.SHARE);
          if(video == null || video.content == null || video.user == null) return;
          Share.share("${video.content.attachments[0].url}", subject: "Check out ${video.user.username}'s video on Breeze.");
        }
      }
  ];
  //操作图标
  List<String> imgActions = [
    // 'assets/images/share_action_download.webp',
    // 'assets/images/share_action_fav.webp',
    // 'assets/images/share_action_hepai.webp',
    // 'assets/images/share_action_bizhi.webp',
    // 'assets/images/share_action_disLiked.webp',
    // 'assets/images/share_action_copy_url.webp',
    // 'assets/images/share_button.webp',
  ];

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
          _getTitleLayout(),
          SizedBox(height: 10),
          // _getFriendsLayout(),
          // Divider(height: 0.5,color: Colors.grey,),
          // _getAppsLayout(),
          _getActionsLayout(),
          SizedBox(height: 10),
          Divider(height: 0.5,color: Colors.grey,),
          _getBackLayout()
        ],
      ),
    );
  }

  _getTitleLayout() {
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

  _getFriendsLayout() {
    return Container(
      height: 80,
      child: SingleChildScrollView(
        scrollDirection:Axis.horizontal,
        child: Row(
          children: List.generate(18, (index) {
            return Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 24,
                      backgroundImage:AssetImage('assets/images/header_${index%6}.jpg')
                  ),
                  SizedBox(height: 5,),
                  Text(nameList[index%6],style: TextStyle(color: Colors.white,fontSize: 10),)
                ],
              ),
            );
          }
          ),
        ),
      ),
    );
  }

  _getAppsLayout() {
    return Container(
      height: 80,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(nameApps.length, (index) {
            return Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  CircleAvatar(
                      backgroundColor:Colors.transparent,
                      radius: 24,
                      backgroundImage:AssetImage(imgApps[index])
                  ),
                  SizedBox(height: 5,),
                  Text(nameApps[index],style: TextStyle(color: Colors.white,fontSize: 10),)
                ],
              ),
            );
          }
          ),
        ),
      ),
    );
  }

  _getActionsLayout() {
    return Container(
      height: 80,
      alignment:Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(actions.length, (index) {
            return Container(
              width: 80,
              margin: EdgeInsets.only(left: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0
                ),
                onPressed: actions[index]['onPressed'] != null
                    ? () => actions[index]['onPressed'](widget.video, reportController, notInterestedController, widget, context, recordEvent)
                    : (){},
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Color(0xffffffff),
                        radius: 24,
                        backgroundImage:AssetImage(actions[index]['img']),

                    ),
                    SizedBox(height: 5,),
                    Text(actions[index]['text'], style: TextStyle(color: Color(0xff5c5c5c),fontSize: 10),maxLines: 2,textAlign: TextAlign.center,)
                  ],
                ),
              )
            );
          }
          ),
        ),
      ),
    );
  }

  _getBackLayout() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 10),
      child: TextButton(
        child: Text(_VideoShareWidgetMenuName.CANCEL, style: TextStyle(color: Color(0xff2a2a2a), fontSize: 14),),
        onPressed: () { 
          Get.back(); 
          recordEvent(_VideoShareWidgetMenuName.CANCEL);
        },
      ),
    );
  }

  recordEvent(name) {
    eventController.recordEvent(Event.VIDEO_SHARE_WIDGET_CLICK, {
      EventKey.POST_ID: widget.video!.id,
      EventKey.PAGE_TYPE: widget.pageType,
      EventKey.NAME: name
    });
  }
}

class _VideoShareWidgetMenuName {
  static const REPORT = 'Report';
  static const NOT_INTERESTED = 'Not interested';
  static const SHARE = 'Share';
  static const CANCEL = 'Cancel';
}