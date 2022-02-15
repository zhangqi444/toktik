import 'package:flutter/material.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/enum/navigation_argument.dart';
import 'package:toktik/enum/auth_status.dart';
import 'package:toktik/page/login/widget/login_app_bar_widget.dart';
import 'package:toktik/page/login/widget/login_error_message_widget.dart';
import 'package:toktik/page/login/widget/login_primary_button_widget.dart';
import 'package:toktik/page/login/widget/login_subtitle_text_widget.dart';
import 'package:toktik/page/login/widget/login_text_field_widget.dart';
import 'package:get/get.dart';
import 'package:toktik/page/login/widget/login_title_text_widget.dart';
import 'package:toktik/util/string_util.dart';

class ResetPasswordPasswordPage extends StatefulWidget {
  ResetPasswordPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPasswordPageState createState() {
    return _ResetPasswordPasswordPageState();
  }
}

class _ResetPasswordPasswordPageState extends State<ResetPasswordPasswordPage> {
  dynamic argumentData = Get.arguments;
  String appBarTitle = "Reset";
  String title = "Reset password";
  String subTitle = "";
  String? account;
  String? password;
  bool buttonEnabled = false;
  String? errorMessage = "";
  UserController userController = Get.put(UserController());
  SelfController loginController = Get.put(SelfController());

  @override
  void initState() {
    super.initState();
    if(argumentData != null) {
      setState(() {
        errorMessage = argumentData[NavigationArgument.ERROR_MESSAGE];
        account = argumentData[NavigationArgument.ACCOUNT];
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: LoginAppBarWidget(title: appBarTitle),
      body: _getLayout(context),
    );
  }

  _getLayout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        height: 600,
        margin: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            LoginTitleTextWidget(text: title),
            LoginSubtitleTextWidget(text: subTitle),
            SizedBox(
              height: 38,
            ),
            LoginTextFieldWidget(hintText: "Enter password", obscureText: true, onChanged: (text) {
              password = text;
              setState(() {
                buttonEnabled = password != null && password!.length >= 6;
              });
            }),
            !isStringNullOrEmpty(errorMessage)
                ? LoginErrorMessageWidget(text: errorMessage)
                : SizedBox(height: 29),
            LoginPrimaryButtonWidget(
              text: "Next",
              buttonEnabled: buttonEnabled,
              onPressed: !buttonEnabled ? () {} : () async {
                Get.toNamed(Routers.verificationCode, arguments: {
                  NavigationArgument.IS_RESET_PASSWORD: true,
                  NavigationArgument.DESTINATION: "your email or phone",
                  NavigationArgument.ACCOUNT: account,
                  NavigationArgument.PASSWORD: password
                });
              }
            )
          ],
        ),
      ),
    );
  }
}
