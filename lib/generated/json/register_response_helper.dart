import 'package:toktik/model/response/register_response.dart';

registerResponseFromJson(RegisterResponse data, Map<String, dynamic> json) {
	if (json['isSignUpComplete'] != null) {
		data.isSignUpComplete = json['isSignUpComplete'];
	}
	if (json['username'] != null) {
		data.username = json['username'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	return data;
}

Map<String, dynamic> registerResponseToJson(RegisterResponse entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['isSignUpComplete'] = entity.isSignUpComplete;
	data['username'] = entity.username;
	data['status'] = entity.status;
	return data;
}