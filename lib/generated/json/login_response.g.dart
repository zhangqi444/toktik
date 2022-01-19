import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/login_response.dart';

LoginResponse $LoginResponseFromJson(Map<String, dynamic> json) {
	final LoginResponse loginResponse = LoginResponse();
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		loginResponse.username = username;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		loginResponse.token = token;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		loginResponse.status = status;
	}
	final bool? isSignedIn = jsonConvert.convert<bool>(json['isSignedIn']);
	if (isSignedIn != null) {
		loginResponse.isSignedIn = isSignedIn;
	}
	return loginResponse;
}

Map<String, dynamic> $LoginResponseToJson(LoginResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['username'] = entity.username;
	data['token'] = entity.token;
	data['status'] = entity.status;
	data['isSignedIn'] = entity.isSignedIn;
	return data;
}