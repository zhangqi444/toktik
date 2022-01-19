import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/follow_request.g.dart';


@JsonSerializable()
class FollowRequest {

	FollowRequest();

	factory FollowRequest.fromJson(Map<String, dynamic> json) => $FollowRequestFromJson(json);

	Map<String, dynamic> toJson() => $FollowRequestToJson(this);

	int? actionType;
	String? relationUserId;
}
