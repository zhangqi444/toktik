import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {

  TextField usernameField, pwdField, pwdRepeatField;
  String username, pwd, pwdRepeat; // username can be email or a name.
  UserController loginController = Get.find();

  @override
  Widget build(BuildContext context) {

    usernameField = TextField(
      cursorColor:ColorRes.color_1,
      cursorWidth: 2,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Email',
      ),
      onChanged: (text){
        username = text;
      },
    );

    pwdField = TextField(
      cursorColor:ColorRes.color_1,
      cursorWidth: 2,
      obscureText: true,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Password'
      ),
      onChanged: (text){
        pwd = text;
      },
    );

    pwdRepeatField = TextField(
      cursorColor:ColorRes.color_1,
      cursorWidth: 2,
      obscureText: true,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Confirm password'
      ),
      onChanged: (text){
        pwdRepeat = text;
      },
    );

    return Scaffold(
      backgroundColor: ColorRes.color_1,
      appBar: AppBar(
        backgroundColor: ColorRes.color_1,
        elevation: 0,
        leading: TextButton(
          onPressed: (){
            Get.back();
          },
          child: Icon(Icons.close,color: Colors.white,size: 30,),
        ),
      ),
      body: _layoutLogin(context),
    );
  }

  _layoutLogin(BuildContext context) {
    return Container(
      child:  Container(
          height: 400,
          margin: EdgeInsets.only(top: 150),
          child: Column(
              children: [
                _getAccountTextField(),
                SizedBox(height: 10,),
                _getPwdTextField(),
                SizedBox(height: 10,),
                _getPwdRepeatTextField(),
                SizedBox(height: 20,),
               _getRegister(context),
              ],
            ),
      ),
    );
  }

  _getAccountTextField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 60,right: 60),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: usernameField,
    );
  }

  _getPwdTextField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 60,right: 60),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      child: pwdField,
    );
  }

  _getPwdRepeatTextField() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 60,right: 60),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      child: pwdRepeatField,
    );
  }

  _getRegister(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: 60,right: 60),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: (){
          if(null != username && username.length > 0
              && null != pwd && pwd.length > 0
              && null != pwdRepeat && pwdRepeat.length>0){

            if(pwd == pwdRepeat){
              loginController.registerByEmail(username, pwd, pwdRepeat);
            } else {
              EasyLoading.showToast('The password confirmation did not match with the password.');
            }

          } else {
            EasyLoading.showToast('Please fill in the missing field.');
          }
        },
        child: Text('Create account',style: TextStyle(color: Colors.white,fontSize: 20),),
        color: ColorRes.color_3,
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(5)
        ),
      ),
    );
  }


}