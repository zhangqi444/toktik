import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

class PostController extends GetxController{

  UserController userController = Get.put(UserController());

  void viewPost(String postId) async {
    String userId = await userController.getLoginUserId();
    await Api.viewPost(postId, userId);
  }
}