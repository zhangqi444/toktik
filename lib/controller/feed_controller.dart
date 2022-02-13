import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/model/request/publish_feed_request.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/model/response/publish_feed_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedController extends GetxController{

  //热门推荐
  final RxList<String?> hotFeedList = <String>[].obs;
  final RxMap<String?, FeedListList?> feedListListMap = <String, FeedListList>{}.obs;
  int? cursor = 0;
  // 100 is the largest number could support, which will be filtered by the listPostExs api.
  // https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html#limits-expression-parameters
  int count = 100; 

  //好友列表
  final RxList<FeedListList?> friendFeedList = <FeedListList>[].obs;
  int? cursorFriend = 0;
  int countFriend = 10;

  SelfController _selfController = Get.put(SelfController());

  ///发布单个视频
  Future<String?> publishFeed(String title,String? videoUrl,String? coverImgUrl,int duration,int width,int height) async{
    PublishFeedRequest publishFeedRequest = PublishFeedRequest();
    PublishFeedContent publishFeedContent = PublishFeedContent();
    PublishFeedLocation publishFeedLocation = PublishFeedLocation();
    List<PublishFeedContentTag> tags = [];
    List<PublishFeedContentAt> ats = [];
    List<PublishFeedContentAttachmants> attachments = [];
    PublishFeedContentMusic music = PublishFeedContentMusic();
    PublishFeedContentAttachmants publishFeedContentAttachmants = PublishFeedContentAttachmants();

    publishFeedRequest.type = 4;//默认成视频，
    publishFeedRequest.content = publishFeedContent;
    publishFeedContent.text = title;
    publishFeedContentAttachmants.type = 2;
    publishFeedContentAttachmants.url = videoUrl;
    publishFeedContentAttachmants.cover = coverImgUrl;
    publishFeedContentAttachmants.gifCover = '-1';
    publishFeedContentAttachmants.duration = duration;
    publishFeedContentAttachmants.width = width;
    publishFeedContentAttachmants.height = height;
    attachments.add(publishFeedContentAttachmants);
    publishFeedContent.attachments = attachments;

    var result = await (Api.publishFeed(publishFeedRequest) as FutureOr<PublishFeedResponse>);
    if(null != result){
      EasyLoading.showToast('发布成功');
      Get.back();
    }
    return result.id;
  }

  Future<bool> loadHotFeedList(RefreshController refreshController)async{
    String userId = _selfController.loginUserId.value;
    var result = await Api.getHotFeedList(cursor, count, userId);
    if(result != null){
      hotFeedList.addAll(result.xList!.map((e) => e!.id));
      result.xList!.forEach((element) {
        feedListListMap[element!.id] = element;
      });
      cursor = result.cursor;
      refreshController.loadComplete();
      return true;
    }else{
      return false;
    }

  }
  
  void updateFeedListList(String? id, FeedListList? feedListList) {
    feedListListMap[id] = feedListList;
  }

  void removeFeedListList(String id) {
    feedListListMap.remove(id);
    hotFeedList.remove(id);
  }

  void removeFeedListListByUser(String userId) {
    hotFeedList.value = hotFeedList.where((c) {
      if(feedListListMap[c]!.user!.id == userId) {
        feedListListMap.remove(c);
        return false;
      }
      return true;
    }).toList();
  }

  void refreshHotFeedList(RefreshController refreshController)async{
    cursor = 0;
    hotFeedList.clear();
    feedListListMap.clear();
    await loadHotFeedList(refreshController);
    refreshController.refreshCompleted();
  }

  ///获取好友视频列表
  Future<bool> getFriendFeedList(RefreshController refreshController)async{
    var result = await Api.getFriendFeedList(cursorFriend, countFriend);
    if(result != null){
      friendFeedList.addAll(result.xList!);
      cursorFriend = result.cursor;
      refreshController.loadComplete();
      return true;
    }else{
      return false;
    }

  }

  void refreshFriendFeedList(RefreshController refreshController)async{
    cursorFriend = 0;
    friendFeedList.clear();
    await getFriendFeedList(refreshController);
    refreshController.refreshCompleted();
  }
}