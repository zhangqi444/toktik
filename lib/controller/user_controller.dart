import 'dart:async';

import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/model/request/follow_request.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/model/response/follow_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';

import 'feed_controller.dart';
import 'self_controller.dart';

class UserController extends GetxController{

  MainPageScrollController mainPageController = Get.find();

  final userExMap = {}.obs;

  final isLoginUser = true.obs;//是否是登录用户

  final RxMap<String, List<String>> feedLists = <String, List<String>>{}.obs;

  String? nextToken;
  int limit = 1000;

  FeedController _feedController = Get.put(FeedController());

  Future<String?> createUser({String? username, String? email, String? phoneNumber}) async {
    var response = await Api.createUser(username: username, email: email, phoneNumber: phoneNumber);
    if(response != null && response.user != null) {
      userExMap[response.user!.id] = response;
      return response.user!.id;
    }
    return null;
  }

  Future<bool> loadFeedListByUser(String userId) async {
    
    var result = await Api.getPostsByUser(nextToken, limit, userId);
    var loaded = false;
    if(result != null){
      var feedList = feedLists[userId]?? [];
      feedList.addAll(
        result.xList!.where((e) => e!.id != null).map((e) => e!.id as String).toList()
      );
      feedList = feedList.toSet().toList();
      result.xList!.forEach((element) {
        /// Only update the not existing post, as the isLiked data is not returned.
        if(element == null || _feedController.feedListListMap[element.id] != null) return;
        _feedController.feedListListMap[element.id] = element;
      });
      nextToken = result.nextToken;
      loaded = true;
      feedLists[userId] = feedList;
    }

    return loaded;
  }

  List<FeedListList?>? getFeedList(String userId) {
    return feedLists[userId]?.map(
      (element) => _feedController.feedListListMap[element]
    ).toList();
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
  Future<void> loadUserInfoExById(String? id) async{
    if(isStringNullOrEmpty(id)) return;

    var response = await Api.getUserInfoEx(id);
    if(response == null) return null;
    userExMap[response.user!.id] = response;
  }

  ///获取用户资料信息(扩展)
  Future<String?> loadUserInfoExByUsername(String? username) async{
    var response = await Api.getUserInfoExByUsername(username);
    if(response == null) return null;

    userExMap[response.user!.id] = response;
    return response.user!.id;
  }

  Future<String?> loadUserInfoExByEmail(String email) async{
    var response = await Api.getUserInfoExByEmail(email);
    if(response == null) return null;

    userExMap[response.user!.id] = response;
    return response.user!.id;
  }

  ///关注
  Future<FollowResponse?> follow(int followType, String id)async{
    FollowRequest request = FollowRequest();
    request.actionType = followType;
    request.relationUserId = id;
    var result = await Api.follow(request);
    return result;
  }
}