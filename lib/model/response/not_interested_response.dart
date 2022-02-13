import 'dart:convert';
import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/not_interested_response.g.dart';

@JsonSerializable()
class NotInterestedResponse {
  
  NotInterestedResponse();

  factory NotInterestedResponse.fromJson(Map<String, dynamic> json) => $NotInterestedResponseFromJson(json);

  Map<String, dynamic> toJson() => $NotInterestedResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  String? id;
  String? notInterestedostId;
  String? notInteresteduserId;
  String? notInterestedtargetUserId;
  String? type;
  int? createdAt;
}