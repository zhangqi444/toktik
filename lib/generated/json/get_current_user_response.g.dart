import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/get_current_user_response.dart';

GetCurrentUserResponse $GetCurrentUserResponseFromJson(Map<String, dynamic> json) {
	final GetCurrentUserResponse getCurrentUserResponse = GetCurrentUserResponse();
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		getCurrentUserResponse.username = username;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		getCurrentUserResponse.userId = userId;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		getCurrentUserResponse.status = status;
	}
	return getCurrentUserResponse;
}

Map<String, dynamic> $GetCurrentUserResponseToJson(GetCurrentUserResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['username'] = entity.username;
	data['userId'] = entity.userId;
	data['status'] = entity.status;
	return data;
}