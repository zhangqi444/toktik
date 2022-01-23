import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/register_response.g.dart';


@JsonSerializable()
class RegisterResponse {

	RegisterResponse();

	factory RegisterResponse.fromJson(Map<String, dynamic> json) => $RegisterResponseFromJson(json);

	Map<String, dynamic> toJson() => $RegisterResponseToJson(this);

	bool? isSignUpComplete;
	String? username;
	String? status;
}
