import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/common/types.dart';
import 'package:toktik/controller/feed_controller.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/home_tab_recommend_page_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/event/amplify_configured_event.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/page/widget/video_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

import '../common/router_manager.dart';
import '../enum/navigation_argument.dart';

///首页tab推荐
class HomeTabRecommendPage extends StatefulWidget {
  double? contentHeight;
  PageController? pageController;
  HomeTabRecommendPage({Key? key, this.contentHeight, this.pageController}) : super(key: key);

  @override
  _HomeTabRecommendPageState createState() {
    return _HomeTabRecommendPageState();
  }
}

class _HomeTabRecommendPageState extends State<HomeTabRecommendPage> with AutomaticKeepAliveClientMixin {
  HomeTabRecommendPageController _controller = Get.put(HomeTabRecommendPageController());
  MainPageScrollController _mainController = Get.find();
  PageController _pageController = PageController(initialPage: 0, keepPage: true);
  SelfController _selfController = Get.put(SelfController());
  var amplifyConfiguredListner;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await _selfController.load();
    _controller.loadFeedList();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    if(amplifyConfiguredListner != null) {
      amplifyConfiguredListner.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorRes.color_1,
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async{ _controller.refreshFeedList(); },
          child: _getVideoList(context),
      )
    );
  }

  _getVideoList(BuildContext context) {
    return Obx((){
      List<FeedListList?>? videoList = _controller.getFeedList();
      if(videoList == null || videoList.length == 0){
        return Container(color: ColorRes.color_1);
      } else {
        return Container(
          child: PageView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: videoList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return VideoWidget(
                video: videoList[index],
                // todo: follow is not supported yet.
                showFocusButton: false,
                contentHeight: widget.contentHeight,
                pageType: PageType.HOME_TAB_RECOMMEND,
                onNotInterested: () {
                  // move to the next video.
                  _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.linear);
                }
              );
            },
            onPageChanged: (index) {
              if(videoList.length - index < 3) {
                _controller.loadFeedList();
              }
            },
          )
        );
      }

    });
  }

  /// To stop the page from rebuilding, please follow this
  /// https://developpaper.com/three-ways-to-keep-the-state-of-the-original-page-after-page-switching-by-flutter/
  @override
  bool get wantKeepAlive => true;
}
