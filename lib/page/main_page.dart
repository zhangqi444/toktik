import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/net/api.dart';
// import 'package:toktik/page/friend_page.dart';
import 'package:toktik/page/home_page.dart';
import 'package:toktik/page/message_page.dart';
import 'package:toktik/page/user_page.dart';
import 'package:toktik/page/widget/main_page_bottom_bar_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:toktik/util/sp_util.dart';
import 'package:get/get.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// Generated in previous step
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';
import 'home_page.dart';

class MainPage extends StatelessWidget {
  final MainPageScrollController mainPageController = Get.find();
  PageController _scrollPageController;
  UserController _userController = Get.put(UserController());
  MainPage({PageController pageController}){
    this._scrollPageController = pageController;
    _configureAmplify();
  }

  void _configureAmplify() async {

    final AmplifyDataStore _dataStorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
    final AmplifyAPI _apiPlugin = AmplifyAPI();
    final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();

    await Amplify.addPlugins([
      _dataStorePlugin,
      _apiPlugin,
      _authPlugin
    ]);

    // Once Plugins are added, configure Amplify
    await Amplify.configure(amplifyconfig);
    try {
      mainPageController.setAmplifyConfigured(true);
      Amplify.DataStore.clear();
    } catch (e) {
      print(e);
    }
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
    return Scaffold(
      backgroundColor: mainPageController.indexBottomBarMainPage.value == 0
        ? Colors.black
        : Colors.white,
      body: Obx(()=>_getBody()),
      //底部导航
      bottomNavigationBar:  MainPageBottomBarWidget(),
    );
  }

  _getBody()  {
    switch(mainPageController.indexBottomBarMainPage.value){
      case 0:
        return HomePage(pageController:_scrollPageController);
      case 1:
        // return FriendPage();
      case 2:
        return MessagePage();
      case 3:
        return Obx((){
          int uid = _userController.loginUserUid.value;
          if(uid == 0){
            return UserPage(
              pageController:_scrollPageController,
              isLoginUser: false,
              userModel: loginUserModel,

            );
          }else{
            return UserPage(
              pageController:_scrollPageController,
              isLoginUser: true,
              userModel: loginUserModel,
              uid: uid,
            );
          }
        });

    }
  }
}
