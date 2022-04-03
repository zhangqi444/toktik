// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/common/events.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/common/strings.dart';
import 'package:toktik/controller/event_controller.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/event/stop_play_event.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';
import 'package:toktik/util/tik_tok_icons_icons.dart';

import '../../common/configs.dart';
import '../../enum/navigation_argument.dart';

///首页底部导航
class MainPageBottomBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageBottomBarWidgetState();
  }
}

class _MainPageBottomBarWidgetState extends State<MainPageBottomBarWidget> {
  final MainPageScrollController mainPageScrollController = Get.find();
  final SelfController _selfController = Get.put(SelfController());
  final UserController userController = Get.find();
  final EventController eventController = Get.find();
  //用来获取BottomBar的高度
  final GlobalKey bottomBarKey = GlobalKey();
  late Widget _bottomBarLayout;
  static const double NavigationIconSize = 20.0;
  static const double CreateButtonWidth = 38.0;

  @override
  void initState() {
    super.initState();
    _bottomBarLayout = _getLayoutBottomBar();
    //BottomBar绘制完成时候的监听
    WidgetsBinding.instance!.addPostFrameCallback((_bottomBarLayout) {
      double videoViewHeight = MediaQuery.of(context).size.height -
          bottomBarKey.currentContext!.size!.height;
      mainPageScrollController.setVideoViewHeight(videoViewHeight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _bottomBarLayout;
  }

  _getLayoutBottomBar() {
    return Obx(() => Container(
      key: bottomBarKey,
      height: 54 + (Platform.isIOS ? 40 : 10) * 1.0,
      decoration:
        BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 3.5),
              menuButton(_MainPageBottomBarWidgetConfig.HOME),
                  // todo: disabel unlaunched feature
              // SizedBox(width: 1),
              // menuButton(
              //     'Live',
              //     mainPageScrollController.indexBottomBarMainPage == 0
              //         ? Image.asset("assets/images/main_page_bottom_icon/live-dark.png")
              //         : Image.asset("assets/images/main_page_bottom_icon/live.png"),
              //     Image.asset("assets/images/main_page_bottom_icon/live-active.png"), 1),
              // SizedBox(width: 3.5),
              // customCreateIcon,
              SizedBox(width: 3.5),
              menuButton(mainPageScrollController.indexBottomBarMainPage ==
                      _MainPageBottomBarWidgetConfig.HOME['index']
                  ? _MainPageBottomBarWidgetConfig.FEEDBACK_DARK
                  : _MainPageBottomBarWidgetConfig.FEEDBACK),
              SizedBox(width: 1),
              menuButton(mainPageScrollController.indexBottomBarMainPage ==
                      _MainPageBottomBarWidgetConfig.HOME['index']
                  ? _MainPageBottomBarWidgetConfig.PROFILE_DARK
                  : _MainPageBottomBarWidgetConfig.PROFILE),
              SizedBox(width: 3.5),
            ],
          ),
          SizedBox(
            height: Platform.isIOS ? 40 : 10,
          )
        ],
      ),
    ));
  }

  Widget get customCreateIcon => GestureDetector(
      onTap: () {
        Application.eventBus.fire(StopPlayEvent());
        Get.toNamed(Routers.shoot);
      },
      child: Container(
          width: 45.0,
          height: 45.0,
          alignment: Alignment(0, -1),
          child:
          Image.asset("assets/images/main_page_bottom_icon/create.png", width: 44.0, height: 35.0,)
          // Obx(() => Stack(children: [
          //       Container(
          //           margin: EdgeInsets.only(left: 10.0),
          //           width: CreateButtonWidth,
          //           decoration: BoxDecoration(
          //               color: Color.fromARGB(255, 250, 45, 108),
          //               borderRadius: BorderRadius.circular(7.0))),
          //       Container(
          //           margin: EdgeInsets.only(right: 10.0),
          //           width: CreateButtonWidth,
          //           decoration: BoxDecoration(
          //               color: Color.fromARGB(255, 32, 211, 234),
          //               borderRadius: BorderRadius.circular(7.0))),
          //       Center(
          //           child: Container(
          //         height: double.infinity,
          //         width: CreateButtonWidth,
          //         decoration: BoxDecoration(
          //             color:
          //                 mainPageScrollController.indexBottomBarMainPage == 0
          //                     ? Colors.white
          //                     : Colors.black,
          //             borderRadius: BorderRadius.circular(7.0)),
          //         child:
          //         Icon(
          //           Icons.add,
          //           color: mainPageScrollController.indexBottomBarMainPage == 0
          //               ? Colors.black
          //               : Colors.white,
          //           size: 20.0,
          //         ),
          //       )),
          //     ]))
      ));

  Widget menuButton(config) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          var index = config['index'];
          eventController.recordEvent(
            Event.MAIN_PAGE_BOTTOM_BAR_PRESS, event: {
            EventKey.INDEX: config['index'],
            EventKey.NAME: config['type'],
            EventKey.VALUE: 1
          });
          if (index == 0) {
            mainPageScrollController.selectIndexBottomBarMainPage(index);
          } else if (index == 1) {
            Get.toNamed(Routers.webView, arguments: { NavigationArgument.URL: FEEDBACK_URL });
          } else {
            var loginUserInfo = userController.userExMap[_selfController.loginUserId.value];
            if(loginUserInfo != null) {
              mainPageScrollController
                  .selectIndexBottomBarMainPage(index);
            } else {
              Application.eventBus.fire(StopPlayEvent());
              Get.toNamed(Routers.login);
            }
          }
        },
        child: Container(
          height: 45,
          width: 100,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              mainPageScrollController.indexBottomBarMainPage.value == config['index']
                  ? Image.asset(config['iconActive'])
                  : Image.asset(config['icon']),
              SizedBox(
                height: 4,
              ),
              Text(
                config['name'],
                style: TextStyle(
                    fontWeight:
                        mainPageScrollController
                                .indexBottomBarMainPage.value ==
                            config['index']
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color:
                        mainPageScrollController.indexBottomBarMainPage.value ==
                                0
                            ? (mainPageScrollController
                                        .indexBottomBarMainPage.value ==
                                    config['index']
                                ? Color(0xffffffff)
                                : Color(0xff8b8b8b))
                            : (mainPageScrollController
                                        .indexBottomBarMainPage.value ==
                                    config['index']
                                ? Color(0xff2A2A2A)
                                : Color(0xff2A2A2A)),
                    fontSize: 10.0),
              )
            ],
          ),
        )
    );
  }

  void setSystemStatusBarStyle(int index) {
    if (index == 3) {
      //设置状态栏的颜色和图标模式
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ));
    } else {
      //设置状态栏的颜色和图标模式
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorRes.color_1,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }
}

class _MainPageBottomBarWidgetConfig {
  static final HOME = {
    'name': 'Home',
    'type': 'HOME',
    'icon': "assets/images/main_page_bottom_icon/home.png",
    'iconActive': "assets/images/main_page_bottom_icon/home-active.png",
    'index': 0,
  };

  static final FEEDBACK = {
    'name': 'Feedback',
    'type': 'FEEDBACK',
    'icon': "assets/images/main_page_bottom_icon/message.png",
    'iconActive': "assets/images/main_page_bottom_icon/message-active.png",
    'index': 1,
  };

  static final FEEDBACK_DARK = {
    ..._MainPageBottomBarWidgetConfig.FEEDBACK,
    'icon': "assets/images/main_page_bottom_icon/message-dark.png",
  };

  static final PROFILE = {
    'name': 'Profile',
    'type': 'PROFILE',
    'icon': "assets/images/main_page_bottom_icon/profile.png",
    'iconActive': "assets/images/main_page_bottom_icon/profile-active.png",
    'index': 2,
  };

  static final PROFILE_DARK = {
    ..._MainPageBottomBarWidgetConfig.PROFILE,
    'icon': "assets/images/main_page_bottom_icon/profile-dark.png",
  };
}
