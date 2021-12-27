import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

class SignUpEmailPage extends StatefulWidget {
  SignUpEmailPage({Key key}) : super(key: key);

  @override
  _SignUpEmailPageState createState() {
    return _SignUpEmailPageState();
  }
}

class _SignUpEmailPageState extends State<SignUpEmailPage> {
  TextField accountField;
  String account;
  // UserController loginController = Get.put(UserController());

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
    accountField = TextField(
      cursorColor: ColorRes.color_1,
      cursorWidth: 2,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: 'Email address'),
      onChanged: (text) {
        account = text;
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text("Sign up",
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
            SizedBox(
              height: 10,
            ),
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
      child: accountField,
    );
  }

  _getSignUp(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: () {
          if (null != account && account.length > 0) {
            Get.toNamed(Routers.signUpVerify);
          } else {
            EasyLoading.showToast('Check your info and try again.');
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
