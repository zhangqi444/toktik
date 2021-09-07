import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/net/api.dart';
import 'package:toktik/page/home_page.dart';
import 'package:toktik/page/message_page.dart';
import 'package:toktik/page/search_page.dart';
import 'package:toktik/page/user_page.dart';
import 'package:toktik/page/widget/main_page_bottom_bar_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'home_page.dart';

class MainPage extends StatelessWidget {
  final MainPageScrollController _mainPageController = Get.find();
  PageController _scrollPageController;
  UserController _userController = Get.put(UserController());

  MainPage({PageController pageController}){
    this._scrollPageController = pageController;
  }

  @override
  Widget build(BuildContext context) {
    _userController.getLoginUserUid();
    WidgetsBinding.instance.addPostFrameCallback((_bottomBarLayout) {
      //设置状态栏的颜色和图标模式
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorRes.color_1,
        statusBarIconBrightness: Brightness.dark,
      ));
    });
    return Obx(()=>Scaffold(
      backgroundColor: _mainPageController.indexBottomBarMainPage.value == 0
        ? Colors.black
        : Colors.white,
      body: IndexedStack(
        index: _mainPageController.indexBottomBarMainPage.value,
        children: [
          HomePage(pageController: _scrollPageController),
          SearchPage(),
          MessagePage(),
          UserPage(
            pageController: _scrollPageController,
            isLoginUser: true,
            userModel: loginUserModel
          ),
        ],
      ),
      //底部导航
      bottomNavigationBar: MainPageBottomBarWidget(),
    ));
  }
}
