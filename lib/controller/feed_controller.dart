import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/model/request/publish_feed_request.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/model/response/publish_feed_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

class FeedController extends GetxController{

  //热门推荐
  final RxMap<String?, FeedListList?> feedListListMap = <String, FeedListList>{}.obs;

  //好友列表
  final RxList<FeedListList?> friendFeedList = <FeedListList>[].obs;
  int? cursorFriend = 0;
  int countFriend = 10;

  SelfController _selfController = Get.put(SelfController());

  ///发布单个视频
  Future<String?> publishFeed(String title,String? videoUrl,String? coverImgUrl,int duration,int width,int height) async {
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

  void updateFeedListList(String? id, FeedListList? feedListList) {
    feedListListMap[id] = feedListList;
  }

  void removeFeedListList(String id) {
    feedListListMap.remove(id);
  }

}