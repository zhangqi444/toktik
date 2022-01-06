import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/model/request/follow_request.dart';
import 'package:toktik/model/response/follow_response.dart';
import 'package:toktik/model/response/user_info_ex_response.dart';
import 'package:toktik/model/response/user_info_response.dart';
import 'package:toktik/model/response/user_work_list_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

class UserController extends GetxController{

  MainPageScrollController mainPageController = Get.find();

  final userExMap = {}.obs;

  final isLoginUser = true.obs;//是否是登录用户

  //--------用户作品列表-------------
  final userWorkList = <UserWorkListList>[].obs;
  int cursor = 0;
  int count = 10;
  bool hasMore = true;
  //--------用户作品列表-------------


  Future<String> createUser({String username, String email, String phoneNumber}) async {
    var response = await Api.createUser(username: username, email: email, phoneNumber: phoneNumber);
    if(response != null && response.user != null) {
      userExMap[response.user.id] = response;
      return response.user.id;
    }
  }

  // ///更新用户资料
  // void updateUserInfo(userInfoResponse) async{
  //   Map<String, dynamic> map = {};
  //   map['id'] = userInfoResponse.id;
  //   map['username'] = userInfoResponse.username;
  //   map['portrait'] = userInfoResponse.portrait;
  //   map['bio'] = userInfoResponse.bio;
  //   map['birth'] = userInfoResponse.birth;
  //   map['gender'] = userInfoResponse.gender;
  //   map['city'] = userInfoResponse.city;
  //   map['profession'] = userInfoResponse.profession;
  //
  //   var response = await Api.updateUserInfo(map);
  //   userExMap[userInfoResponse.id] = response;
  // }
  //
  ///获取用户资料信息(扩展)
  void loadUserInfoExById(String id) async{
    if(userExMap[id] == null) {
      var response = await Api.getUserInfoEx(id);
      if(response != null) {
        userExMap[response.user.id] = response;
      }
    }
  }

  ///获取用户资料信息(扩展)
  Future<String> loadUserInfoExByUsername(String username) async{
    var response = await Api.getUserInfoExByUsername(username);
    if(response != null) {
      userExMap[response.user.id] = response;
      return response.user.id;
    }
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