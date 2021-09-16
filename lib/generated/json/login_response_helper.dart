import 'package:toktik/model/response/login_response.dart';

loginResponseFromJson(LoginResponse data, Map<String, dynamic> json) {
	if (json['username'] != null) {
		data.username = json['username'].toString();
	}
	if (json['token'] != null) {
		data.token = json['token'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['isSignedIn'] != null) {
		data.isSignedIn = json['isSignedIn'];
	}
	return data;
}

Map<String, dynamic> loginResponseToJson(LoginResponse entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['username'] = entity.username;
	data['token'] = entity.token;
	data['status'] = entity.status;
	data['isSignedIn'] = entity.isSignedIn;
	return data;
}