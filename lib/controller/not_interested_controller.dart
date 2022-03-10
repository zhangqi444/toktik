import 'package:toktik/controller/home_tab_recommend_page_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/model/response/not_interested_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

import '../enum/not_interested.dart';

class NotInterestedController extends GetxController{

  SelfController selfController = Get.put(SelfController());
  HomeTabRecommendPageController homeTabRecommendPageController = Get.put(HomeTabRecommendPageController());

  Future<NotInterestedResponse?> notInterestedPost(String postId) async {
    String userId = selfController.loginUserId.value;
    NotInterestedResponse? result = await Api.notInterested(userId, NotInterestedType.POST postId: postId);
    if(result == null) return null;

    homeTabRecommendPageController.removeFeedListList(postId);
    return result;
  }

  Future<NotInterestedResponse?> notInterestedUser(String targetUserId) async {
    String userId = selfController.loginUserId.value;
    NotInterestedResponse? result = await Api.notInterested(userId, NotInterestedType.USER targetUserId: targetUserId);
    if(result == null) return null;

    homeTabRecommendPageController.removeFeedListListByUser(targetUserId);
    return result;
  }
}