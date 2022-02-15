import 'dart:convert';
import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/get_current_user_response.g.dart';

@JsonSerializable()
class GetCurrentUserResponse {

	String? username;
  String? userId;
  String? status;
  
  GetCurrentUserResponse();

  factory GetCurrentUserResponse.fromJson(Map<String, dynamic> json) => $GetCurrentUserResponseFromJson(json);

  Map<String, dynamic> toJson() => $GetCurrentUserResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}