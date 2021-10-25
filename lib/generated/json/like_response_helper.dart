import 'package:toktik/model/response/like_response.dart';

likeResponseFromJson(LikeResponse data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['postId'] != null) {
		data.postId = json['postId'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'].toString();
	}
	if (json['value'] != null) {
		data.value = json['value'];
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt'] is String
				? int.tryParse(json['createdAt'])
				: json['createdAt'].toInt();
	}
	return data;
}

Map<String, dynamic> likeResponseToJson(LikeResponse entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['postId'] = entity.postId;
	data['userId'] = entity.userId;
	data['value'] = entity.value;
	data['createdAt'] = entity.createdAt;
	return data;
}