import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/page/home_page.dart';
import 'package:toktik/page/message_page.dart';
import 'package:toktik/page/search_page.dart';
import 'package:toktik/page/user_page.dart';
import 'package:toktik/page/widget/main_page_bottom_bar_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';
import 'home_page.dart';

class MainPage extends StatelessWidget {
  final MainPageScrollController _mainPageController = Get.find();
  PageController? _scrollPageController;
  SelfController _selfController = Get.put(SelfController());

  MainPage({PageController? pageController}){
    this._scrollPageController = pageController;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_bottomBarLayout) {
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
          isStringNullOrEmpty(_selfController.loginUserId.value)
            ? Scaffold()
            : UserPage(
              pageController: _scrollPageController,
              isLoginUser: true,
              id: _selfController.loginUserId.value,
            ),
        ],
      ),
      //底部导航
      bottomNavigationBar: MainPageBottomBarWidget(),
    ));
  }
}
