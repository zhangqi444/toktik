import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/event/stop_play_event.dart';
// import 'package:toktik/page/home_tab_city_page.dart';
// import 'package:toktik/page/home_tab_focus_page.dart';
import 'package:toktik/page/home_tab_recommend_page.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

///首页
class HomePage extends StatefulWidget {
  PageController _scrollPageController;
  HomePage({PageController pageController}){
    this._scrollPageController = pageController;
  }

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  MainPageScrollController _mainPageScrollController = Get.find();
  TabController _tabController;
  PageController _pageController;
  double _screenHeight;
  double _screenWidth;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 1, vsync: this, initialIndex: 0);
    _pageController = PageController(initialPage: 0, keepPage: true);
    WidgetsBinding.instance.addPostFrameCallback((_bottomBarLayout) {
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //   statusBarColor: Colors.black,
      //   statusBarIconBrightness: Brightness.light,
      // ));
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _getBody(),
    );
  }

  _getBody() {
    return Container(
      width: _screenWidth,
      height:  _screenHeight,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQueryData.fromWindow(window).padding.top,
          ),
          Positioned(
              child: _getContent()),
          // TODO: remove living for now
          // Positioned(
          //     top: MediaQueryData.fromWindow(window).padding.top,
          //     child: _getTopLayout()),
        ],
      ),
    );
  }

  _getTopLayout() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: InkWell(
                onTap: (){
                  Get.toNamed(Routers.living);
                },
                child:  Image.asset('assets/images/live_btn.webp',width: 35,height: 35)
            ),
          ),
          _getTabBar(),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {
                  Application.eventBus.fire(StopPlayEvent());
                  Get.toNamed(Routers.search);
                },
                child: Image.asset('assets/images/search.webp',width: 35,height: 35,color:ColorRes.color_2)
            ),
          ),
        ],
      ),
    );
  }

  //头部：城市、关注、推荐
  _getTabBar() {
    return Container(
      width: 200,
      height: 44,
      alignment: Alignment.center,
      child: TabBar(
        tabs: [
          // Text('杭州'),
          Text('Following'),
          Text('For You'),
        ],
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.only(bottom: 2),
        labelColor: Colors.white,
        unselectedLabelColor: ColorRes.color_2,
        labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
        controller: _tabController,
        onTap: (index){
          _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
        },
      ),
    );
  }

  _getContent() {
    double contentHeight = MediaQuery.of(context).size.height - MediaQueryData.fromWindow(window).padding.top;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: contentHeight,
      ),
      child: NotificationListener(
        child: PageView(
            controller: _pageController,
            children: [
              // TODO: keep only one tab for now.
              // HomeTabCityPage(),
              // HomeTabFocusPage(
              //   contentHeight: contentHeight,
              //   pageController: widget._scrollPageController,),
              HomeTabRecommendPage(
                contentHeight: contentHeight,
                pageController: widget._scrollPageController,
              )
            ],
            onPageChanged: (index) {
              _tabController.animateTo(index);
            }),
        onNotification: (overscroll){
          if (overscroll is OverscrollNotification && overscroll.overscroll != 0 && overscroll.dragDetails != null) {
            if(overscroll.overscroll > 0){
              widget._scrollPageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.linear);
            }else {

            }
          }
          return true;
        },
      ),
    );
  }

  /**
   * To stop the page from rebuilding, please follow this
   * https://developpaper.com/three-ways-to-keep-the-state-of-the-original-page-after-page-switching-by-flutter/
   */
  @override
  bool get wantKeepAlive => true;

}
