import 'package:toktik/model/response/publish_feed_response.dart';

publishFeedResponseFromJson(PublishFeedResponse data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'].toString();
	}
	return data;
}

Map<String, dynamic> publishFeedResponseToJson(PublishFeedResponse entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	return data;
}