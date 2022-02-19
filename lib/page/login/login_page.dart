import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/common/strings.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/enum/navigation_argument.dart';
import 'package:toktik/enum/auth_status.dart';
import 'package:toktik/page/login/widget/login_app_bar_widget.dart';
import 'package:toktik/page/login/widget/login_error_message_widget.dart';
import 'package:toktik/page/login/widget/login_subtitle_text_widget.dart';
import 'package:toktik/page/login/widget/login_text_field_widget.dart';
import 'package:toktik/page/login/widget/login_title_text_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';
import 'package:toktik/page/login/widget/login_primary_button_widget.dart';

import '../widget/spinner_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String? title, subtitle;
  bool isForSignedUpAccount = false;
  TextField? pwdField;
  String? account, pwd;
  String errorMessage = "";
  SelfController loginController = Get.put(SelfController());
  final MainPageScrollController mainPageController = Get.find();
  dynamic argumentData = Get.arguments;
  bool isButtonActived = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (argumentData != null) {
      if (!isStringNullOrEmpty(
              argumentData[NavigationArgument.AUTH_STATUS]) &&
          argumentData[NavigationArgument.AUTH_STATUS] ==
              AuthStatus.ALIAS_EXISTS.toShortString()) {
        title = "You've signed up already.";
        subtitle = "Enter your password to log in to your account.";
        isForSignedUpAccount = true;
      }

      if (!isStringNullOrEmpty(argumentData[NavigationArgument.ACCOUNT])) {
        account = argumentData[NavigationArgument.ACCOUNT];
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        margin: EdgeInsets.only(left: 30, right: 30),
        child: Stack(
          children: [
            Column(
              children: [
                isForSignedUpAccount ? _getTitle() : Container(),
                Container(
                  margin: EdgeInsets.only(top: 34),
                  child: LoginTextFieldWidget(
                      readOnly: isForSignedUpAccount,
                      initText: account,
                      hintText: 'Email, phone or user name',
                      onChanged: (text) {
                        account = text;
                        if (!isStringNullOrEmpty(account) &&
                            !isStringNullOrEmpty(pwd)) {
                          setState(() {
                            isButtonActived = true;
                          });
                        } else {
                          setState(() {
                            isButtonActived = false;
                          });
                        }
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: LoginTextFieldWidget(
                      readOnly: isForSignedUpAccount,
                      initText: pwd,
                      hintText: 'Password',
                      onChanged: (text) {
                        pwd = text;
                        if (!isStringNullOrEmpty(account) &&
                            !isStringNullOrEmpty(pwd)) {
                          setState(() {
                            isButtonActived = true;
                          });
                        } else {
                          setState(() {
                            isButtonActived = false;
                          });
                        }
                      }),
                ),
                !isStringNullOrEmpty(errorMessage)
                    ? LoginErrorMessageWidget(text: errorMessage)
                    : SizedBox(height: 10),
                _getBottomLayout(context),
                _getLogin(context),
              ],
            ),
            SpinnerWidget(isLoading)
          ],
        )
      ),
    );
  }

  _getTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          LoginTitleTextWidget(text: title),
          LoginSubtitleTextWidget(text: subtitle),
        ],
      ),
    );
  }

  _getLogin(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: LoginPrimaryButtonWidget(
        text: 'Log in',
        onPressed: () async {
          isLoading = true;
          if (!isStringNullOrEmpty(account) && !isStringNullOrEmpty(pwd)) {
            String? status = await loginController.login(
                account, pwd, EmailValidator.validate(account!));

            if (status == AuthStatus.USER_NOT_FOUND.toShortString()) {
              setState(() {
                errorMessage = 'Sorry, we cannot find the user. Please try again.';
              });
            } else if (status == AuthStatus.SIGN_IN_DONE.toShortString()) {
              Get.offAllNamed(Routers.scroll);
              mainPageController.selectIndexBottomBarMainPage(0);
            } else {
              setState(() {
                errorMessage = LOGIN_UNKNOWN_ERROR_MESSAGE;
              });
            }
          } else {
            setState(() {
              errorMessage = 'Check your info and try again.';
            });
          }
          isLoading = false;
        },
        buttonEnabled: isButtonActived,
      ),
    );
  }

  _getBottomLayout(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routers.resetPassword);
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
