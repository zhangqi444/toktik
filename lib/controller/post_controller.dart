import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/model/response/like_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

class PostController extends GetxController{

  SelfController selfController = Get.put(SelfController());

  void viewPost(String postId) async {
    String userId = selfController.loginUserId.value;
    await Api.viewPost(postId, userId);
  }

  Future<LikeResponse> likePost(String postId, bool value) async {
    String userId = selfController.loginUserId.value;
    return await Api.likePost(postId, userId, value);
  }
}