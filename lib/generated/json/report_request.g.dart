import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/request/report_request.dart';

ReportRequest $ReportRequestFromJson(Map<String, dynamic> json) {
	final ReportRequest reportRequest = ReportRequest();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		reportRequest.id = id;
	}
	final String? reason = jsonConvert.convert<String>(json['reason']);
	if (reason != null) {
		reportRequest.reason = reason;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		reportRequest.description = description;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		reportRequest.status = status;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		reportRequest.type = type;
	}
	final String? result = jsonConvert.convert<String>(json['result']);
	if (result != null) {
		reportRequest.result = result;
	}
	final String? reportPostId = jsonConvert.convert<String>(json['reportPostId']);
	if (reportPostId != null) {
		reportRequest.reportPostId = reportPostId;
	}
	final String? reportUserId = jsonConvert.convert<String>(json['reportUserId']);
	if (reportUserId != null) {
		reportRequest.reportUserId = reportUserId;
	}
	final String? reportReporterId = jsonConvert.convert<String>(json['reportReporterId']);
	if (reportReporterId != null) {
		reportRequest.reportReporterId = reportReporterId;
	}
	return reportRequest;
}

Map<String, dynamic> $ReportRequestToJson(ReportRequest entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['reason'] = entity.reason;
	data['description'] = entity.description;
	data['status'] = entity.status;
	data['type'] = entity.type;
	data['result'] = entity.result;
	data['reportPostId'] = entity.reportPostId;
	data['reportUserId'] = entity.reportUserId;
	data['reportReporterId'] = entity.reportReporterId;
	return data;
}