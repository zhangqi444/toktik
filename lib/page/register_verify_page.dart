import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

class RegisterVerifyPage extends StatefulWidget {

  @override
  _RegisterVerifyPageState createState() {
    return _RegisterVerifyPageState();
  }
}

class _RegisterVerifyPageState extends State<RegisterVerifyPage> {

  TextField verificationCodeTextField;
  String verificationCode; // account is email
  UserController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    EasyLoading.init();
    verificationCodeTextField = TextField(
      cursorColor:ColorRes.color_1,
      cursorWidth: 2,
      obscureText: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '6-digit verification code'
      ),
      onChanged: (text){
        verificationCode = text;
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
      child: verificationCodeTextField,
    );
  }

  _getRegister(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: 60,right: 60),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        onPressed: (){
          if(null != verificationCode
              && verificationCode.length == 6){
              loginController.registerVerify(verificationCode);
          } else {
            EasyLoading.showToast('Please fill in the missing field.');
          }
        },
        child: Text('Enter',style: TextStyle(color: Colors.white,fontSize: 20),),
        color: ColorRes.color_3,
        shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(5)
        ),
      ),
    );
  }


}