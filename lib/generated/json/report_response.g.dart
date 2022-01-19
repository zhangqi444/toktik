import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/report_response.dart';

ReportResponse $ReportResponseFromJson(Map<String, dynamic> json) {
	final ReportResponse reportResponse = ReportResponse();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		reportResponse.id = id;
	}
	final String? reason = jsonConvert.convert<String>(json['reason']);
	if (reason != null) {
		reportResponse.reason = reason;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		reportResponse.description = description;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		reportResponse.status = status;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		reportResponse.type = type;
	}
	final String? result = jsonConvert.convert<String>(json['result']);
	if (result != null) {
		reportResponse.result = result;
	}
	final String? reportPostId = jsonConvert.convert<String>(json['reportPostId']);
	if (reportPostId != null) {
		reportResponse.reportPostId = reportPostId;
	}
	final String? reportUserId = jsonConvert.convert<String>(json['reportUserId']);
	if (reportUserId != null) {
		reportResponse.reportUserId = reportUserId;
	}
	final String? reportReporterId = jsonConvert.convert<String>(json['reportReporterId']);
	if (reportReporterId != null) {
		reportResponse.reportReporterId = reportReporterId;
	}
	return reportResponse;
}

Map<String, dynamic> $ReportResponseToJson(ReportResponse entity) {
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