import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/enum/report.dart';
import 'package:toktik/model/request/report_request.dart';
import 'package:toktik/model/response/like_response.dart';
import 'package:toktik/model/response/report_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

class PostController extends GetxController{

  SelfController selfController = Get.put(SelfController());

  void viewPost(String? postId) async {
    String userId = selfController.loginUserId.value;
    await Api.viewPost(postId, userId);
  }

  Future<LikeResponse?> likePost(String? postId, bool value) async {
    String userId = selfController.loginUserId.value;
    return await Api.likePost(postId, userId, value);
  }

  Future<ReportResponse?> reportPost(String postId, String reason,
      {String? description}) async {

    ReportRequest request = ReportRequest();
    request.reportReporterId = selfController.loginUserId.value;
    request.reportPostId = postId;
    request.reason = reason;
    request.type = ReportType.POST;
    request.description = description;
    request.status = ReportStatus.INIT;

    return await Api.report(request);
  }
}