import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/common/strings.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/page/widget/app_bar_widget.dart';
import 'package:toktik/page/widget/item_turn_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

import '../common/configs.dart';
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
  SelfController loginController = Get.put(SelfController());
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
      appBar:AppBarWidget(title: 'Setting'),
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

  _getVersionNumber() async {
    platformInfo = await PackageInfo.fromPlatform();
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
            // Padding(
            //     padding: EdgeInsets.only(left: 20,right: 20),
            //     child: Text('账号',style: TextStyle(color: ColorRes.color_2,fontSize: 12),)),
            // ItemTurnWidget(img: 'assets/images/person.png',title: '账号与安全',onClick: (){EasyLoading.showToast('账号与安全');},),
            // ItemTurnWidget(img: 'assets/images/lock.png',title: '隐私设置',onClick: (){EasyLoading.showToast('功能待开发');},),
            // Divider(color: ColorRes.color_2.withAlpha(20),),
            // Padding(
            //     padding: EdgeInsets.only(left: 20,right: 20),
            //     child: Text('通用',style: TextStyle(color: ColorRes.color_2,fontSize: 12),)),
            // ItemTurnWidget(img: 'assets/images/notice.png',title: '通知设置',onClick: (){EasyLoading.showToast('功能待开发');},),
            // ItemTurnWidget(img: 'assets/images/active_wallpager.png',title: '动态壁纸',onClick: (){EasyLoading.showToast('功能待开发');},),
            // ItemTurnWidget(img: 'assets/images/setting_common.png',title: '通用设置',onClick: (){EasyLoading.showToast('功能待开发');},),
            // ItemTurnWidget(img: 'assets/images/color_palette.png',title: '背景设置',onClick: (){EasyLoading.showToast('功能待开发');},),
            // Divider(color: ColorRes.color_2.withAlpha(20),),
            // Padding(
            //     padding: EdgeInsets.only(left: 20,right: 20),
            //     child: Text('账号互通',style: TextStyle(color: ColorRes.color_2,fontSize: 12),)),
            // ItemTurnWidget(img: 'assets/images/share_app_toutiao.webp',title: '头条主页',onClick: (){EasyLoading.showToast('功能待开发');},),
            // ItemTurnWidget(img: 'assets/images/fensi.png',title: '粉丝',onClick: (){EasyLoading.showToast('功能待开发');},),
            // Divider(color: ColorRes.color_2.withAlpha(20),),
            _getHeader(SETTING_HEADER_ABOUT),
            // ItemTurnWidget(img: 'assets/images/ad.png',title: '广告反馈与设置',onClick: (){EasyLoading.showToast('功能待开发');},),
            ItemTurnWidget(img: 'assets/images/user_service.png',title: SETTING_TERMS_OF_SERVICE, onClick: (){
              Get.toNamed(Routers.webView, arguments: {NavigationArgument.URL: TERMS_OF_SERVICE_URL} );
            }),
            ItemTurnWidget(img: 'assets/images/community_service.png',title: SETTING_COMMUNITY_GUIDELINES, onClick: (){
              Get.toNamed(Routers.webView, arguments: {"url": "https://www.getbreeze.me/community-guidelines"} );
            }),
            ItemTurnWidget(img: 'assets/images/private_service.png',title: SETTING_PRIVACY_POLICY, onClick: (){
              Get.toNamed(Routers.webView, arguments: {NavigationArgument.URL: PRIVACY_POLICY_URL} );
            }),
            ItemTurnWidget(img: 'assets/images/sdk_list.png',title: SETTING_COPYRIGHT_POLICY, onClick: (){
              Get.toNamed(Routers.webView, arguments: {"url": "https://getbreeze.me/copyright"} );
            }),
            ItemTurnWidget(img: 'assets/images/setting_about.png',title: SETTING_ABOUT, onClick: () {
              Get.toNamed(Routers.webView, arguments: {"url": "https://getbreeze.me"} );
            }),
            // ItemTurnWidget(img: 'assets/images/setting_delete.png',title: '清理占用空间',onClick: (){EasyLoading.showToast('功能待开发');},),

            // ItemTurnWidget(img: 'assets/images/setting_exchange.png',title: '切换账号',onClick: (){
            //
            //   // SPUtil.remove(SPKeys.userUid);
            //   // SPUtil.remove(SPKeys.token);
            //
            //   Get.offNamed(Routers.login);},),
            _getDivider(),
            _getHeader(SETTING_HEADER_SUPPORT),
            ItemTurnWidget(img: 'assets/images/setting_feedback.png',title: SETTING_REPORT_PROBLEM, onClick: () {
              Get.toNamed(Routers.webView, arguments: {"url": "https://www.getbreeze.me/contact"} );
            }),
            _getDivider(),
            _getHeader(SETTING_HEADER_LOGIN),
            ItemTurnWidget(img: 'assets/images/setting_logout.png',title: SETTING_LOGOUT, onClick: () async {
              await loginController.logout();
              Get.offNamedUntil(Routers.login, ModalRoute.withName(Routers.scroll));
            }),
            FutureBuilder<void>(
              future: _getVersionNumber(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                return Container(
                    margin: EdgeInsets.only(top: 30,bottom: 30),
                    alignment: Alignment.center,
                    child: Text(platformInfo == null ? "" : "v${platformInfo.version}", style: TextStyle(color: ColorRes.light_background_sub_color,fontSize: 14),)
                );
              },
            )

          ],
        ),
      ),
    );
  }
}