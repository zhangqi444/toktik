import 'dart:convert';

import 'package:toktik/common/sp_keys.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/enum/auth_status.dart';
import 'package:toktik/model/response/user_info_ex_response.dart';
import 'package:toktik/net/api.dart';
import 'package:toktik/util/sp_util.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';

class SelfController extends GetxController{

  MainPageScrollController mainPageController = Get.find();
  UserController userController = Get.put(UserController());
  var isLoginUser = true.obs;//是否是登录用户
  var loginUserId = ''.obs;//登录用户的user id
  var loginUserToken = ''.obs;//登录用户的user id
  var loginUserUsername = "".obs;//登录用户的username
  var loginUserEmail = "".obs;//登录用户的username
  var loginUserPhoneNumber = "".obs;//登录用户的username
  var loginUserConfirmationCode = "".obs;
  var isSignUpComplete = true.obs;
  var loginUserPassword = "".obs;

  void init() {
    isLoginUser = true.obs;//是否是登录用户
    loginUserId = ''.obs;//登录用户的user id
    loginUserToken = ''.obs;//登录用户的user id
    loginUserUsername = "".obs;//登录用户的username
    loginUserEmail = "".obs;//登录用户的username
    loginUserPhoneNumber = "".obs;//登录用户的username
    loginUserConfirmationCode = "".obs;
    isSignUpComplete = true.obs;
    loginUserPassword = "".obs;
  }

  ///登录
  Future<String?> login(account, password, isAccountEmail) async {
    var response = await Api.login(account, password);

    if(response == null) return AuthStatus.UNKNOWN.toShortString();

    String? status = response.status;

    if(response.isSignedIn!) {
      String? userId;
      if(isAccountEmail) {
        userId = await userController.loadUserInfoExByEmail(account);
      } else {
        userId = await userController.loadUserInfoExByUsername(account);
      }

      UserInfoExResponse? userInfoExResponse = userController.userExMap[userId];
      if(userInfoExResponse == null || userInfoExResponse.user == null) {
        return AuthStatus.USER_PROFILE_NOT_FOUND.toShortString();
      }

      await setLoginUserAuthInfo(
        email: userInfoExResponse.user!.email,
        username: userInfoExResponse.user!.username,
        userId: userInfoExResponse.user!.id,
        token: response.token,
        persistent: true
      );
    }

    return status;
  }

  Future<String?> logout() async {
    var response = await Api.logout();
    if(response != null) {
      await SPUtil.remove(SPKeys.selfUserInfo);
      init();
      mainPageController.indexBottomBarMainPage.value = 0;
      return response.status;
    }
    return null;
  }

  ///注册
  Future<String?> registerByEmail(email, username, password, confirmPassword) async {
    var response = await Api.registerUser('email', email, username, password, confirmPassword);
    if(response != null) {
      return response.status;
    }
    return null;
  }

  Future<String?> registerByPhone(phone, username, password, confirmPassword) async {
    var response = await Api.registerUser('phone_number', phone, username, password, confirmPassword);

    if(response != null) {
      return response.status;
    }
    return null;
  }

  Future<String?> resendSignUpCode(email) async {
    var response = await Api.resendSignUpCode(email);
    if(response != null) {
      return response.status;
    }
    return null;
  }

  Future<String?> resetPassword(String username) async {
    var response = await Api.resetPassword(username);
    if(response != null) {
      return response.status;
    }
    return null;
  }

  Future<String?> confirmResetPassword(account, password, verificationCode) async {
    var response = await Api.confirmResetPassword(account, password, verificationCode);
    if(response != null) {
      return response.status;
    }
    return null;
  }

  Future<String?> registerVerify(String username, String? email, String verificationCode) async {
    var response = await Api.confirmSignUp(username, verificationCode, null);
    if(response == null && response!.isSignUpComplete == null) {
      return AuthStatus.UNKNOWN.toShortString();
    }

    if(response.isSignUpComplete! && response.status == AuthStatus.SIGN_UP_DONE.toShortString()) {
      String? userId = await userController.createUser(
        username: username,
        email: email,
        phoneNumber: loginUserPhoneNumber.value
      );
      if(userId == null) {
        return AuthStatus.CREATE_USER_PROFILE_FAILED.toShortString();
      }
    }
    return response.status;
  }

  bool isLoginUserById(String id) {
    return !isStringNullOrEmpty(loginUserId.value) && loginUserId.value == id;
  }

  ///获取登录用户的id
  Future<void> load() async {
    init();
    var selfUserInfo = await SPUtil.getString(SPKeys.selfUserInfo);
    
    if(isStringNullOrEmpty(selfUserInfo)) return;

    selfUserInfo = json.decode(selfUserInfo);
    loginUserId.value = selfUserInfo[SPKeys.selfUserInfoId];
    loginUserUsername.value = selfUserInfo[SPKeys.selfUserInfoUsername];
    loginUserToken.value = selfUserInfo[SPKeys.selfUserInfoToken];
    loginUserEmail.value = selfUserInfo[SPKeys.selfUserInfoEmail]?? "";
    loginUserPhoneNumber.value = selfUserInfo[SPKeys.selfUserInfoPhoneNumber]?? "";

    if (isStringNullOrEmpty(loginUserId.value)) return;

    var res = await Api.getCurrentUser();
    if(res == null || res.username != loginUserUsername.value) {
      init();
      return;
    }

    String? userId = await userController.loadUserInfoExByUsername(res.username);
    if(userId != loginUserId.value) {
      init();
      return;
    }
    await setLoginUserAuthInfo(username: res.username, userId: userId, token: "", persistent: true);
  }

  /// TODO: migrate to a datamodel for better organized getting/putting logic
  Future<void> setLoginUserAuthInfo({
    String? email, String? phoneNumber, String? username, String? token, String? userId, persistent = false
  }) async {
    var authInfo = {};

    if (email != null) {
      authInfo[SPKeys.selfUserInfoEmail] = email;
      loginUserEmail.value = email;
    }

    if (phoneNumber != null) {
      authInfo[SPKeys.selfUserInfoPhoneNumber] = phoneNumber;
      loginUserPhoneNumber.value = phoneNumber;
    }

    if (username != null) {
      authInfo[SPKeys.selfUserInfoUsername] = username;
      loginUserUsername.value = username;
    }

    if (token != null) {
      authInfo[SPKeys.selfUserInfoToken] = token;
      loginUserToken.value = token;
    }

    if (userId != null) {
      authInfo[SPKeys.selfUserInfoId] = userId;
      loginUserId.value = userId;
    }

    if(persistent) {
      var selfUserInfo = await SPUtil.getString(SPKeys.selfUserInfo);
      if(selfUserInfo != null) {
        selfUserInfo = jsonDecode(selfUserInfo);
      }
      selfUserInfo = selfUserInfo == null ? {} : selfUserInfo;
      for (MapEntry e in authInfo.entries) {
        selfUserInfo[e.key] = e.value;
      }

      await SPUtil.set(SPKeys.selfUserInfo, jsonEncode(selfUserInfo));
    }
  }
}