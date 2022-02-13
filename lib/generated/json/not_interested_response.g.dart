import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/not_interested_response.dart';

NotInterestedResponse $NotInterestedResponseFromJson(Map<String, dynamic> json) {
	final NotInterestedResponse notInterestedResponse = NotInterestedResponse();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		notInterestedResponse.id = id;
	}
	final String? postId = jsonConvert.convert<String>(json['postId']);
	if (postId != null) {
		notInterestedResponse.postId = postId;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		notInterestedResponse.userId = userId;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		notInterestedResponse.type = type;
	}
	final bool? value = jsonConvert.convert<bool>(json['value']);
	if (value != null) {
		notInterestedResponse.value = value;
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
	data['postId'] = entity.postId;
	data['userId'] = entity.userId;
	data['type'] = entity.type;
	data['value'] = entity.value;
	data['createdAt'] = entity.createdAt;
	return data;
}