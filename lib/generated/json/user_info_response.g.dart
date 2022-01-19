import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/user_info_response.dart';

UserInfoResponse $UserInfoResponseFromJson(Map<String, dynamic> json) {
	final UserInfoResponse userInfoResponse = UserInfoResponse();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userInfoResponse.id = id;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userInfoResponse.username = username;
	}
	final String? portrait = jsonConvert.convert<String>(json['portrait']);
	if (portrait != null) {
		userInfoResponse.portrait = portrait;
	}
	final String? bio = jsonConvert.convert<String>(json['bio']);
	if (bio != null) {
		userInfoResponse.bio = bio;
	}
	final String? birth = jsonConvert.convert<String>(json['birth']);
	if (birth != null) {
		userInfoResponse.birth = birth;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		userInfoResponse.gender = gender;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		userInfoResponse.city = city;
	}
	final String? profession = jsonConvert.convert<String>(json['profession']);
	if (profession != null) {
		userInfoResponse.profession = profession;
	}
	final int? createTime = jsonConvert.convert<int>(json['create_time']);
	if (createTime != null) {
		userInfoResponse.createTime = createTime;
	}
	return userInfoResponse;
}

Map<String, dynamic> $UserInfoResponseToJson(UserInfoResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['username'] = entity.username;
	data['portrait'] = entity.portrait;
	data['bio'] = entity.bio;
	data['birth'] = entity.birth;
	data['gender'] = entity.gender;
	data['city'] = entity.city;
	data['profession'] = entity.profession;
	data['create_time'] = entity.createTime;
	return data;
}