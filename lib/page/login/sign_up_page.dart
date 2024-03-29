import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/event_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:get/get.dart';

import '../../common/configs.dart';
import '../../common/events.dart';
import '../../enum/navigation_argument.dart';
import 'widget/login_app_bar_widget.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final UserController loginController = Get.find();
  final EventController eventController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoginAppBarWidget(title: "", backCallback: () {
        eventController.recordEvent(Event.SIGN_UP_PAGE_BACK_PRESS);
      }),
      body: _layoutSignUp(context),
    );
  }

  _layoutSignUp(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Stack(alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        _getTitleText(),
                        Text(
                          "Create a profile, follow other accounts, make your own videos and more.",
                          style:
                              TextStyle(color: Color(0xff888888), fontSize: 15),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 21,
                        ),
                        _getButton(),
                      ],
                    ),
                  ),
                  _getFooter(),
                ])));
  }

  _getTitleText() {
    return Container(
      height: 40,
      child: Text(
        "Sign Up For Breeze",
        style: TextStyle(
            color: Color(0xff2A2A2A),
            fontSize: 24,
            fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
    );
  }

  _getButton() {
    return Container(
      width: 311,
      height: 44,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffDEDEDE))),
      padding: EdgeInsets.only(
          top: 13, bottom: 11, left: 18, right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RawMaterialButton(
            onPressed: () {
              Get.toNamed(Routers.createUsername);
              eventController.recordEvent(Event.SIGN_UP_PAGE_USE_PHONE_OR_EMAIL_BUTTON_PRESS);
            },
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      child: Icon(Icons.account_circle),
                      padding:
                          EdgeInsets.only(right: 51.0)),
                  Text('Use phone or email',
                      style: TextStyle(
                          color: Color(0xff2A2A2A)))
                ]),
            textStyle: TextStyle(
                color: Color(0xff2A2A2A),
                fontSize: 15.0),
          )
        ]));
  }

  _getFooter() {
    return Positioned(
      bottom: 60.0,
      child: Column(children: [
        _getPolicies(),
        SizedBox(
          height: 20,
        ),
        _getSignIn()
      ]),
    );
  }

  _getPolicies() {
    return Container(
        width: 420,
        padding: EdgeInsets.only(left: 30, right: 30),
      child:
          RichText(
            textAlign: TextAlign.center,
            maxLines: 3,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
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
                  TextSpan(
                      text:
                      'to learn how we collect, use, and share your data.',
                      style: TextStyle(color: Color(0xff888888))),
                ]),
        ));
  }

  _getSignIn() {
    return Column(children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Color(0xff2A2A2A)),
              ),
              TextSpan(
                text: " Log in",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.back();
                    eventController.recordEvent(Event.SIGN_UP_PAGE_LOGIN_PRESS);
                  },
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Color(0xff39CBE3)))
            ]
          )
        )
    ]);            
  }
}
