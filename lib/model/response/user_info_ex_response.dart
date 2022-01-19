import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/generated/json/base/json_field.dart';

class UserInfoExResponse with JsonConvert<UserInfoExResponse> {
	UserInfoExUser? user;
	int? followerCount = 0;
	int? followingCount = 0;
	int? likeCount = 0;
	String? relation;
}

class UserInfoExUser with JsonConvert<UserInfoExUser> {
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
