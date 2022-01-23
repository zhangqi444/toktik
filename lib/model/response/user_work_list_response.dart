import 'package:toktik/generated/json/user_work_list_response.g.dart';

import 'package:toktik/generated/json/base/json_field.dart';

@JsonSerializable()
class UserWorkListResponse {

	UserWorkListResponse();

	factory UserWorkListResponse.fromJson(Map<String, dynamic> json) => $UserWorkListResponseFromJson(json);

	Map<String, dynamic> toJson() => $UserWorkListResponseToJson(this);

	@JSONField(name: "list")
	List<UserWorkListList?>? xList;
	int? cursor;
	int? count;
	bool? hasMore;
}

@JsonSerializable()
class UserWorkListList {

	UserWorkListList();

	factory UserWorkListList.fromJson(Map<String, dynamic> json) => $UserWorkListListFromJson(json);

	Map<String, dynamic> toJson() => $UserWorkListListToJson(this);

	String? id;
	int? type;
	UserWorkListListContent? content;
	UserWorkListListLocation? location;
	String? device;
	int? aclType;
	int? commentType;
	int? createTime;
	UserWorkListListUser? user;
	int? likeCount;
	int? commentCount;
	int? shareCount;
	int? viewCount;
	bool? isFollow;
	bool? isLiked;
}

@JsonSerializable()
class UserWorkListListContent {

	UserWorkListListContent();

	factory UserWorkListListContent.fromJson(Map<String, dynamic> json) => $UserWorkListListContentFromJson(json);

	Map<String, dynamic> toJson() => $UserWorkListListContentToJson(this);

	String? text;
	List<UserWorkListListContentTag?>? tag;
	List<UserWorkListListContentAt?>? at;
	List<UserWorkListListContentAttachmants?>? attachments;
	UserWorkListListContentMusic? music;
}

@JsonSerializable()
class UserWorkListListContentTag {

	UserWorkListListContentTag();

	factory UserWorkListListContentTag.fromJson(Map<String, dynamic> json) => $UserWorkListListContentTagFromJson(json);

	Map<String, dynamic> toJson() => $UserWorkListListContentTagToJson(this);

	String? id;
	String? name;
	int? start;
	int? end;
}

@JsonSerializable()
class UserWorkListListContentAt {

	UserWorkListListContentAt();

	factory UserWorkListListContentAt.fromJson(Map<String, dynamic> json) => $UserWorkListListContentAtFromJson(json);

	Map<String, dynamic> toJson() => $UserWorkListListContentAtToJson(this);

	String? id;
	String? name;
	int? start;
	int? end;
}

@JsonSerializable()
class UserWorkListListContentAttachmants {

	UserWorkListListContentAttachmants();

	factory UserWorkListListContentAttachmants.fromJson(Map<String, dynamic> json) => $UserWorkListListContentAttachmantsFromJson(json);

	Map<String, dynamic> toJson() => $UserWorkListListContentAttachmantsToJson(this);

	int? type;
	String? url;
	String? cover;
	String? gifCover;
	int? duration;
	int? width;
	int? height;
}

@JsonSerializable()
class UserWorkListListContentMusic {

	UserWorkListListContentMusic();

	factory UserWorkListListContentMusic.fromJson(Map<String, dynamic> json) => $UserWorkListListContentMusicFromJson(json);

	Map<String, dynamic> toJson() => $UserWorkListListContentMusicToJson(this);

	String? id;
	String? name;
	String? url;
	String? img;
}

@JsonSerializable()
class UserWorkListListLocation {

	UserWorkListListLocation();

	factory UserWorkListListLocation.fromJson(Map<String, dynamic> json) => $UserWorkListListLocationFromJson(json);

	Map<String, dynamic> toJson() => $UserWorkListListLocationToJson(this);

	String? latitude;
	String? longitude;
	String? cityCode;
	String? adCode;
	String? address;
	String? name;
}

@JsonSerializable()
class UserWorkListListUser {

	UserWorkListListUser();

	factory UserWorkListListUser.fromJson(Map<String, dynamic> json) => $UserWorkListListUserFromJson(json);

	Map<String, dynamic> toJson() => $UserWorkListListUserToJson(this);

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
