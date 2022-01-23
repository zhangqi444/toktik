import 'package:toktik/generated/json/user_info_response.g.dart';

import 'package:toktik/generated/json/base/json_field.dart';

@JsonSerializable()
class UserInfoResponse {

	UserInfoResponse();

	factory UserInfoResponse.fromJson(Map<String, dynamic> json) => $UserInfoResponseFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoResponseToJson(this);

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
