import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/register_response.dart';

RegisterResponse $RegisterResponseFromJson(Map<String, dynamic> json) {
	final RegisterResponse registerResponse = RegisterResponse();
	final bool? isSignUpComplete = jsonConvert.convert<bool>(json['isSignUpComplete']);
	if (isSignUpComplete != null) {
		registerResponse.isSignUpComplete = isSignUpComplete;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		registerResponse.username = username;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		registerResponse.status = status;
	}
	return registerResponse;
}

Map<String, dynamic> $RegisterResponseToJson(RegisterResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['isSignUpComplete'] = entity.isSignUpComplete;
	data['username'] = entity.username;
	data['status'] = entity.status;
	return data;
}