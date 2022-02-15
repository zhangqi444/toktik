import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/not_interested_response.dart';

NotInterestedResponse $NotInterestedResponseFromJson(Map<String, dynamic> json) {
	final NotInterestedResponse notInterestedResponse = NotInterestedResponse();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		notInterestedResponse.id = id;
	}
	final String? notInterestedostId = jsonConvert.convert<String>(json['notInterestedostId']);
	if (notInterestedostId != null) {
		notInterestedResponse.notInterestedostId = notInterestedostId;
	}
	final String? notInteresteduserId = jsonConvert.convert<String>(json['notInteresteduserId']);
	if (notInteresteduserId != null) {
		notInterestedResponse.notInteresteduserId = notInteresteduserId;
	}
	final String? notInterestedtargetUserId = jsonConvert.convert<String>(json['notInterestedtargetUserId']);
	if (notInterestedtargetUserId != null) {
		notInterestedResponse.notInterestedtargetUserId = notInterestedtargetUserId;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		notInterestedResponse.type = type;
	}
	final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
	if (createdAt != null) {
		notInterestedResponse.createdAt = createdAt;
	}
	return notInterestedResponse;
}

Map<String, dynamic> $NotInterestedResponseToJson(NotInterestedResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['notInterestedostId'] = entity.notInterestedostId;
	data['notInteresteduserId'] = entity.notInteresteduserId;
	data['notInterestedtargetUserId'] = entity.notInterestedtargetUserId;
	data['type'] = entity.type;
	data['createdAt'] = entity.createdAt;
	return data;
}