import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/like_response.g.dart';


@JsonSerializable()
class LikeResponse {

	LikeResponse();

	factory LikeResponse.fromJson(Map<String, dynamic> json) => $LikeResponseFromJson(json);

	Map<String, dynamic> toJson() => $LikeResponseToJson(this);

	String? id;
	String? postId;
	String? userId;
	bool? value;
	int? createdAt;
}
