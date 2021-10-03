import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/common/events.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/post_controller.dart';
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
  PostController _postController = Get.put(PostController());
  bool _playing = false;
  Stopwatch _durationSW = new Stopwatch();
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.video.content.attachments[0].url);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _playOrPause();

    Application.eventBus.on<StopPlayEvent>().listen((event) {
      _videoPlayerController.pause();
    });
    
    mainController.recordEvent(
        EventType.HOME_TAB_RECOMMEND_PAGE_VIEW_VIDEO.toShortString(),
        {Events.VALUE: 1});
    _durationSW.start();
    _postController.viewPost(widget.video.id);

  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _durationSW.stop();
    mainController.recordEvent(
        EventType.HOME_TAB_RECOMMEND_PAGE_VIEW_VIDEO.toShortString(),
        {Events.TIME: _durationSW.elapsedMilliseconds});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.color_1,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          return Stack(
            children: [
              LikeGestureWidget(
                scale: 1.0,
                onSingleTap: () {
                  _playOrPause();
                },
                child: _getVideoPlayer(),
              ),

              // TODO: disable video right widget for now
              // Positioned(
              //     right: 10,
              //     bottom: 110,
              //     child: VideoRightBarWidget(
              //       video: widget.video,
              //       showFocusButton: widget.showFocusButton,
              //       onClickComment: (){
              //         showBottomComment();
              //       },
              //       onClickShare: (){
              //         showBottomShare();
              //       },
              //       onClickHeader: (){
              //         widget.onClickHeader?.call();
              //       },
              //     )),
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
          );
        }
      )
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


  _getVideoPlayer() {
    double scale = 1;
    double videoLayoutWidth;
    double videoLayoutHeight;
    if(_videoPlayerController.value.isInitialized){

      double videoWidth = _videoPlayerController.value.size.width;
      double videoHeight = _videoPlayerController.value.size.height;
      double screenW = screenWidth(context);
      double screenH = screenHeight(context);

      double rateWidthHeightContent = screenW / widget.contentHeight;
      double rateWidthContentVideo = screenW / videoWidth;
      double heightVideoByRate = videoHeight * rateWidthContentVideo;
      print('视频宽:${videoWidth} 视频高:${videoHeight}');
      print('视频宽高比:${videoWidth/videoHeight}');
      print('屏幕宽:${screenW} 高：${screenH}');
      print('内容高度:${widget.contentHeight}');
      print('内容宽高比例:$rateWidthHeightContent');
      print('比例:$rateWidthContentVideo');
      print('比例换算视频高度:$heightVideoByRate');
      if(widget.contentHeight > heightVideoByRate ){
        double rateHeightContentVideo = widget.contentHeight / videoHeight;
        videoLayoutHeight = heightVideoByRate;
        videoLayoutWidth = screenW;
        if(videoWidth < videoHeight) {
          scale = widget.contentHeight / videoLayoutHeight;
        } else {
          scale = screenW / videoLayoutWidth;
        }
        print('width:$videoLayoutWidth height:$videoLayoutHeight scale:$scale rate:$rateHeightContentVideo');
      }

    }
    return  Stack(
        children: [
          Center(
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topCenter,
              child: Container(
                  width: videoLayoutWidth,
                  height: videoLayoutHeight ,
                  child: VideoPlayer(_videoPlayerController)),
            )
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