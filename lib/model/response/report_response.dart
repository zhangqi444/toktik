import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/report_response.g.dart';


@JsonSerializable()
class ReportResponse {

	ReportResponse();

	factory ReportResponse.fromJson(Map<String, dynamic> json) => $ReportResponseFromJson(json);

	Map<String, dynamic> toJson() => $ReportResponseToJson(this);

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
