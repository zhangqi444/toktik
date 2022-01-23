import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/application.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/event/stop_play_event.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';
import 'package:toktik/util/tik_tok_icons_icons.dart';

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
              menuButton(
                  'Home',
                  Image.asset("assets/images/main_page_bottom_icon/home.png"),
                  Image.asset("assets/images/main_page_bottom_icon/home-active.png"), 0),
              SizedBox(width: 1),
              menuButton(
                  'Live',
                  mainPageScrollController.indexBottomBarMainPage == 0
                      ? Image.asset("assets/images/main_page_bottom_icon/live-dark.png")
                      : Image.asset("assets/images/main_page_bottom_icon/live.png"),
                  Image.asset("assets/images/main_page_bottom_icon/live-active.png"), 1),
              SizedBox(width: 3.5),
              customCreateIcon,
              SizedBox(width: 3.5),
              menuButton(
                  'Message',
                  mainPageScrollController.indexBottomBarMainPage == 0
                      ? Image.asset("assets/images/main_page_bottom_icon/message-dark.png")
                      : Image.asset("assets/images/main_page_bottom_icon/message.png"),
                  Image.asset("assets/images/main_page_bottom_icon/message-active.png"), 2),
              SizedBox(width: 1),
              menuButton(
                  'Profile',
                  mainPageScrollController.indexBottomBarMainPage == 0
                      ? Image.asset("assets/images/main_page_bottom_icon/profile-dark.png")
                      : Image.asset("assets/images/main_page_bottom_icon/profile.png"),
                  Image.asset("assets/images/main_page_bottom_icon/profile-active.png"), 3),
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
        // TODO: disable publish page
        EasyLoading.showToast("This feature is coming soon.",
            duration: Duration(seconds: 3));
        return;
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

  Widget menuButton(String text, Image icon, Image icon_active, int index) {
    return GestureDetector(
        onTap: () {
          // TODO: disable bottom tab for now.
          // EasyLoading.showToast("This feature is coming soon.",
          //     duration: Duration(seconds: 3));
          // return;
          if (index == 0 || index == 1) {
            mainPageScrollController.selectIndexBottomBarMainPage(index);
          } else {
            var loginUserInfo = userController.userExMap[_selfController.loginUserId.value];
            if(loginUserInfo != null) {
              mainPageScrollController.selectIndexBottomBarMainPage(index);
            } else {
              Application.eventBus.fire(StopPlayEvent());
              Get.toNamed(Routers.login);
            }
          }
        },
        child: Container(
              height: 45,
              width: 45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  mainPageScrollController.indexBottomBarMainPage == index
                      ? icon_active
                      : icon,
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontWeight:
                            mainPageScrollController.indexBottomBarMainPage ==
                                    index
                                ? FontWeight.bold
                                : FontWeight.normal,
                        color:
                            mainPageScrollController.indexBottomBarMainPage == 0
                                ? (mainPageScrollController.indexBottomBarMainPage == index
                                        ? Color(0xffffffff) : Color(0xff8b8b8b))
                                : (mainPageScrollController.indexBottomBarMainPage == index
                                        ? Color(0xff2A2A2A) : Color(0xff2A2A2A)),
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
