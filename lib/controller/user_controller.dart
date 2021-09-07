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

class UserController extends GetxController{

  MainPageScrollController mainPageController = Get.find();
  final userInfoResponse = UserInfoResponse().obs;//用户信息
  final userInfoExResponse = UserInfoExResponse().obs;//用户信息（扩展）
  final isLoginUser = true.obs;//是否是登录用户
  final loginUserUid = 0.obs;//登录用户的uid

  //--------用户作品列表-------------
  final userWorkList = <UserWorkListList>[].obs;
  int cursor = 0;
  int count = 10;
  bool hasMore = true;
  //--------用户作品列表-------------

  ///登录
  void login(String account,String pwd) async{
    var response = await Api.login(account, pwd);
    SPUtil.set(SPKeys.userUid, response.uid);
    SPUtil.set(SPKeys.token, response.token);

    Get.offNamed(Routers.scroll);
    mainPageController.selectIndexBottomBarMainPage(0);

    EasyLoading.showToast('登录成功');
  }

  ///注册
  void register(String account,String pwd,String pwdRepeat) async{
    var response = await Api.register(account, pwd, pwdRepeat);
    SPUtil.set(SPKeys.userUid, response.uid);
    SPUtil.set(SPKeys.token, response.token);
    Get.offAllNamed(Routers.scroll);
    mainPageController.selectIndexBottomBarMainPage(0);
    EasyLoading.showToast('注册成功');
  }

  ///获取用户资料信息
  void getUserInfo(String uid) async{
    var response = await Api.getUserInfo(uid);
    userInfoResponse.value = response;
  }

  ///获取用户资料信息(扩展)
  void getUserInfoEx(String uid) async{
    var response = await Api.getUserInfoEx(uid);
    if(response != null) {
      userInfoExResponse.value = response;
    }
  }

  ///更新用户资料
  void updateUserInfo() async{
    Map<String,dynamic> map = HashMap();
    map['uid'] = userInfoResponse.value.uid;
    map['nickname'] = userInfoResponse.value.nickname;
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
  void isLoginUserByUid(int uid)async{
    int loginUserUid = await SPUtil.getInt(SPKeys.userUid);
    if(loginUserUid == uid){
      isLoginUser.value = true;
    }else{
      isLoginUser.value = false;
    }
  }

  ///获取登录用户的uid
  void getLoginUserUid(){
    SPUtil.getInt(SPKeys.userUid).then((uid){
      // TODO: add the correct default uid
      // loginUserUid.value = uid == null ? "f96e082f-9fff-4ebd-ac14-8cf8b42ba8d4" : uid;
      loginUserUid.value = uid == null ? 3 : uid;
    });
  }

  ///获取用户作品列表
  void getUserWorkList(int uid)async{
    var result = await Api.getUserFeedList(uid, cursor, count);
    userWorkList.value.addAll(result.xList);
    cursor = result.cursor;
  }

  ///关注
  Future<FollowResponse> follow(int followType,int uid)async{
    FollowRequest request = FollowRequest();
    request.actionType = followType;
    request.relationUid = uid;
    var result = await Api.follow(request);
    return result;
  }
}