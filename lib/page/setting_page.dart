import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toktik/common/events.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/common/strings.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/page/widget/app_bar_widget.dart';
import 'package:toktik/page/widget/item_turn_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

import '../common/configs.dart';
import '../controller/app_controller.dart';
import '../controller/event_controller.dart';
import '../enum/navigation_argument.dart';

//设置页面
class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() {
    return _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
  final SelfController loginController = Get.put(SelfController());
  final EventController eventController = Get.find();
  final AppController appController = Get.find();

  var platformInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.light_background_color,
      appBar:AppBarWidget(title: 'Settings and privacy'),
      body: _getBody(context),
    );
  }

  _getHeader(String text) {
    return Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Text(text, style: TextStyle(color: ColorRes.light_background_sub_color,fontSize: 12),)
    );
  }

  _getDivider() {
    return Container(
      height: 10,
      margin: EdgeInsets.only(bottom: 15),
      child: Divider(
        color: ColorRes.light_foreground_color.withAlpha(80),
      )
    );
  }

  _getBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getDivider(),
            _getHeader(_SettingPageMenuConfig.HEADER_ABOUT),
            _SettingPageMenu(config: _SettingPageMenuConfig.TERMS_OF_SERVICE),
            _SettingPageMenu(
                config: _SettingPageMenuConfig.COMMUNITY_GUIDELINES),
            _SettingPageMenu(config: _SettingPageMenuConfig.PRIVACY_POLICY),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/balance.png',title: "Balance", onClick: (){
            //   Get.toNamed(Routers.webView, arguments: {"url": "https://getbreeze.me/copyright"} );
            // }),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/qr_code.png',title: "QR code", onClick: () {
            //   Get.toNamed(Routers.webView, arguments: {"url": "https://getbreeze.me"} );
            // }),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/share_profile.png',title: "Share profile", onClick: () {
            //   Get.toNamed(Routers.webView, arguments: {"url": "https://getbreeze.me"} );
            _SettingPageMenu(config: _SettingPageMenuConfig.COPYRIGHT_POLICY),
            _SettingPageMenu(config: _SettingPageMenuConfig.ABOUT),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/setting_delete.png',title: '清理占用空间',onClick: (){EasyLoading.showToast('功能待开发');},),

            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/setting_exchange.png',title: '切换账号',onClick: (){
            //
            //   // SPUtil.remove(SPKeys.userUid);
            //   // SPUtil.remove(SPKeys.token);
            //
            //   Get.offNamed(Routers.login);},),
            _getDivider(),
            _getHeader(_SettingPageMenuConfig.HEADER_SUPPORT),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/push_notifications.png',title: "Push notifications", onClick: () {
            //   Get.toNamed(Routers.webView, arguments: {"url": FEEDBACK_URL} );
            // }),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/app_language.png',title: "App language", rightTitle: "English", onClick: () {
            //   Get.toNamed(Routers.webView, arguments: {"url": FEEDBACK_URL} );
            // }),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/dark_mode.png',title: "Dark mode", onClick: () {
            //   Get.toNamed(Routers.webView, arguments: {"url": FEEDBACK_URL} );
            // }),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/content_preferences.png',title: "Content preferences", onClick: () {
            //   Get.toNamed(Routers.webView, arguments: {"url": FEEDBACK_URL} );
            // }),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/ads.png',title: "Ads", onClick: () {
            //   Get.toNamed(Routers.webView, arguments: {"url": FEEDBACK_URL} );
            // }),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/digital_wellbeing.png',title: "Digital Wellbeing", onClick: () {
            //   Get.toNamed(Routers.webView, arguments: {"url": FEEDBACK_URL} );
            // }),
            // ItemTurnWidget(img: 'assets/images/setting_and_privacy/family_pairing.png',title: "Family Pairing", onClick: () {
            //   Get.toNamed(Routers.webView, arguments: {"url": FEEDBACK_URL} );
            // }),
            _SettingPageMenu(config: _SettingPageMenuConfig.REPORT_PROBLEM),
            _getDivider(),
            _getHeader(_SettingPageMenuConfig.HEADER_LOGIN),
            _SettingPageMenu(
                config: _SettingPageMenuConfig.LOGOUT,
                callback: () async {
              await loginController.logout();
              Get.offNamedUntil(Routers.login, ModalRoute.withName(Routers.scroll));
              eventController.recordEvent(Event.SETTING_PAGE_MENU_PRESS, event: {
                EventKey.NAME: _SettingPageMenuConfig.LOGOUT['type'],
                EventKey.VALUE: 1,
              });
            }),
            Container(
                margin: EdgeInsets.only(top: 30, bottom: 30),
                alignment: Alignment.center,
                child: Text(
                  platformInfo == null ? "" : "v${appController.platformInfo?.version}",
                  style: TextStyle(
                      color: ColorRes.light_background_sub_color, fontSize: 14),
                ))
          ],
        ),
      ),
    );
  }
}

class _SettingPageMenu extends StatelessWidget {
  final Map<String, String> config;
  final Function? callback;
  final EventController eventController = Get.find();

  _SettingPageMenu({Key? key, required this.config, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemTurnWidget(
        img: config['img'],
        title: config['name'],
        onClick: () {
          if (callback == null) {
            Get.toNamed(Routers.webView,
                arguments: {NavigationArgument.URL: config['url']});
          } else {
            callback!();
          }

          eventController.recordEvent(Event.SETTING_PAGE_MENU_PRESS, event: {
            EventKey.NAME: config['type'],
            EventKey.VALUE: 1,
          });
        });
  }
}

class _SettingPageMenuConfig {
  static const HEADER_ABOUT = "ABOUT";
  static const HEADER_SUPPORT = "SUPPORT";
  static const HEADER_LOGIN = "LOGIN";

  static const Map<String, String> TERMS_OF_SERVICE = {
    'name': "Terms of Service",
    'type': "TERMS_OF_SERVICE",
    'img': 'assets/images/setting_and_privacy/terms_of_service.png',
    'url': TERMS_OF_SERVICE_URL
  };

  static const Map<String, String> COMMUNITY_GUIDELINES = {
    'name': "Community Guidelines",
    'type': "COMMUNITY_GUIDELINES",
    'img': "assets/images/setting_and_privacy/community_guidelines.png",
    'url': COMMUNITY_GUIDELINES_URL
  };

  static const Map<String, String> PRIVACY_POLICY = {
    'name': "Privacy Policy",
    'type': "PRIVACY_POLICY",
    'img': 'assets/images/setting_and_privacy/privacy.png',
    'url': PRIVACY_POLICY_URL
  };

  static const Map<String, String> COPYRIGHT_POLICY = {
    'name': "Copyright Policy",
    'type': "COPYRIGHT_POLICY",
    'img': 'assets/images/setting_and_privacy/copyright_policy.png',
    'url': COPYRIGHT_URL
  };

  static const Map<String, String> ABOUT = {
    'name': "About $APP_NAME",
    'type': "ABOUT",
    'img': 'assets/images/setting_about.png',
    'url': DOMAIN
  };

  static const Map<String, String> REPORT_PROBLEM = {
    'name': "Report a problem",
    'type': "REPORT_PROBLEM",
    'img': "assets/images/setting_and_privacy/report_a_problem.png",
    'url': FEEDBACK_URL
  };

  static const Map<String, String> LOGOUT = {
    'name': "Logout",
    'type': "LOGOUT",
    'img': 'assets/images/setting_and_privacy/log_out.png',
  };
}
