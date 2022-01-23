import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/view_response.dart';

ViewResponse $ViewResponseFromJson(Map<String, dynamic> json) {
	final ViewResponse viewResponse = ViewResponse();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		viewResponse.id = id;
	}
	final String? postId = jsonConvert.convert<String>(json['postId']);
	if (postId != null) {
		viewResponse.postId = postId;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		viewResponse.userId = userId;
	}
	final int? createdAt = jsonConvert.convert<int>(json['createdAt']);
	if (createdAt != null) {
		viewResponse.createdAt = createdAt;
	}
	return viewResponse;
}

Map<String, dynamic> $ViewResponseToJson(ViewResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['postId'] = entity.postId;
	data['userId'] = entity.userId;
	data['createdAt'] = entity.createdAt;
	return data;
}