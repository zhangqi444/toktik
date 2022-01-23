import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toktik/controller/post_controller.dart';
import 'package:toktik/enum/report.dart';

class VideoShareWidget extends StatefulWidget {
  var video;
  VideoShareWidget({Key? key, this.video}) : super(key: key);

  @override
  _VideoShareWidgetState createState() {
    return _VideoShareWidgetState();
  }
}

class _VideoShareWidgetState extends State<VideoShareWidget> {
  PostController _postController = Get.put(PostController());

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
        "text": 'Report',
        "img": 'assets/images/share_action_jubao.png',
        "onPressed": (video, postController) async {
          await postController.reportPost(video.id, ReportReason.OTHER);
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
        "text":'Share',
        "img": 'assets/images/share_action_share.png',
        "onPressed": (video, postController) {
          // TO customize the bottomsheet with sharing target, we need to rely on this,
          // https://www.youtube.com/watch?v=bWehAFTFc9o
          // https://pub.dev/packages/url_launcher

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
        maxHeight: 160, //设置最大高度（必要）
      ),
      child: Column(
        children: [
          _getTitleLayout(),
          SizedBox(height: 20,),
          // _getFriendsLayout(),
          Divider(height: 0.5,color: Colors.grey,),
          SizedBox(height: 9,),
          // _getAppsLayout(),
          _getActionsLayout(),
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
            left: 16,
            bottom: 0,
            child: Text('Share to',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 14),),
          ),
          Positioned(
              right: 16,
              bottom: 0,
              child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Image.asset('assets/images/bg_cross.webp',width: 25,height: 25,))),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(actions.length, (index) {
            return Container(
              margin: EdgeInsets.only(left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                ),
                onPressed: actions[index]['onPressed'] != null ? () => actions[index]['onPressed'](widget.video, _postController) : (){},
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Color(0x18181818),
                        radius: 24,
                        backgroundImage:AssetImage(actions[index]['img'])
                    ),
                    SizedBox(height: 5,),
                    Text(actions[index]['text'], style: TextStyle(color: Colors.white,fontSize: 10),)
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
}