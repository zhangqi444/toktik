import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/publish_feed_request.g.dart';


@JsonSerializable()
class PublishFeedRequest {

	PublishFeedRequest();

	factory PublishFeedRequest.fromJson(Map<String, dynamic> json) => $PublishFeedRequestFromJson(json);

	Map<String, dynamic> toJson() => $PublishFeedRequestToJson(this);

	int? type;
	PublishFeedContent? content;
	PublishFeedLocation? location;
	String? device;
	int? aclType;
	int? commentType;
}

@JsonSerializable()
class PublishFeedContent {

	PublishFeedContent();

	factory PublishFeedContent.fromJson(Map<String, dynamic> json) => $PublishFeedContentFromJson(json);

	Map<String, dynamic> toJson() => $PublishFeedContentToJson(this);

	String? text;
	List<PublishFeedContentTag?>? tag;
	List<PublishFeedContentAt?>? at;
	List<PublishFeedContentAttachmants?>? attachments;
	PublishFeedContentMusic? music;
}

@JsonSerializable()
class PublishFeedContentTag {

	PublishFeedContentTag();

	factory PublishFeedContentTag.fromJson(Map<String, dynamic> json) => $PublishFeedContentTagFromJson(json);

	Map<String, dynamic> toJson() => $PublishFeedContentTagToJson(this);

	String? id;
	String? name;
	int? start;
	int? end;
}

@JsonSerializable()
class PublishFeedContentAt {

	PublishFeedContentAt();

	factory PublishFeedContentAt.fromJson(Map<String, dynamic> json) => $PublishFeedContentAtFromJson(json);

	Map<String, dynamic> toJson() => $PublishFeedContentAtToJson(this);

	String? id;
	String? name;
	int? start;
	int? end;
}

@JsonSerializable()
class PublishFeedContentAttachmants {

	PublishFeedContentAttachmants();

	factory PublishFeedContentAttachmants.fromJson(Map<String, dynamic> json) => $PublishFeedContentAttachmantsFromJson(json);

	Map<String, dynamic> toJson() => $PublishFeedContentAttachmantsToJson(this);

	int? type;
	String? url;
	String? cover;
	String? gifCover;
	int? duration;
	int? width;
	int? height;
}

@JsonSerializable()
class PublishFeedContentMusic {

	PublishFeedContentMusic();

	factory PublishFeedContentMusic.fromJson(Map<String, dynamic> json) => $PublishFeedContentMusicFromJson(json);

	Map<String, dynamic> toJson() => $PublishFeedContentMusicToJson(this);

	String? id;
	String? name;
	String? url;
	String? img;
}

@JsonSerializable()
class PublishFeedLocation {

	PublishFeedLocation();

	factory PublishFeedLocation.fromJson(Map<String, dynamic> json) => $PublishFeedLocationFromJson(json);

	Map<String, dynamic> toJson() => $PublishFeedLocationToJson(this);

	String? latitude;
	String? longitude;
	String? cityCode;
	String? adCode;
	String? address;
	String? name;
}
