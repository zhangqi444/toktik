import 'package:toktik/generated/json/feed_list_response.g.dart';

import 'package:toktik/generated/json/base/json_field.dart';

@JsonSerializable()
class FeedListResponse {

	FeedListResponse();

	factory FeedListResponse.fromJson(Map<String, dynamic> json) => $FeedListResponseFromJson(json);

	Map<String, dynamic> toJson() => $FeedListResponseToJson(this);

	@JSONField(name: "list")
	List<FeedListList?>? xList;
	String? nextToken;
	int? count;
	bool? hasMore;
}

@JsonSerializable()
class FeedListList {

	FeedListList();

	factory FeedListList.fromJson(Map<String, dynamic> json) => $FeedListListFromJson(json);

	Map<String, dynamic> toJson() => $FeedListListToJson(this);

	String? id;
	int? type;
	FeedListListContent? content;
	FeedListListLocation? location;
	String? device;
	int? aclType;
	int? commentType;
	int? createTime;
	FeedListListUser? user;
	int? likeCount;
	int? commentCount;
	int? shareCount;
	int? viewCount;
	bool? isFollow;
	bool? isLiked;
}

@JsonSerializable()
class FeedListListContent {

	FeedListListContent();

	factory FeedListListContent.fromJson(Map<String, dynamic> json) => $FeedListListContentFromJson(json);

	Map<String, dynamic> toJson() => $FeedListListContentToJson(this);

	String? text;
	List<FeedListListContentTag?>? tag;
	List<FeedListListContentAt?>? at;
	List<FeedListListContentAttachmants?>? attachments;
	FeedListListContentMusic? music;
}

@JsonSerializable()
class FeedListListContentTag {

	FeedListListContentTag();

	factory FeedListListContentTag.fromJson(Map<String, dynamic> json) => $FeedListListContentTagFromJson(json);

	Map<String, dynamic> toJson() => $FeedListListContentTagToJson(this);

	String? id;
	String? name;
	int? start;
	int? end;
}

@JsonSerializable()
class FeedListListContentAt {

	FeedListListContentAt();

	factory FeedListListContentAt.fromJson(Map<String, dynamic> json) => $FeedListListContentAtFromJson(json);

	Map<String, dynamic> toJson() => $FeedListListContentAtToJson(this);

	String? id;
	String? name;
	int? start;
	int? end;
}

@JsonSerializable()
class FeedListListContentAttachmants {

	FeedListListContentAttachmants();

	factory FeedListListContentAttachmants.fromJson(Map<String, dynamic> json) => $FeedListListContentAttachmantsFromJson(json);

	Map<String, dynamic> toJson() => $FeedListListContentAttachmantsToJson(this);

	int? type;
	String? url;
	String? cover;
	String? gifCover;
	int? duration;
	int? width;
	int? height;
}

@JsonSerializable()
class FeedListListContentMusic {

	FeedListListContentMusic();

	factory FeedListListContentMusic.fromJson(Map<String, dynamic> json) => $FeedListListContentMusicFromJson(json);

	Map<String, dynamic> toJson() => $FeedListListContentMusicToJson(this);

	String? id;
	String? name;
	String? url;
	String? img;
}

@JsonSerializable()
class FeedListListLocation {

	FeedListListLocation();

	factory FeedListListLocation.fromJson(Map<String, dynamic> json) => $FeedListListLocationFromJson(json);

	Map<String, dynamic> toJson() => $FeedListListLocationToJson(this);

	String? latitude;
	String? longitude;
	String? cityCode;
	String? adCode;
	String? address;
	String? name;
}

@JsonSerializable()
class FeedListListUser {

	FeedListListUser();

	factory FeedListListUser.fromJson(Map<String, dynamic> json) => $FeedListListUserFromJson(json);

	Map<String, dynamic> toJson() => $FeedListListUserToJson(this);

	String? id;
	String? username;
	String? portrait;
	String? bio;
	String? birth;
	int? gender;
	String? city;
	String? profession;
	@JSONField(name: "create_time")
	int? createTime;
}
