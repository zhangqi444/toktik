import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/controller/feed_controller.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/recommend_page_controller.dart';
import 'package:toktik/event/amplify_configured_event.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/page/widget/video_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///首页tab推荐
class HomeTabRecommendPage extends StatefulWidget {
  double contentHeight;
  PageController pageController;
  HomeTabRecommendPage({Key key, this.contentHeight, this.pageController}) : super(key: key);

  @override
  _HomeTabRecommendPageState createState() {
    return _HomeTabRecommendPageState();
  }
}

class _HomeTabRecommendPageState extends State<HomeTabRecommendPage> with AutomaticKeepAliveClientMixin {
  RecommendPageController _controller = Get.put(RecommendPageController());
  MainPageScrollController _mainController = Get.find();
  PageController _pageController = PageController(initialPage: 0, keepPage: true);
  FeedController _feedController = Get.put(FeedController());
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  var amplifyConfiguredListner;

  @override
  void initState() {
    super.initState();
    if(!Amplify.isConfigured) {
      amplifyConfiguredListner = Application.eventBus.on<AmplifyConfiguredEvent>().listen((event) {
        _feedController.refreshHotFeedList(_refreshController);
      });
    } else {
      _feedController.refreshHotFeedList(_refreshController);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _refreshController.dispose();
    amplifyConfiguredListner && amplifyConfiguredListner.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorRes.color_1,
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: (){_feedController.refreshHotFeedList(_refreshController);},
        onLoading: (){_feedController.getHotFeedList(_refreshController);},
        child: _getVideoList(context),
      )
    );
  }

  _getVideoList(BuildContext context) {
    return Obx((){
      List<FeedListList> videoList = _feedController.hotFeedList;
      if(null == videoList || videoList.length == 0){
        return Container(color: ColorRes.color_1);
      } else {
        return PageView.builder(
          controller: _pageController,
          itemCount: videoList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return VideoWidget(
              video: videoList[index],
              showFocusButton: true,
              contentHeight: widget.contentHeight,
              onClickHeader: (){
                _mainController.setCurrentUserOfVideo(videoList[index].user);
                widget.pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.linear);
              },
            );
          },
          onPageChanged: (index){
            _mainController.setCurrentUserOfVideo(videoList[index].user);
          },
        );
      }

    });
  }

  /**
   * To stop the page from rebuilding, please follow this
   * https://developpaper.com/three-ways-to-keep-the-state-of-the-original-page-after-page-switching-by-flutter/
   */
  @override
  bool get wantKeepAlive => true;
}
