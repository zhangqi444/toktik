import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/logout_response.g.dart';


@JsonSerializable()
class LogoutResponse {

	LogoutResponse();

	factory LogoutResponse.fromJson(Map<String, dynamic> json) => $LogoutResponseFromJson(json);

	Map<String, dynamic> toJson() => $LogoutResponseToJson(this);

  String? status;
}
