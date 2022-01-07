import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  UserController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actions: <Widget>[
          new IconButton(
            icon: Image.asset('assets/images/login/question.png',
                color: Color(0xff888888), width: 22, height: 22),
            onPressed: () {},
          )
        ],
      ),
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
                    height: 600,
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
                        Container(
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
                                ])),
                        SizedBox(
                          height: 300,
                        ),
                        Expanded(
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
                                          text: 'By signing, you agree to our ',
                                          style: TextStyle(color: Color(0xff888888))),
                                      TextSpan(
                                          text: 'Terms of Service ',
                                          style: TextStyle(
                                              color: Color(0xff2A2A2A),
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                          'and acknowledge that you have read our ',
                                          style: TextStyle(color: Color(0xff888888))),
                                      TextSpan(
                                          text: 'Privacy Policy ',
                                          style: TextStyle(
                                              color: Color(0xff2A2A2A),
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                          'to learn how we collect, use, and share your data.',
                                          style: TextStyle(color: Color(0xff888888))),
                                    ]),
                              )),
                      ],
                    ),
                  ),

                  Positioned(
                      bottom: 60.0,
                      child: RichText(
                          text: TextSpan(children: [
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
                                },
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Color(0xff39CBE3)))
                          ])))
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

  _getBottomLayout(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Text(
        "Login with password",
        style: TextStyle(color: Color(0xff2A2A2A), fontSize: 13),
      ),
    );
  }
}
