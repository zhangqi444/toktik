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
import 'package:phone_number/phone_number.dart';

import '../../common/configs.dart';
import '../../common/events.dart';
import '../../controller/event_controller.dart';
import 'widget/login_app_bar_widget.dart';
import 'package:flutter/gestures.dart';

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
  String? phone;
  String? email;
  String? username;
  String? password;
  String? errorPhoneMessage;
  String? errorEmailMessage;
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
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: LoginAppBarWidget(
          title: appBarTitle,
          backCallback: () {
            eventController.recordEvent(Event.SIGN_UP_EMAIL_PAGE_BACK_PRESS);
          },
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            labelPadding: EdgeInsets.only(bottom: 11),
            tabs: [
              Text('Phone'),
              Text('Email'),
            ],
          ),
        ),
        body: _layoutSignUp(context),
      )
    );
  }

  _layoutSignUp(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        margin: EdgeInsets.only(top: 37),
        child: TabBarView(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: LoginTextFieldWidget(
                      initText: phone,
                      prefixIcon: Text('US +1 '),
                      hintText: 'Phone number',
                      onChanged: (text) {
                        phone = text;
                        if (!isStringNullOrEmpty(phone)) {
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
                !isStringNullOrEmpty(errorPhoneMessage)
                    ? LoginErrorMessageWidget(text: errorPhoneMessage)
                    : SizedBox(height: 10),
                _getBottomLayout(context),
                SizedBox(
                  height: 20,
                ),
                _getSignUpByPhone(context),
              ],
            ),
            Column(
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
                !isStringNullOrEmpty(errorEmailMessage)
                    ? LoginErrorMessageWidget(text: errorEmailMessage)
                    : SizedBox(height: 10),
                _getBottomLayout(context),
                SizedBox(
                  height: 20,
                ),
                _getSignUpByEmail(context),
              ],
            )
          ],
        ),
      ),
    );
  }


  _getSignUpByPhone(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: LoginPrimaryButtonWidget(
        text: 'Next',
        onPressed: () async {
          eventController.recordEvent(Event.SIGN_UP_EMAIL_PAGE_NEXT_PRESS);
          setState(() {
            errorPhoneMessage = '';
          });

          PhoneNumberUtil plugin = PhoneNumberUtil();
          RegionInfo region = RegionInfo(prefix: 1, name: 'US', code: 'US');

          bool isValidPhone = await plugin.validate(phone!, region.code);

          if (!isValidPhone) {
            setState(() {
              errorPhoneMessage =
              'The phone number is invalid, please check and try again.';
            });

            return;
          }

          PhoneNumber phoneNumber = await plugin.parse(phone!);
          String? finalPhone = phoneNumber.e164;

          String? status = await loginController.registerByPhone(
              finalPhone , username, password, password);

          _processSignUpStatus(status!, 'phone');
        },
        buttonEnabled: isButtonActived,
      ),
    );
  }
  _getSignUpByEmail(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: LoginPrimaryButtonWidget(
        text: 'Next',
        onPressed: () async {
          eventController.recordEvent(Event.SIGN_UP_EMAIL_PAGE_NEXT_PRESS);
          setState(() {
            errorEmailMessage = '';
          });

          bool isValidEmail = EmailValidator.validate(email!);

          if (!isValidEmail) {
            setState(() {
              errorEmailMessage =
              'The email is invalid, please check and try again.';
            });

            return;
          }

          String? status = await loginController.registerByEmail(
              email , username, password, password);

          _processSignUpStatus(status!, 'email');
        },
        buttonEnabled: isButtonActived,
      ),
    );
  }

  _processSignUpStatus(String status, String errorType) {
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
      String? userInputPhoneOrEmail = email != null || email != '' ? email : phone;

      Get.toNamed(Routers.verificationCode, arguments: {
        NavigationArgument.DESTINATION: userInputPhoneOrEmail,
        NavigationArgument.USERNAME: username,
        NavigationArgument.PASSWORD: password,
        NavigationArgument.EMAIL: userInputPhoneOrEmail,
      });
    } else {
      if (errorType == 'phone') {
        setState(() {
          errorPhoneMessage = 'Failed to send email verification code, please try again.';
        });
      }

      if (errorType == 'email') {
        errorEmailMessage = 'Failed to send phone verification code, please try again.';
      }
    }
  }

  _getBottomLayout(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 25, right: 30),
        height: 40,
        child: Column(
          children: [
            Expanded(
                child:
                RichText(
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 13,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'By continuing, you agree to our ',
                            style: TextStyle(color: Color(0xff888888))),
                        TextSpan(
                            text: 'Terms of Service ',
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routers.webView, arguments: {NavigationArgument.URL: TERMS_OF_SERVICE_URL} );
                                eventController.recordEvent(Event.SIGN_UP_PAGE_TERMS_OF_SERVICE__PRESS);
                              },
                            style: TextStyle(
                                color: Color(0xff2A2A2A),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                            'and acknowledge that you have read our ',
                            style: TextStyle(color: Color(0xff888888))),
                        TextSpan(
                            text: 'Privacy Policy ',
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routers.webView, arguments: {NavigationArgument.URL: PRIVACY_POLICY_URL} );
                                eventController.recordEvent(Event.SIGN_UP_PAGE_PRIVACY_POLICY_PRESS);
                              },
                            style: TextStyle(
                                color: Color(0xff2A2A2A),
                                fontWeight: FontWeight.bold)),
                      ]),
                )
            )
          ],
        ));
  }
}
