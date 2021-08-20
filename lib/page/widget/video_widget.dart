import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/event/stop_play_event.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/page/widget/video_bottom_bar_widget.dart';
import 'package:toktik/page/widget/video_right_bar_widget.dart';
import 'package:toktik/page/widget/video_share_widget.dart';
import 'package:toktik/util/screen_utils.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../res/colors.dart';
import '../../util/screen_utils.dart';
import '../../util/screen_utils.dart';
import 'disk_widget.dart';
import 'like_gesture_widget.dart';

///视频播放列表组件
// ignore: must_be_immutable
class VideoWidget extends StatefulWidget {
  bool showFocusButton;
  double contentHeight;
  Function onClickHeader;
  FeedListList video;
  VideoWidget({Key key, bool this.showFocusButton,this.contentHeight,this.onClickHeader,this.video}) : super(key: key);

  @override
  _VideoWidgetState createState() {
    return _VideoWidgetState();
  }
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _videoPlayerController;
  MainPageScrollController mainController = Get.find();
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.video.content.attachments[0].url);
    _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _playOrPause();

    Application.eventBus.on<StopPlayEvent>().listen((event) {
      _videoPlayerController.pause();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1;
    double videoLayoutWidth;
    double videoLayoutHeight;
    if(_videoPlayerController.value.isInitialized){

      double rateWidthHeightContent = screenWidth(context) / widget.contentHeight;
      double rateWidthContentVideo = screenWidth(context) / _videoPlayerController.value.size.width;
      double heightVideoByRate = _videoPlayerController.value.size.height * rateWidthContentVideo;
      print('视频宽:${_videoPlayerController.value.size.width} 视频高:${_videoPlayerController.value.size.height}');
      print('视频宽高比:${_videoPlayerController.value.size.width/_videoPlayerController.value.size.height}');
      print('屏幕宽:${screenWidth(context)}  高：${screenHeight(context)}');
      print('内容高度:${widget.contentHeight}');
      print('内容宽高比例:$rateWidthHeightContent');
      print('比例:$rateWidthContentVideo');
      print('比例换算视频高度:$heightVideoByRate');
      if(widget.contentHeight > heightVideoByRate ){
        double rateHeightContentVideo = widget.contentHeight /  _videoPlayerController.value.size.height;
        videoLayoutHeight = heightVideoByRate;
        videoLayoutWidth = screenWidth(context);
        scale = widget.contentHeight / videoLayoutHeight;
        print('width:$videoLayoutWidth height:$videoLayoutHeight scale:$scale rate:$rateHeightContentVideo');
      }
    }


    return Scaffold(
      backgroundColor: ColorRes.color_1,
      body: Stack(
        children: [
          LikeGestureWidget(
            onSingleTap: () {
              _playOrPause();
            },
            child: _getVideoPlayer(videoLayoutWidth,videoLayoutHeight,scale),
          ),

          Positioned(
              right: 10,
              bottom: 110,
              child: VideoRightBarWidget(
                video: widget.video,
                showFocusButton: widget.showFocusButton,
                onClickComment: (){
                  showBottomComment();
                },
                onClickShare: (){
                  showBottomShare();
                },
                onClickHeader: (){
                  widget.onClickHeader?.call();
                },
              )),
          Positioned(
              right: 2,
              bottom: 20,
              child: VinylDisk(video: widget.video,)),
          Positioned(
            left: 12,
            bottom: 20,
            child: VideoBottomBarWidget(video: widget.video,),
          )


        ],
      ),
    );
  }

  void _playOrPause() {
    _playing = !_playing;
    if (_playing) {
      _videoPlayerController.play();
    } else {
      _videoPlayerController.pause();
    }
    setState(() {

    });
  }


  _getVideoPlayer(double videoLayoutWidth,double videoLayoutHeight,double scale) {
    return  Stack(
        children: [
          Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: Container(
                width: videoLayoutWidth,
                height: videoLayoutHeight ,
                child: VideoPlayer(_videoPlayerController)),
          ),
        _playing == true? Container() : _getPauseButton(),
        ],
    );
  }

  _getPauseButton() {
    return Center(
        child: Container(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/images/pause.webp',
              fit: BoxFit.fill,
            )
        )
    );
  }

  //展示评论
  void showBottomComment() {
    EasyLoading.showToast('评论列表待开发');
    // showModalBottomSheet(
    //     context: context,
    //     isScrollControlled: true, //可滚动 解除showModalBottomSheet最大显示屏幕一半的限制
    //     shape: RoundedRectangleBorder(borderRadius: const BorderRadius.only(
    //       topLeft: Radius.circular(10),
    //       topRight: Radius.circular(10),
    //     ),),
    //     builder: (context){
    //       return VideoCommentWidget(commentList:widget.videoModel.commentList);
    //     });
  }

  //展示分享布局
  void showBottomShare() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, //可滚动 解除showModalBottomSheet最大显示屏幕一半的限制
        shape: RoundedRectangleBorder(borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),),
        backgroundColor: ColorRes.color_1,
        builder: (context){
          return VideoShareWidget();
        });
  }



}