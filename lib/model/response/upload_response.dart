import 'package:toktik/generated/json/base/json_field.dart';
import 'package:toktik/generated/json/upload_response.g.dart';

@deprecated
@JsonSerializable()
class UploadResponse {

	UploadResponse();

	factory UploadResponse.fromJson(Map<String, dynamic> json) => $UploadResponseFromJson(json);

	Map<String, dynamic> toJson() => $UploadResponseToJson(this);

	String? effectUrl;
}
