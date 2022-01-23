import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/logout_response.dart';

LogoutResponse $LogoutResponseFromJson(Map<String, dynamic> json) {
	final LogoutResponse logoutResponse = LogoutResponse();
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		logoutResponse.status = status;
	}
	return logoutResponse;
}

Map<String, dynamic> $LogoutResponseToJson(LogoutResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['status'] = entity.status;
	return data;
}