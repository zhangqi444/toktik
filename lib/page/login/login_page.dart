import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/enum/auth_status.dart';
import 'package:toktik/page/login/widget/login_app_bar_widget.dart';
import 'package:toktik/page/login/widget/login_subtitle_text_widget.dart';
import 'package:toktik/page/login/widget/login_title_text_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String title, subtitle;
  bool isForSignedUpAccount = false;
  TextField accountField, pwdField;
  String account, pwd;
  SelfController loginController = Get.put(SelfController());
  final MainPageScrollController mainPageController = Get.find();
  dynamic argumentData = Get.arguments;

  @override
  void initState() {
    super.initState();

    if(argumentData != null) {
      if(!isStringNullOrEmpty(argumentData['authStatus'])
          && argumentData['authStatus'] == AuthStatus.ALIAS_EXISTS.toShortString()) {
        title = "You've signed up already.";
        subtitle = "Enter your password to log in to your account.";
        isForSignedUpAccount = true;
      }

      if(!isStringNullOrEmpty(argumentData['email'])) {
        account = argumentData['email'];
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountField = TextField(
      cursorColor: ColorRes.color_1,
      cursorWidth: 2,
      readOnly: isForSignedUpAccount,
      controller: TextEditingController()..text = isForSignedUpAccount ? loginController.loginUserEmail.value : null,
      decoration: InputDecoration(border: InputBorder.none, hintText: 'Email, phone or user name'),
      onChanged: (text) {
        account = text;
      },
    );

    pwdField = TextField(
      cursorColor: ColorRes.color_1,
      cursorWidth: 2,
      obscureText: true,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: 'Password'),
      onChanged: (text) {
        pwd = text;
      },
    );

    return Scaffold(
      appBar: LoginAppBarWidget(title: "Log in"),
      body: _layoutLogin(context),
    );
  }

  _layoutLogin(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        // margin: EdgeInsets.only(top: 91),
        child: Column(
          children: [
            isForSignedUpAccount ? _getTitle() : Container(),
            _getAccountTextField(),
            SizedBox(
              height: 10,
            ),
            _getPwdTextField(),
            SizedBox(
              height: 10,
            ),
            _getBottomLayout(context),
            SizedBox(
              height: 20,
            ),
            _getLogin(context),
          ],
        ),
      ),
    );
  }

  _getTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 30, right: 30),
      height: 80,
      child: Column(
        children: [
          LoginTitleTextWidget(text: title),
          LoginSubtitleTextWidget(text: subtitle),
        ],
      ),
    );
  }

  _getAccountTextField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 30, right: 30),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.3, color: Color(0xff2A2A2A)))),
      child: accountField,
    );
  }

  _getPwdTextField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 30, right: 30),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.3, color: Color(0xff2A2A2A)))),
      child: pwdField,
    );
  }

  _getLogin(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: () async {
          if (null != account &&
              account.length > 0 &&
              null != pwd &&
              pwd.length > 0) {

            if(EmailValidator.validate(account)) {
              loginController.loginUserEmail.value = account;
            } else {
              loginController.loginUserUsername.value = account;
            }
            loginController.loginUserPassword.value = pwd;

            await loginController.login();

            Get.offAllNamed(Routers.scroll);
            mainPageController.selectIndexBottomBarMainPage(0);
          } else {
            EasyLoading.showToast('Check your info and try again.');
          }
        },
        child: Text(
          'Log in',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        color: ColorRes.color_3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  _getBottomLayout(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 25, right: 30),
      height: 40,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              child: TextButton(
                onPressed: () {
                  EasyLoading.showToast('The feature is coming soone.');
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Color(0xff2A2A2A), fontSize: 13),
                ),
              )),
          Positioned(
              right: 0,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routers.signUp);
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.black),
                ),
              )),
        ],
      ),
    );
  }
}
