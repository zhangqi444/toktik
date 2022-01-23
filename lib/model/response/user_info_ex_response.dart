import 'package:toktik/generated/json/user_info_ex_response.g.dart';

import 'package:toktik/generated/json/base/json_field.dart';

@JsonSerializable()
class UserInfoExResponse {

	UserInfoExResponse();

	factory UserInfoExResponse.fromJson(Map<String, dynamic> json) => $UserInfoExResponseFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoExResponseToJson(this);

	UserInfoExUser? user;
	int? followerCount = 0;
	int? followingCount = 0;
	int? likeCount = 0;
	String? relation;
}

@JsonSerializable()
class UserInfoExUser {

	UserInfoExUser();

	factory UserInfoExUser.fromJson(Map<String, dynamic> json) => $UserInfoExUserFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoExUserToJson(this);

	String? id;
	String? username;
	String portrait = "";
	String bio = "";
	String? birth = null;
	int? gender = 2;
	String city = "";
	String profession = "";
	String email = "";
	String phoneNumber = "";
	@JSONField(name: "create_time")
	int? createTime;
}
