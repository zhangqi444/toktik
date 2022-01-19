
import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/report_request.g.dart';

@JsonSerializable()
class ReportRequest {

	ReportRequest();

	factory ReportRequest.fromJson(Map<String, dynamic> json) => $ReportRequestFromJson(json);

	Map<String, dynamic> toJson() => $ReportRequestToJson(this);

	String? id;
	String? reason;
	String? description;
	String? status;
	String? type;
	String? result;
	String? reportPostId;
	String? reportUserId;
	String? reportReporterId;
}
