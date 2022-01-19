import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/enum/auth_navigation_argument.dart';
import 'package:toktik/page/login/widget/login_error_message_widget.dart';
import 'package:toktik/page/login/widget/login_text_field_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';

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
  UserController userController = Get.put(UserController());
  SelfController loginController = Get.put(SelfController());

  @override
  void initState() {
    super.initState();
    if(argumentData != null) {
      setState(() {
        errorMessage = argumentData[AuthNavigationArgument.ERROR_MESSAGE];
        initText = argumentData[AuthNavigationArgument.USERNAME];
        username = argumentData[AuthNavigationArgument.USERNAME];
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(appBarTitle,
            style: TextStyle(color: Colors.black, fontSize: 16)),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: Image.asset('assets/images/login/question.png',
                color: Color(0xff888888), width: 22, height: 22),
            onPressed: () {},
          )
        ],
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Image.asset('assets/images/login/nav-arrow-left.png',
              color: Color(0xff2A2A2A), width: 24, height: 24),
        ),
      ),
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
      child: RaisedButton(
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
            Get.toNamed(Routers.createPassword, arguments: { AuthNavigationArgument.USERNAME: username });
          }
        },
        child: Text(
          'Next',
          style: buttonEnable
              ? TextStyle(color: Color(0xffFFFFFF), fontSize: 14)
              : TextStyle(color: Color(0xffAAAAAA), fontSize: 14),
        ),
        color: buttonEnable ? Color(0xff39CBE3) : Color(0xffEEEEEE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
