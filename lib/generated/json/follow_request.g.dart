import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/request/follow_request.dart';

FollowRequest $FollowRequestFromJson(Map<String, dynamic> json) {
	final FollowRequest followRequest = FollowRequest();
	final int? actionType = jsonConvert.convert<int>(json['actionType']);
	if (actionType != null) {
		followRequest.actionType = actionType;
	}
	final String? relationUserId = jsonConvert.convert<String>(json['relationUserId']);
	if (relationUserId != null) {
		followRequest.relationUserId = relationUserId;
	}
	return followRequest;
}

Map<String, dynamic> $FollowRequestToJson(FollowRequest entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['actionType'] = entity.actionType;
	data['relationUserId'] = entity.relationUserId;
	return data;
}