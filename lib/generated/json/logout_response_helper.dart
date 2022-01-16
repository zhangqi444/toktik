import 'package:toktik/model/response/logout_response.dart';

logoutResponseFromJson(LogoutResponse data, Map<String, dynamic> json) {
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	return data;
}

Map<String, dynamic> logoutResponseToJson(LogoutResponse entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['status'] = entity.status;
	return data;
}