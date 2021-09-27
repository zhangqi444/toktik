import 'package:toktik/generated/json/base/json_convert_content.dart';

class ViewResponse with JsonConvert<ViewResponse> {
	String id;
	String postId;
	String userId;
	int createdAt;
}
