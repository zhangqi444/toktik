import 'package:toktik/generated/json/base/json_convert_content.dart';

class RegisterResponse with JsonConvert<RegisterResponse> {
	bool isSignUpComplete;
	String username;
	String status;
}
