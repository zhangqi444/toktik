import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/follow_response.dart';

FollowResponse $FollowResponseFromJson(Map<String, dynamic> json) {
	final FollowResponse followResponse = FollowResponse();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		followResponse.id = id;
	}
	final int? actionType = jsonConvert.convert<int>(json['actionType']);
	if (actionType != null) {
		followResponse.actionType = actionType;
	}
	final String? relationUserId = jsonConvert.convert<String>(json['relationUserId']);
	if (relationUserId != null) {
		followResponse.relationUserId = relationUserId;
	}
	final int? createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		followResponse.createTime = createTime;
	}
	return followResponse;
}

Map<String, dynamic> $FollowResponseToJson(FollowResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['actionType'] = entity.actionType;
	data['relationUserId'] = entity.relationUserId;
	data['createTime'] = entity.createTime;
	return data;
}