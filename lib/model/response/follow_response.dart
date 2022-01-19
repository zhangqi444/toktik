import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/follow_response.g.dart';


@JsonSerializable()
class FollowResponse {

	FollowResponse();

	factory FollowResponse.fromJson(Map<String, dynamic> json) => $FollowResponseFromJson(json);

	Map<String, dynamic> toJson() => $FollowResponseToJson(this);

	String? id;
	int? actionType;
	String? relationUserId;
	int? createTime;
}
