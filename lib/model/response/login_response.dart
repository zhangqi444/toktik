import 'package:toktik/generated/json/base/json_convert_content.dart';

class LoginResponse with JsonConvert<LoginResponse> {
	int uid;
	String token;
}
