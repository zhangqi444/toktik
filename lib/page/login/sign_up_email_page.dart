import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/enum/auth_status.dart';
import 'package:toktik/page/login/widget/login_error_message_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:toktik/util/string_util.dart';

class SignUpEmailPage extends StatefulWidget {
  SignUpEmailPage({Key key}) : super(key: key);

  @override
  _SignUpEmailPageState createState() {
    return _SignUpEmailPageState();
  }
}

class _SignUpEmailPageState extends State<SignUpEmailPage> {
  TextField accountField;
  String appBarTitle = "Sign up";
  String email;
  String errorMessage;
  SelfController loginController = Get.put(SelfController());

  @override
  void initState() {
    super.initState();
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
        height: 300,
        margin: EdgeInsets.only(top: 91),
        child: Column(
          children: [
            _getAccountTextField(),
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

  _getAccountTextField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 30, right: 30),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.3, color: Color(0xff2A2A2A)))),
      child: TextFormField(
        cursorColor: ColorRes.color_1,
        cursorWidth: 2,
        decoration: InputDecoration(border: InputBorder.none, hintText: 'Email address'),
        onChanged: (text) {
          email = text;
          loginController.loginUserEmail.value = email;
          setState(() {
            errorMessage = '';
          });
        },
        validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email address.",
      ),
    );
  }

  _getSignUp(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: () async {
          setState(() { errorMessage = ''; });
          if (!EmailValidator.validate(email)) {
            setState(() {
              errorMessage = 'The email address is invalid, please check and try again.';
            });
            return;
          }
          String status = await loginController.registerByEmail(email, email, email, email);
          if(status == AuthStatus.SIGN_UP_DONE.toShortString()) {
            Get.offNamedUntil(Routers.login, ModalRoute.withName(Routers.scroll));
            return;
          }

          if(status == AuthStatus.USERNAME_EXISTS.toShortString()) {
            Get.until(ModalRoute.withName(Routers.signUp));
            Get.toNamed(Routers.createUsername,
                arguments: { "errorMessage": 'The username is not valid or already existing, please try another one.'});
          } else if(status == AuthStatus.CONFIRM_SIGN_UP_STEP.toShortString()) {
            Get.toNamed(Routers.verificationCode, arguments: { "destination": email });
          } else {
            setState(() {
              errorMessage = 'Failed to send verification code, please try again.';
            });
          }

        },
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        color: ColorRes.color_3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
