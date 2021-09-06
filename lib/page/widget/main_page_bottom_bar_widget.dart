import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/common/sp_keys.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/event/stop_play_event.dart';
import 'package:toktik/res/colors.dart';
import 'package:toktik/util/sp_util.dart';
import 'package:get/get.dart';
import 'package:toktik/util/tik_tok_icons_icons.dart';

///首页底部导航
class MainPageBottomBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageBottomBarWidgetState();
  }
}

class _MainPageBottomBarWidgetState extends State<MainPageBottomBarWidget>{

  final MainPageScrollController mainPageScrollController = Get.find();
  //用来获取BottomBar的高度
  final GlobalKey bottomBarKey = GlobalKey();
  Widget _bottomBarLayout;
  static const double NavigationIconSize = 20.0;
  static const double CreateButtonWidth = 38.0;

  @override
  void initState() {
    super.initState();
    _bottomBarLayout = _getLayoutBottomBar();
    //BottomBar绘制完成时候的监听
    WidgetsBinding.instance.addPostFrameCallback((_bottomBarLayout) {
      double videoViewHeight = MediaQuery.of(context).size.height - bottomBarKey.currentContext.size.height;
      mainPageScrollController.setVideoViewHeight(videoViewHeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _bottomBarLayout;
  }

  _getLayoutBottomBar(){
    return Container(
      key: bottomBarKey,
      height: 50 + (Platform.isIOS ? 40 : 10) * 1.0,
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menuButton('Home', TikTokIcons.home, 0),
              menuButton('Search', TikTokIcons.search, 1),
              SizedBox(
                width: 12.5,
              ),
              customCreateIcon,
              SizedBox(
                width: 12.5,
              ),
              menuButton('Messages', TikTokIcons.messages, 2),
              menuButton('Profile', TikTokIcons.profile, 3)
            ],
          ),
          SizedBox(
            height: Platform.isIOS ? 40 : 10,
          )
        ],
      ),
    );
  }

  Widget get customCreateIcon => GestureDetector(
      onTap: () {
        Application.eventBus.fire(StopPlayEvent());
        Get.toNamed(Routers.shoot);
      },
      child: Container(
        width: 45.0,
        height: 27.0,
        child: Obx(() => Stack(children: [
          Container(
              margin: EdgeInsets.only(left: 10.0),
              width: CreateButtonWidth,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 45, 108),
                  borderRadius: BorderRadius.circular(7.0))),
          Container(
              margin: EdgeInsets.only(right: 10.0),
              width: CreateButtonWidth,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 32, 211, 234),
                  borderRadius: BorderRadius.circular(7.0))),
          Center(
              child: Container(
                height: double.infinity,
                width: CreateButtonWidth,
                decoration: BoxDecoration(
                    color: mainPageScrollController.indexBottomBarMainPage == 0
                        ? Colors.white
                        : Colors.black,
                    borderRadius: BorderRadius.circular(7.0)),
                child: Icon(
                  Icons.add,
                  color: mainPageScrollController.indexBottomBarMainPage == 0
                      ? Colors.black
                      : Colors.white,
                  size: 20.0,
                ),
              )),
        ])))
  );

  Widget menuButton(String text, IconData icon, int index) {
    return GestureDetector(
        onTap: () {
          if(index == 0 || index == 1){
            mainPageScrollController.selectIndexBottomBarMainPage(index);
          }else{
            SPUtil.getString(SPKeys.token).then((text){
              String token = text;
              //TODO: bypass the login token check for now
              // if(token != null && token.length > 0){
                mainPageScrollController.selectIndexBottomBarMainPage(index);
              // }else{
              //   Application.eventBus.fire(StopPlayEvent());
              //   Get.toNamed(Routers.login);
              // }
            });
          }
        },
        child: Obx(() => Container(
          height: 45,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon,
                  color: mainPageScrollController.indexBottomBarMainPage == 0
                      ? (mainPageScrollController.indexBottomBarMainPage == index ? Colors.white : Colors.white70)
                      : (mainPageScrollController.indexBottomBarMainPage == index ? Colors.black : Colors.black54),
                  size: NavigationIconSize),
              SizedBox(
                height: 7,
              ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: mainPageScrollController.indexBottomBarMainPage == index ? FontWeight.bold : FontWeight.normal,
                    color: mainPageScrollController.indexBottomBarMainPage == 0
                        ? (mainPageScrollController.indexBottomBarMainPage == index ? Colors.white : Colors.white70)
                        : (mainPageScrollController.indexBottomBarMainPage == index ? Colors.black : Colors.black54),
                    fontSize: 11.0),
              )
            ],
          ),
        )));
  }

  void setSystemStatusBarStyle(int index) {
    if(index == 3 ){
      //设置状态栏的颜色和图标模式
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));

    }else{
      //设置状态栏的颜色和图标模式
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorRes.color_1,
        statusBarIconBrightness: Brightness.dark,
      ));
    }

  }

}
