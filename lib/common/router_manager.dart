import 'package:toktik/page/feed_publish_page.dart';
// import 'package:toktik/page/friend_page.dart';
import 'package:toktik/page/home_page.dart';
import 'package:toktik/page/login/sign_up_email_page.dart';
import 'package:toktik/page/splash_page.dart';
// import 'package:toktik/page/home_tab_city_page.dart';
// import 'package:toktik/page/home_tab_focus_page.dart';
import 'package:toktik/page/home_tab_recommend_page.dart';
// import 'package:toktik/page/living_page.dart';
import 'package:toktik/page/login/login_page.dart';
import 'package:toktik/page/main_page.dart';
import 'package:toktik/page/message_page.dart';
// import 'package:toktik/page/modify_info_page.dart';
import 'package:toktik/page/login/sign_up_page.dart';
import 'package:toktik/page/login/sign_up_verify_page.dart';
// import 'package:toktik/page/scan_page.dart';
import 'package:toktik/page/scroll_page.dart';
import 'package:toktik/page/search_page.dart';
// import 'package:toktik/page/setting_page.dart';
import 'package:toktik/page/shoot_page.dart';
// import 'package:toktik/page/test.dart';
// import 'package:toktik/page/user_info_edit_page.dart';
import 'package:toktik/page/user_page.dart';
// import 'package:toktik/page/video_list_page.dart';
// import 'package:toktik/page/my_tiktok_code_page.dart';
import 'package:get/get.dart';

///路由管理者
class RouterManager{
  static final routes = [
    // GetPage(name: Routers.test, page: () => TestPage()),
    GetPage(name: Routers.splash, page: () => SplashPage()),
    GetPage(name: Routers.scroll, page: () => ScrollPage()),
    GetPage(name: Routers.main, page: () => MainPage()),
    GetPage(name: Routers.user, page: () => UserPage()),
    GetPage(name: Routers.shoot, page: () => ShootPage()),
    GetPage(name: Routers.home, page: () => HomePage()),
    GetPage(name: Routers.message, page: () => MessagePage()),
    // GetPage(name: Routers.homeTabCity, page: () => HomeTabCityPage()),
    // GetPage(name: Routers.homeTabFocus, page: () => HomeTabFocusPage()),
    GetPage(name: Routers.homeTabRecommend, page: () => HomeTabRecommendPage()),
    // GetPage(name: Routers.videoList, page: () => VideoListPage()),
    GetPage(name: Routers.search, page: () => SearchPage()),
    // GetPage(name: Routers.scan, page: () => ScanPage()),
    // GetPage(name: Routers.tikTokCode, page: () => MyTikTokCodePage()),
    // GetPage(name: Routers.living, page: () => LivingPage()),
    GetPage(name: Routers.login, page: () => LoginPage(),transition: Transition.downToUp,),
    GetPage(name: Routers.signUp, page: () => SignUpPage()),
    GetPage(name: Routers.signUpEmail, page: () => SignUpEmailPage()),
    GetPage(name: Routers.signUpVerify, page: () => SignUpVerifyPage()),
    // GetPage(name: Routers.setting, page: () => SettingPage()),
    // GetPage(name: Routers.editUserInfo, page: () => UserInfoEditPage()),
    // GetPage(name: Routers.modifyUserInfo, page: () => ModifyInfoPage()),
    GetPage(name: Routers.feedPublish, page: () => FeedPublishPage()),
  ];


}
///路由名称
class Routers{
  static final String splash = '/splash';
  static final String test = '/test';
  static final String scroll = '/scroll';
  static final String main = '/main';
  static final String user = '/user';
  static final String shoot = '/shoot';
  static final String home = '/home';
  static final String friend = '/friend';
  static final String message = '/message';
  static final String homeTabCity = '/homeTabCity';
  static final String homeTabFocus = '/homeTabFocus';
  static final String homeTabRecommend = '/homeTabRecommend';
  static final String videoList = '/videoList';
  static final String search = '/search';
  static final String scan = '/scan';
  static final String tikTokCode = '/tikTokCode';
  static final String living = '/living';
  static final String login = '/login';
  static final String signUp = '/signUp';
  static final String signUpEmail = '/signUpEmail';
  static final String signUpVerify = '/signUpVerify';
  static final String setting = '/setting';
  static final String editUserInfo = '/editUserInfo';
  static final String modifyUserInfo = '/modifyUserInfo';
  static final String feedPublish = '/feedPublish';
}