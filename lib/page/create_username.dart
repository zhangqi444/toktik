import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/page/login/sign_up_verify_page.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

class CreateUserName extends StatefulWidget {
  CreateUserName({Key key}) : super(key: key);

  @override
  _CreateUserNameState createState() {
    return _CreateUserNameState();
  }
}

class _CreateUserNameState extends State<CreateUserName> {
  TextField accountField;
  String account;
  bool buttonEnable = false;
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
          InputDecoration(border: InputBorder.none, hintText: 'Username'),
      onChanged: (text) {
        account = text;
        if(account != null && account.length >0)
          {
            setState(() {
              buttonEnable = true;
            });
          }
        else
          {
            setState(() {
              buttonEnable = false;
            });
          }
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
              "You can always change this later",
              style: TextStyle(color: Color(0xff888888), fontSize: 14),
            ),
            SizedBox(
              height: 38,
            ),
            _getAccountTextField(),
            SizedBox(
              height: 29,
            ),
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
        "Create username",
        style: TextStyle(
            color: Color(0xff2A2A2A),
            fontSize: 20,
            fontWeight: FontWeight.bold),
        maxLines: 2,
      ),
    );
  }

  _getAccountTextField() {
    return Container(
      height: 50,
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
      height: 42,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: () {
          if (null != account && account.length > 0) {
            buttonEnable = true;
          } else {
            EasyLoading.showToast('Invalid Username');
          }
        },
        child: Text(
          'Sign Up',
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