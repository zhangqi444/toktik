import 'dart:collection';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/common/sp_keys.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/enum/auth_status.dart';
import 'package:toktik/model/response/user_info_ex_response.dart';
import 'package:toktik/model/response/user_info_response.dart';
import 'package:toktik/net/api.dart';
import 'package:toktik/util/sp_util.dart';
import 'package:get/get.dart';

class SelfController extends GetxController{

  MainPageScrollController mainPageController = Get.find();
  UserController userController = Get.find();
  final userInfoResponse = UserInfoResponse().obs;//用户信息
  final userInfoExResponse = UserInfoExResponse().obs;//用户信息（扩展）
  final isLoginUser = true.obs;//是否是登录用户
  final loginUserId = ''.obs;//登录用户的user id
  final loginUserUsername = "".obs;//登录用户的username
  final loginUserEmail = "".obs;//登录用户的username
  final isSignUpComplete = true.obs;
  final loginUserPassword = "111111zq".obs;

  ///登录
  void login() async {
    var response = await Api.login(
        (loginUserUsername.value == null || loginUserUsername.value.isEmpty)
            ? loginUserEmail.value
            : loginUserUsername.value,
        loginUserPassword.value
    );

    if(response != null && response.isSignedIn) {
      if(response.username != null) {
        loginUserUsername.value = response.username;
      }
      await userController.getUserInfoExByUsername(loginUserUsername.value);
      if(userInfoExResponse.value == null || userInfoExResponse.value.user == null) {
        await createUser(loginUserUsername.value);
      }

      SPUtil.set(SPKeys.username, loginUserUsername.value);
      SPUtil.set(SPKeys.token, response.token);
      SPUtil.set(SPKeys.userId, userInfoExResponse.value.user.id);

      Get.offAllNamed(Routers.scroll);
      mainPageController.selectIndexBottomBarMainPage(0);
      return;
    }

    if(response != null && response.status == AuthStatus.USER_NOT_FOUND.toShortString()) {
      SPUtil.set(SPKeys.username, loginUserUsername.value);
      Get.toNamed(Routers.signUp);
      return;
    }

    EasyLoading.showToast('Check your info and try again.');
  }

  ///注册
  void registerByEmail() async{
    // if the username is not provided, email prefix will be used as the default username
    if(loginUserUsername.value == "") {
      loginUserUsername.value = loginUserEmail.value.split("@")[0];
    };
    String username = loginUserUsername.value;
    var response = await Api.registerByEmail(
        loginUserEmail.value,
        loginUserUsername.value,
        loginUserPassword.value,
        loginUserPassword.value);
    if(response != null) {
      SPUtil.set(SPKeys.username, response.username);
      loginUserUsername.value = response.username;
      isSignUpComplete.value = response.isSignUpComplete;
      if(isSignUpComplete.value == false) {
        if(response.status == AuthStatus.USERNAME_EXISTS.toShortString()) {
          EasyLoading.showToast('The username or email is existing already, please try again.');
        } else if(response.status == AuthStatus.CONFIRM_SIGN_UP_STEP.toShortString()) {
          Get.toNamed(Routers.signUpVerify);
        } else {
          EasyLoading.showToast('Failed to send verification code, please try again.');
        }
      } else {
        if(response.status == AuthStatus.SIGN_UP_DONE.toShortString()) {
          await login();
        }
      } // reset the tmp password
    }
  }

  void registerVerify(String verificationCode) async {
    var response = await Api.confirmSignUp(loginUserUsername.value, verificationCode, null);
    if(response != null && response.isSignUpComplete && response.status == AuthStatus.SIGN_UP_DONE.toShortString())  {
      loginUserUsername.value = response.username != null ? response.username : loginUserUsername.value;
      await login();
    } else {
      EasyLoading.showToast('Failed to verify the email, please try again.');
    }
  }

  void createUser(String username) async {
    var response = await Api.createUser(username);
    if(response != null) {
      userInfoExResponse.value = response;
    }
  }

  ///更新用户资料
  void updateUserInfo() async{
    Map<String,dynamic> map = HashMap();
    map['id'] = userInfoResponse.value.id;
    map['username'] = userInfoResponse.value.username;
    map['portrait'] = userInfoResponse.value.portrait;
    map['bio'] = userInfoResponse.value.bio;
    map['birth'] = userInfoResponse.value.birth;
    map['gender'] = userInfoResponse.value.gender;
    map['city'] = userInfoResponse.value.city;
    map['profession'] = userInfoResponse.value.profession;

    var response = await Api.updateUserInfo(map);
    userInfoResponse.value = response;
  }

  ///判断是否是登录用户
  void isLoginUserById(String id)async{
    String loginUserId = await SPUtil.getString(SPKeys.userId);
    if(loginUserId == id){
      isLoginUser.value = true;
    }else{
      isLoginUser.value = false;
    }
  }

  ///获取登录用户的id
  void loadLoginUserId(){
    SPUtil.getString(SPKeys.userId).then((id){
      loginUserId.value = id;
    });
  }

  ///获取登录用户的id
  Future<String> getLoginUserId() async{
    if(loginUserId.value != null && loginUserId.value.isNotEmpty) return loginUserId.value;
    return await SPUtil.getString(SPKeys.userId);
  }
}