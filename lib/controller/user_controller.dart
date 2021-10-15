import 'dart:collection';
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/common/sp_keys.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/model/request/follow_request.dart';
import 'package:toktik/model/response/follow_response.dart';
import 'package:toktik/model/response/user_info_ex_response.dart';
import 'package:toktik/model/response/user_info_response.dart';
import 'package:toktik/model/response/user_work_list_response.dart';
import 'package:toktik/net/api.dart';
import 'package:toktik/util/sp_util.dart';
import 'package:get/get.dart';

enum AuthStatus {
  USERNAME_EXISTS,
  INVALID_PASSWORD,
  CONFIRM_SIGN_UP_STEP,
  INVALID_SIGN_IN_STATE,
  SIGN_UP_DONE,
  SIGN_IN_DONE,
  USER_NOT_FOUND,
  NOT_AUTHORIZED
}

extension ParseToString on AuthStatus {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class UserController extends GetxController{

  MainPageScrollController mainPageController = Get.find();
  final userInfoResponse = UserInfoResponse().obs;//用户信息
  final userInfoExResponse = UserInfoExResponse().obs;//用户信息（扩展）
  final isLoginUser = true.obs;//是否是登录用户
  final loginUserId = ''.obs;//登录用户的user id
  final loginUserUsername = "".obs;//登录用户的username
  final isSignUpComplete = true.obs;
  final loginUserSignUpPassword = "".obs;

  //--------用户作品列表-------------
  final userWorkList = <UserWorkListList>[].obs;
  int cursor = 0;
  int count = 10;
  bool hasMore = true;
  //--------用户作品列表-------------

  ///登录
  void login(String username, String pwd) async {
    username = username.split('@')[0];
    var response = await Api.login(username, pwd);

    if(response != null && response.isSignedIn) {
      await getUserInfoExByUsername(response.username);
      if(userInfoExResponse.value == null || userInfoExResponse.value.user == null) {
        await createUser(response.username);
      }

      SPUtil.set(SPKeys.username, response.username);
      SPUtil.set(SPKeys.token, response.token);
      SPUtil.set(SPKeys.userId, userInfoExResponse.value.user.id);

      Get.offAllNamed(Routers.scroll);
      mainPageController.selectIndexBottomBarMainPage(0);
      return;
    }

    if(response != null && response.status == AuthStatus.USER_NOT_FOUND.toShortString()) {
      SPUtil.set(SPKeys.username, response.username);
      Get.toNamed(Routers.register);
      return;
    }

    EasyLoading.showToast('Check your info and try again.');
  }

  ///注册
  void registerByEmail(String email, String pwd, String pwdRepeat) async{
    String username = email.split("@")[0];
    var response = await Api.registerByEmail(email, username, pwd, pwdRepeat);
    if(response != null) {
      SPUtil.set(SPKeys.username, response.username);
      loginUserUsername.value = response.username;
      isSignUpComplete.value = response.isSignUpComplete;
      if(isSignUpComplete.value == false) {
        if(response.status == AuthStatus.USERNAME_EXISTS.toShortString()) {
          EasyLoading.showToast('The username or email is existing already, please try again.');
        } else if(response.status == AuthStatus.CONFIRM_SIGN_UP_STEP.toShortString()) {
          loginUserSignUpPassword.value = pwd;
          Get.toNamed(Routers.registerVerify);
        } else {
          EasyLoading.showToast('Failed to send verification code, please try again.');
        }
      } else {
        if(response.status == AuthStatus.SIGN_UP_DONE.toShortString()) {
          await login(response.username, pwd);
        }
      } // reset the tmp password
    }
  }

  void registerVerify(String verificationCode) async {
    var response = await Api.confirmSignUp(loginUserUsername.value, verificationCode, null);
    if(response != null && response.isSignUpComplete && response.status == AuthStatus.SIGN_UP_DONE.toShortString())  {
      var pwd = loginUserSignUpPassword.value;
      loginUserSignUpPassword.value = '';
      await login(response.username, pwd);
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

  ///获取用户资料信息(扩展)
  void getUserInfoEx(String id) async{
    var response = await Api.getUserInfoEx(id);
    if(response != null) {
      userInfoExResponse.value = response;
    }
  }

  ///获取用户资料信息(扩展)
  void getUserInfoExByUsername(String username) async{
    var response = await Api.getUserInfoExByUsername(username);
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
    if(!loginUserId.value.isEmpty) return loginUserId.value;
    return await SPUtil.getString(SPKeys.userId);
  }

  ///获取用户作品列表
  void getUserWorkList(String id)async{
    var result = await Api.getUserFeedList(id, cursor, count);
    userWorkList.value.addAll(result.xList);
    cursor = result.cursor;
  }

  ///关注
  Future<FollowResponse> follow(int followType, String id)async{
    FollowRequest request = FollowRequest();
    request.actionType = followType;
    request.relationUserId = id;
    var result = await Api.follow(request);
    return result;
  }
}