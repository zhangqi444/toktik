import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/enum/report.dart';
import 'package:toktik/model/request/report_request.dart';
import 'package:toktik/model/response/report_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

class ReportController extends GetxController{

  SelfController selfController = Get.put(SelfController());

  Future<ReportResponse?> reportPost(String postId, String reason,
      {String? description}) async {
    ReportRequest request = _buildRequest(reason, ReportType.POST, description, postId: postId);
    return await Api.report(request);
  }

  Future<ReportResponse?> reportUser(String targetUserId, String reason,
      {String? description}) async {
    ReportRequest request = _buildRequest(reason, ReportType.USER, description, targetUserId: targetUserId);
    return await Api.report(request);
  }

  ReportRequest _buildRequest(reason, type, description, {postId, targetUserId}) {
    ReportRequest request = ReportRequest();
    request.reportUserId = selfController.loginUserId.value;
    request.reportPostId = postId;
    request.reportTargetUserId = targetUserId;
    request.reason = reason;
    request.type = type;
    request.description = description;
    request.status = ReportStatus.INIT;
    return request;
  }
}