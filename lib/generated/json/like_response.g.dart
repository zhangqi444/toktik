import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/like_response.dart';

LikeResponse $LikeResponseFromJson(Map<String, dynamic> json) {
	final LikeResponse likeResponse = LikeResponse();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		likeResponse.id = id;
	}
	final String? postId = jsonConvert.convert<String>(json['postId']);
	if (postId != null) {
		likeResponse.postId = postId;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		likeResponse.userId = userId;
	}
	final bool? value = jsonConvert.convert<bool>(json['value']);
	if (value != null) {
		likeResponse.value = value;
	}
	final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
	if (createdAt != null) {
		likeResponse.createdAt = createdAt;
	}
	return likeResponse;
}

Map<String, dynamic> $LikeResponseToJson(LikeResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['postId'] = entity.postId;
	data['userId'] = entity.userId;
	data['value'] = entity.value;
	data['createdAt'] = entity.createdAt;
	return data;
}