import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextField accountField, pwdField;
  String account, pwd;
  UserController loginController = Get.put(UserController());

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
      decoration: InputDecoration(border: InputBorder.none, hintText: 'Email'),
      onChanged: (text) {
        account = text;
      },
    );

    pwdField = TextField(
      cursorColor: ColorRes.color_1,
      cursorWidth: 2,
      obscureText: true,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: 'Password'),
      onChanged: (text) {
        pwd = text;
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title:
            Text("Log in", style: TextStyle(color: Colors.black, fontSize: 16)),
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
      body: _layoutLogin(context),
    );
  }

  _layoutLogin(BuildContext context) {
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
            _getPwdTextField(),
            SizedBox(
              height: 10,
            ),
            _getBottomLayout(context),
            SizedBox(
              height: 20,
            ),
            _getLogin(context),
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

  _getPwdTextField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 30, right: 30),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.3, color: Color(0xff2A2A2A)))),
      child: pwdField,
    );
  }

  _getLogin(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: () {
          if (null != account &&
              account.length > 0 &&
              null != pwd &&
              pwd.length > 0) {
            loginController.login(account, pwd);
          } else {
            EasyLoading.showToast('Check your info and try again.');
          }
        },
        child: Text(
          'Log in',
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
      child: Stack(
        children: [
          Positioned(
              left: 0,
              child: TextButton(
                onPressed: () {
                  EasyLoading.showToast('功能待开发');
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Color(0xff2A2A2A), fontSize: 13),
                ),
              )),
          Positioned(
              right: 0,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routers.signUp);
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.black),
                ),
              )),
        ],
      ),
    );
  }
}
