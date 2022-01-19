import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/publish_feed_response.dart';

PublishFeedResponse $PublishFeedResponseFromJson(Map<String, dynamic> json) {
	final PublishFeedResponse publishFeedResponse = PublishFeedResponse();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		publishFeedResponse.id = id;
	}
	return publishFeedResponse;
}

Map<String, dynamic> $PublishFeedResponseToJson(PublishFeedResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	return data;
}