import 'package:toktik/generated/json/upload_token_response.g.dart';

import 'package:toktik/generated/json/base/json_field.dart';

@JsonSerializable()
class UploadTokenResponse {

	UploadTokenResponse();

	factory UploadTokenResponse.fromJson(Map<String, dynamic> json) => $UploadTokenResponseFromJson(json);

	Map<String, dynamic> toJson() => $UploadTokenResponseToJson(this);

	List<UploadTokenToken?>? tokens;
}

@JsonSerializable()
class UploadTokenToken {

	UploadTokenToken();

	factory UploadTokenToken.fromJson(Map<String, dynamic> json) => $UploadTokenTokenFromJson(json);

	Map<String, dynamic> toJson() => $UploadTokenTokenToJson(this);

	String? method;
	String? uploadUrl;
	String? effectUrl;
	UploadTokenTokensHeaders? headers;
}

@JsonSerializable()
class UploadTokenTokensHeaders {

	UploadTokenTokensHeaders();

	factory UploadTokenTokensHeaders.fromJson(Map<String, dynamic> json) => $UploadTokenTokensHeadersFromJson(json);

	Map<String, dynamic> toJson() => $UploadTokenTokensHeadersToJson(this);

	@JSONField(name: "Authorization")
	String? authorization;
	@JSONField(name: "Content-Type")
	String? contentType;
	@JSONField(name: "Date")
	String? date;
	@JSONField(name: "Content-Length")
	String? contentLength;
	@JSONField(name: "Content-MD5")
	String? contentMd5;
}
