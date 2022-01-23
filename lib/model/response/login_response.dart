import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/login_response.g.dart';


@JsonSerializable()
class LoginResponse {

	LoginResponse();

	factory LoginResponse.fromJson(Map<String, dynamic> json) => $LoginResponseFromJson(json);

	Map<String, dynamic> toJson() => $LoginResponseToJson(this);

	String? username;
	String? token;
	String? status;
	bool? isSignedIn;

}
