import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/view_response.g.dart';


@JsonSerializable()
class ViewResponse {

	ViewResponse();

	factory ViewResponse.fromJson(Map<String, dynamic> json) => $ViewResponseFromJson(json);

	Map<String, dynamic> toJson() => $ViewResponseToJson(this);

	String? id;
	String? postId;
	String? userId;
	int? createdAt;
}
