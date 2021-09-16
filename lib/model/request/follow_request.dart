import 'package:toktik/generated/json/base/json_convert_content.dart';

class FollowRequest with JsonConvert<FollowRequest> {
	int actionType;
	String relationUserId;
}
