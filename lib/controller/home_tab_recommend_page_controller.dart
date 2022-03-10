import 'dart:async';

import 'package:toktik/controller/feed_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeTabRecommendPageController extends GetxController{

  //热门推荐
  final RxList<String?> feedList = <String>[].obs;

  String? nextToken;
  int limit = 100;

  FeedController _feedController = Get.put(FeedController());
  SelfController _selfController = Get.put(SelfController());

  Future<bool> loadFeedList()async{
    String userId = _selfController.loginUserId.value;
    var result = await Api.getHotFeedList(nextToken, limit, userId);
    var loaded = false;
    if(result != null){
      feedList.addAll(
        result.xList!.where((e) => e!.id != null).map((e) => e!.id as String).toList()
      );
      feedList.value = feedList.toSet().toList();
      result.xList!.forEach((element) {
        _feedController.feedListListMap[element!.id] = element;
      });
      nextToken = result.nextToken;
      loaded = true;
    }

    return loaded;
  }
  
  void updateFeedListList(String? id, FeedListList? feedListList) {
    _feedController.updateFeedListList(id, feedListList);
  }

  void removeFeedListList(String id) {
    _feedController.removeFeedListList(id);
    feedList.remove(id);
  }

  void removeFeedListListByUser(String userId) {
    feedList.value = feedList.where((c) {
      if(_feedController.feedListListMap[c]!.user!.id == userId) {
        _feedController.removeFeedListList(c!);
        return false;
      }
      return true;
    }).toList();
  }

  void refreshFeedList() async {
    nextToken = "";
    feedList.clear();
    await loadFeedList();
  }

  List<FeedListList?>? getFeedList() {
    return feedList.map(
      (element) => _feedController.feedListListMap[element]
    ).toList();
  }
}