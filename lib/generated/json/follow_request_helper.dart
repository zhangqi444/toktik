import 'package:toktik/model/request/follow_request.dart';

followRequestFromJson(FollowRequest data, Map<String, dynamic> json) {
	if (json['actionType'] != null) {
		data.actionType = json['actionType'] is String
				? int.tryParse(json['actionType'])
				: json['actionType'].toInt();
	}
	if (json['relationUserId'] != null) {
		data.relationUserId = json['relationUserId'].toString();
	}
	return data;
}

Map<String, dynamic> followRequestToJson(FollowRequest entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['actionType'] = entity.actionType;
	data['relationUserId'] = entity.relationUserId;
	return data;
}