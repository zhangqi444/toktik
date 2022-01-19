import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/user_info_ex_response.dart';

UserInfoExResponse $UserInfoExResponseFromJson(Map<String, dynamic> json) {
	final UserInfoExResponse userInfoExResponse = UserInfoExResponse();
	final UserInfoExUser? user = jsonConvert.convert<UserInfoExUser>(json['user']);
	if (user != null) {
		userInfoExResponse.user = user;
	}
	final int? followerCount = jsonConvert.convert<int>(json['followerCount']);
	if (followerCount != null) {
		userInfoExResponse.followerCount = followerCount;
	}
	final int? followingCount = jsonConvert.convert<int>(json['followingCount']);
	if (followingCount != null) {
		userInfoExResponse.followingCount = followingCount;
	}
	final int? likeCount = jsonConvert.convert<int>(json['likeCount']);
	if (likeCount != null) {
		userInfoExResponse.likeCount = likeCount;
	}
	final String? relation = jsonConvert.convert<String>(json['relation']);
	if (relation != null) {
		userInfoExResponse.relation = relation;
	}
	return userInfoExResponse;
}

Map<String, dynamic> $UserInfoExResponseToJson(UserInfoExResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['user'] = entity.user?.toJson();
	data['followerCount'] = entity.followerCount;
	data['followingCount'] = entity.followingCount;
	data['likeCount'] = entity.likeCount;
	data['relation'] = entity.relation;
	return data;
}

UserInfoExUser $UserInfoExUserFromJson(Map<String, dynamic> json) {
	final UserInfoExUser userInfoExUser = UserInfoExUser();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userInfoExUser.id = id;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userInfoExUser.username = username;
	}
	final String? portrait = jsonConvert.convert<String>(json['portrait']);
	if (portrait != null) {
		userInfoExUser.portrait = portrait;
	}
	final String? bio = jsonConvert.convert<String>(json['bio']);
	if (bio != null) {
		userInfoExUser.bio = bio;
	}
	final String? birth = jsonConvert.convert<String>(json['birth']);
	if (birth != null) {
		userInfoExUser.birth = birth;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		userInfoExUser.gender = gender;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		userInfoExUser.city = city;
	}
	final String? profession = jsonConvert.convert<String>(json['profession']);
	if (profession != null) {
		userInfoExUser.profession = profession;
	}
	final String? email = jsonConvert.convert<String>(json['email']);
	if (email != null) {
		userInfoExUser.email = email;
	}
	final String? phoneNumber = jsonConvert.convert<String>(json['phoneNumber']);
	if (phoneNumber != null) {
		userInfoExUser.phoneNumber = phoneNumber;
	}
	final int? createTime = jsonConvert.convert<int>(json['create_time']);
	if (createTime != null) {
		userInfoExUser.createTime = createTime;
	}
	return userInfoExUser;
}

Map<String, dynamic> $UserInfoExUserToJson(UserInfoExUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['username'] = entity.username;
	data['portrait'] = entity.portrait;
	data['bio'] = entity.bio;
	data['birth'] = entity.birth;
	data['gender'] = entity.gender;
	data['city'] = entity.city;
	data['profession'] = entity.profession;
	data['email'] = entity.email;
	data['phoneNumber'] = entity.phoneNumber;
	data['create_time'] = entity.createTime;
	return data;
}