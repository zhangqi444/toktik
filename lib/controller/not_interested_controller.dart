import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/model/response/not_interested_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

import '../enum/notInterested.dart';
import 'feed_controller.dart';

class NotInterestedController extends GetxController{

  SelfController selfController = Get.put(SelfController());
  FeedController feedController = Get.put(FeedController());

  Future<NotInterestedResponse?> notInterestedPost(String postId) async {
    String userId = selfController.loginUserId.value;
    NotInterestedResponse? result = await Api.notInterested(userId, NotInterestedType.POST postId: postId);
    if(result == null) return null;

    feedController.removeFeedListList(postId);
    return result;
  }

  Future<NotInterestedResponse?> notInterestedUser(String targetUserId) async {
    String userId = selfController.loginUserId.value;
    NotInterestedResponse? result = await Api.notInterested(userId, NotInterestedType.USER targetUserId: targetUserId);
    if(result == null) return null;

    feedController.removeFeedListListByUser(targetUserId);
    return result;
  }
}