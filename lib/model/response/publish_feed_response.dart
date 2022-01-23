import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/publish_feed_response.g.dart';


@JsonSerializable()
class PublishFeedResponse {

	PublishFeedResponse();

	factory PublishFeedResponse.fromJson(Map<String, dynamic> json) => $PublishFeedResponseFromJson(json);

	Map<String, dynamic> toJson() => $PublishFeedResponseToJson(this);

	String? id;
}
