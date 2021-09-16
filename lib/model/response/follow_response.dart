import 'package:toktik/generated/json/base/json_convert_content.dart';

class FollowResponse with JsonConvert<FollowResponse> {
	String id;
	int actionType;
	String relationUserId;
	int createTime;
}
