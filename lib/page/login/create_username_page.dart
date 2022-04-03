import 'package:flutter/material.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/enum/navigation_argument.dart';
import 'package:toktik/page/login/widget/login_error_message_widget.dart';
import 'package:toktik/page/login/widget/login_text_field_widget.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';
import 'package:toktik/page/login/widget/login_primary_button_widget.dart';

import '../../common/events.dart';
import '../../controller/event_controller.dart';
import 'widget/login_app_bar_widget.dart';

class CreateUsernamePage extends StatefulWidget {
  CreateUsernamePage({Key? key}) : super(key: key);

  @override
  _CreateUsernamePageState createState() {
    return _CreateUsernamePageState();
  }
}

class _CreateUsernamePageState extends State<CreateUsernamePage> {
  dynamic argumentData = Get.arguments;
  String? initText;
  String appBarTitle = "Sign up";
  String title = "Create username";
  String subTitle = "Please notice, you can not change this later.";
  String? username;
  bool buttonEnable = false;
  String? errorMessage = "";
  final UserController userController = Get.put(UserController());
  final SelfController loginController = Get.put(SelfController());
  final EventController eventController = Get.find();

  @override
  void initState() {
    super.initState();
    if(argumentData != null) {
      setState(() {
        errorMessage = argumentData[NavigationArgument.ERROR_MESSAGE];
        initText = argumentData[NavigationArgument.USERNAME];
        username = argumentData[NavigationArgument.USERNAME];
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
        eventController.recordEvent(Event.SIGN_UP_USERNAME_PAGE_BACK_PRESS);
      },),
      body: _layoutSignUp(context),
    );
  }

  _layoutSignUp(BuildContext context) {
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
            _getTitleText(),
            Text(
              subTitle,
              style: TextStyle(color: Color(0xff888888), fontSize: 14),
            ),
            SizedBox(
              height: 38,
            ),
            LoginTextFieldWidget(hintText: "Username", initText: initText, onChanged: (text) {
              username = text;
              setState(() {
                buttonEnable = username != null && username!.length >= 8;
              });
            }),
            !isStringNullOrEmpty(errorMessage)
                ? LoginErrorMessageWidget(text: errorMessage)
                : SizedBox(height: 29),
            _getSignUp(context)
          ],
        ),
      ),
    );
  }

  _getTitleText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Text(
        title,
        style: TextStyle(
            color: Color(0xff2A2A2A),
            fontSize: 20,
            fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
    );
  }

  _getSignUp(BuildContext context) {
    return Container(
      height: 42,
      width: MediaQuery.of(context).size.width,
      child: LoginPrimaryButtonWidget(
        text: 'Next',
        onPressed: !buttonEnable ? () {} : () async {
          String? userId = await userController.loadUserInfoExByUsername(username);
          if(!isStringNullOrEmpty(userId)) {
            setState(() {
              errorMessage = "The username is not valid or already existing, please try another one.";
            });
          } else {
            setState(() {
              errorMessage = "";
            });
            Get.toNamed(Routers.createPassword, arguments: { NavigationArgument.USERNAME: username });
          }
          eventController.recordEvent(Event.SIGN_UP_USERNAME_PAGE_NEXT_PRESS);
        },
        buttonEnabled: buttonEnable,
      ),
    );
  }
}

