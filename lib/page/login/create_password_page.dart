import 'package:flutter/material.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/enum/auth_navigation_argument.dart';
import 'package:toktik/page/login/widget/login_app_bar_widget.dart';
import 'package:toktik/page/login/widget/login_error_message_widget.dart';
import 'package:toktik/page/login/widget/login_primary_button_widget.dart';
import 'package:toktik/page/login/widget/login_text_field_widget.dart';
import 'package:get/get.dart';
import 'package:toktik/page/login/widget/login_title_text_widget.dart';
import 'package:toktik/util/string_util.dart';

class CreatePasswordPage extends StatefulWidget {
  CreatePasswordPage({Key? key}) : super(key: key);

  @override
  _CreatePasswordPageState createState() {
    return _CreatePasswordPageState();
  }
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  String? password;
  String? username;
  bool buttonEnabled = false;
  String errorMessage = "";
  String title = "Create password";
  String appBarTitle = "Sign up";
  SelfController loginController = Get.put(SelfController());
  dynamic argumentData = Get.arguments;

  @override
  void initState() {
    super.initState();
    if(argumentData != null) {
        username = argumentData[AuthNavigationArgument.USERNAME];
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
      body: _layoutSignUp(context),
    );
  }

  _layoutSignUp(BuildContext context) {
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
            SizedBox(
              height: 38,
            ),
            LoginTextFieldWidget(hintText: "Password", obscureText: true, onChanged: (text) {
              password = text;
              setState(() {
                buttonEnabled = password != null && password!.length >= 8;
              });
            }),
            !isStringNullOrEmpty(errorMessage)
                ? LoginErrorMessageWidget(text: errorMessage)
                : SizedBox(height: 29),
            LoginPrimaryButtonWidget(
              text: "Next",
              buttonEnabled: buttonEnabled,
              onPressed: () async {
                Get.toNamed(Routers.signUpEmail, arguments: {
                  AuthNavigationArgument.USERNAME: username, AuthNavigationArgument.PASSWORD: password });
              })
          ],
        ),
      ),
    );
  }
}
