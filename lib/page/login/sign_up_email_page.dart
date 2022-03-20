import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/enum/navigation_argument.dart';
import 'package:toktik/enum/auth_status.dart';
import 'package:toktik/page/login/widget/login_error_message_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:toktik/util/string_util.dart';
import 'package:toktik/page/login/widget/login_text_field_widget.dart';
import 'package:toktik/page/login/widget/login_primary_button_widget.dart';

import '../../common/events.dart';
import '../../controller/event_controller.dart';
import 'widget/login_app_bar_widget.dart';

class SignUpEmailPage extends StatefulWidget {
  SignUpEmailPage({Key? key}) : super(key: key);

  @override
  _SignUpEmailPageState createState() {
    return _SignUpEmailPageState();
  }
}

class _SignUpEmailPageState extends State<SignUpEmailPage> {
  TextField? accountField;
  String appBarTitle = "Sign up";
  String? email;
  String? username;
  String? password;
  String? errorMessage;
  bool isButtonActived = false;
  SelfController loginController = Get.put(SelfController());
  final EventController eventController = Get.find();
  dynamic argumentData = Get.arguments;

  @override
  void initState() {
    super.initState();
    if (argumentData != null) {
      username = argumentData[NavigationArgument.USERNAME];
      password = argumentData[NavigationArgument.PASSWORD];
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
        eventController.recordEvent(Event.SIGN_UP_EMAIL_PAGE_BACK_PRESS);
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
        height: 300,
        margin: EdgeInsets.only(top: 57),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: LoginTextFieldWidget(
                  initText: email,
                  hintText: 'Email address',
                  onChanged: (text) {
                    email = text;
                    if (!isStringNullOrEmpty(email)) {
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
            SizedBox(
              height: 20,
            ),
            _getSignUp(context),
          ],
        ),
      ),
    );
  }

  _getSignUp(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: LoginPrimaryButtonWidget(
        text: 'Next',
        onPressed: () async {
          eventController.recordEvent(Event.SIGN_UP_EMAIL_PAGE_NEXT_PRESS);
          setState(() {
            errorMessage = '';
          });
          if (!EmailValidator.validate(email!)) {
            setState(() {
              errorMessage =
                  'The email address is invalid, please check and try again.';
            });
            return;
          }

          String? status = await loginController.registerByEmail(
              email, username, password, password);
          if (status == AuthStatus.SIGN_UP_DONE.toShortString()) {
            Get.offNamedUntil(
                Routers.login, ModalRoute.withName(Routers.scroll));
          } else if (status == AuthStatus.USERNAME_EXISTS.toShortString()) {
            Get.until(ModalRoute.withName(Routers.signUp));
            Get.toNamed(Routers.createUsername, arguments: {
              NavigationArgument.ERROR_MESSAGE:
                  'The username is not valid or already existing, please try another one.',
              NavigationArgument.USERNAME: username
            });
          } else if (status ==
              AuthStatus.CONFIRM_SIGN_UP_STEP.toShortString()) {
            Get.toNamed(Routers.verificationCode, arguments: {
              NavigationArgument.DESTINATION: email,
              NavigationArgument.USERNAME: username,
              NavigationArgument.PASSWORD: password,
              NavigationArgument.EMAIL: email,
            });
          } else {
            setState(() {
              errorMessage =
                  'Failed to send verification code, please try again.';
            });
          }
        },
        buttonEnabled: isButtonActived,
      ),
    );
  }

  _getBottomLayout(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 25, right: 30),
        height: 40,
        child: Column(
          children: [
            Expanded(
              child: Text(
                "By continuing, you agree to Breeze's Terms of Service and confirm that you have read Breeze's Privacy Policy.",
                style: TextStyle(color: Color(0xff2A2A2A), fontSize: 13),
                maxLines: 2,
              ),
            )
          ],
        ));
  }
}
