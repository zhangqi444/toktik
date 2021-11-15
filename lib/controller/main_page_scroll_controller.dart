import 'package:toktik/model/response/feed_list_response.dart';
import 'package:get/get.dart';
import 'package:toktik/net/api.dart';
///用来控制首页滑动、存储当前播放视频的用户model数据
class MainPageScrollController extends GetxController{

  var amplifyConfigured = false.obs;

  //MainPage的底部导航当前选中bar的位置
  var indexBottomBarMainPage = 0.obs;

  //ScrollPage是否可以滑动
  // TODO: 暂时封闭滑动展示个人信息 待个人信息可展示时再打开
  var scrollPageViewScrollPage = false.obs;

  //视频播放页的高度
  var videoViewHeight = 0.0.obs;

  //当前播放视频的用户model
  var userIdCurrent = "".obs;

  //设置当前播放视频的用户model
  void setCurrentUserOfVideo(FeedListListUser userInfo){
    userIdCurrent.value = userInfo.id;
  }

  //设置视频播放页视频的高度
  void setVideoViewHeight(double height){
    videoViewHeight.value = height;
  }

  void setAmplifyConfigured(bool amplifyConfigured) {
    this.amplifyConfigured.value = amplifyConfigured;
  }

  //MainPage底部导航选中指定的bar
  void selectIndexBottomBarMainPage(int index){
    if(index == 0 || index == 1){
      updateScrollPageScrollState(true);
    }else{
      updateScrollPageScrollState(false);
    }
    indexBottomBarMainPage.value = index;
  }

  //ScrollPage的PageView是否可以滑动
  void updateScrollPageScrollState(bool scroll){
    scrollPageViewScrollPage.value = scroll;
  }

  void recordEvent(String eventName,  Map<String, dynamic> events) {
    Api.recordEvent(eventName, events);
  }

}