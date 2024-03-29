import 'package:flutter/material.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/common/strings.dart';
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

import '../../common/events.dart';
import '../../controller/event_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  dynamic argumentData = Get.arguments;
  String? initText;
  String appBarTitle = "Reset";
  String title = "Reset password";
  String subTitle = "We will send you a code to reset your password.";
  String? account;
  bool buttonEnabled = false;
  String? errorMessage = "";
  UserController userController = Get.put(UserController());
  SelfController loginController = Get.put(SelfController());
  final EventController eventController = Get.find();

  @override
  void initState() {
    super.initState();
    if(argumentData != null) {
      setState(() {
        errorMessage = argumentData[NavigationArgument.ERROR_MESSAGE];
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
      appBar: LoginAppBarWidget(title: appBarTitle, backCallback: () {
        eventController.recordEvent(Event.RESET_PASSWORD_PAGE_BACK_PRESS);
      },),
      body: _getLayout(context),
    );
  }

  _getLayout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
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
            LoginTextFieldWidget(hintText: "Username, email or phone number", initText: initText, onChanged: (text) {
              account = text;
              setState(() {
                buttonEnabled = account != null && account!.length >= 6;
              });
            }),
            !isStringNullOrEmpty(errorMessage)
                ? LoginErrorMessageWidget(text: errorMessage)
                : SizedBox(height: 29),
            LoginPrimaryButtonWidget(
              text: "Next",
              buttonEnabled: buttonEnabled,
              onPressed: !buttonEnabled ? () {} : () async {
                String? status = await loginController.resetPassword(account!);

                if(status == AuthStatus.USER_NOT_FOUND.toShortString()) {
                  setState(() { errorMessage = "The user isn't registered yet."; });
                } else if(status == AuthStatus.CONFIRM_RESET_PASSWORD_WITH_CODE.toShortString()) {
                  Get.toNamed(Routers.resetPasswordPassword, arguments: {
                    NavigationArgument.ACCOUNT: account
                  });
                } else {
                  setState(() { errorMessage = LOGIN_UNKNOWN_ERROR_MESSAGE; });
                }
                eventController.recordEvent(Event.RESET_PASSWORD_PAGE_NEXT_PRESS);
              }
            )
          ],
        ),
      ),
    );
  }
}
