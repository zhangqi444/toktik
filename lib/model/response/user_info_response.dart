import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/generated/json/base/json_field.dart';

class UserInfoResponse with JsonConvert<UserInfoResponse> {
	int uid;
	String id;
	String nickname;
	String portrait;
	String bio;
	String birth;
	int gender;
	String city;
	String profession;
	@JSONField(name: "create_time")
	int createTime;
}
