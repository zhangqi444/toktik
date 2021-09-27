import 'package:toktik/model/response/view_response.dart';

viewResponseFromJson(ViewResponse data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	if (json['postId'] != null) {
		data.postId = json['postId'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'].toString();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt'] is String
				? int.tryParse(json['createdAt'])
				: json['createdAt'].toInt();
	}
	return data;
}

Map<String, dynamic> viewResponseToJson(ViewResponse entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['postId'] = entity.postId;
	data['userId'] = entity.userId;
	data['createdAt'] = entity.createdAt;
	return data;
}