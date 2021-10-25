import 'package:toktik/generated/json/base/json_convert_content.dart';

class LikeResponse with JsonConvert<LikeResponse> {
	String id;
	String postId;
	String userId;
	bool value;
	int createdAt;
}
