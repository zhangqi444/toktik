import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/upload_token_response.dart';

UploadTokenResponse $UploadTokenResponseFromJson(Map<String, dynamic> json) {
	final UploadTokenResponse uploadTokenResponse = UploadTokenResponse();
	final List<UploadTokenToken?>? tokens = jsonConvert.convertList<UploadTokenToken>(json['tokens']);
	if (tokens != null) {
		uploadTokenResponse.tokens = tokens;
	}
	return uploadTokenResponse;
}

Map<String, dynamic> $UploadTokenResponseToJson(UploadTokenResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['tokens'] =  entity.tokens?.map((v) => v?.toJson()).toList();
	return data;
}

UploadTokenToken $UploadTokenTokenFromJson(Map<String, dynamic> json) {
	final UploadTokenToken uploadTokenToken = UploadTokenToken();
	final String? method = jsonConvert.convert<String>(json['method']);
	if (method != null) {
		uploadTokenToken.method = method;
	}
	final String? uploadUrl = jsonConvert.convert<String>(json['uploadUrl']);
	if (uploadUrl != null) {
		uploadTokenToken.uploadUrl = uploadUrl;
	}
	final String? effectUrl = jsonConvert.convert<String>(json['effectUrl']);
	if (effectUrl != null) {
		uploadTokenToken.effectUrl = effectUrl;
	}
	final UploadTokenTokensHeaders? headers = jsonConvert.convert<UploadTokenTokensHeaders>(json['headers']);
	if (headers != null) {
		uploadTokenToken.headers = headers;
	}
	return uploadTokenToken;
}

Map<String, dynamic> $UploadTokenTokenToJson(UploadTokenToken entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['method'] = entity.method;
	data['uploadUrl'] = entity.uploadUrl;
	data['effectUrl'] = entity.effectUrl;
	data['headers'] = entity.headers?.toJson();
	return data;
}

UploadTokenTokensHeaders $UploadTokenTokensHeadersFromJson(Map<String, dynamic> json) {
	final UploadTokenTokensHeaders uploadTokenTokensHeaders = UploadTokenTokensHeaders();
	final String? authorization = jsonConvert.convert<String>(json['Authorization']);
	if (authorization != null) {
		uploadTokenTokensHeaders.authorization = authorization;
	}
	final String? contentType = jsonConvert.convert<String>(json['Content-Type']);
	if (contentType != null) {
		uploadTokenTokensHeaders.contentType = contentType;
	}
	final String? date = jsonConvert.convert<String>(json['Date']);
	if (date != null) {
		uploadTokenTokensHeaders.date = date;
	}
	final String? contentLength = jsonConvert.convert<String>(json['Content-Length']);
	if (contentLength != null) {
		uploadTokenTokensHeaders.contentLength = contentLength;
	}
	final String? contentMd5 = jsonConvert.convert<String>(json['Content-MD5']);
	if (contentMd5 != null) {
		uploadTokenTokensHeaders.contentMd5 = contentMd5;
	}
	return uploadTokenTokensHeaders;
}

Map<String, dynamic> $UploadTokenTokensHeadersToJson(UploadTokenTokensHeaders entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['Authorization'] = entity.authorization;
	data['Content-Type'] = entity.contentType;
	data['Date'] = entity.date;
	data['Content-Length'] = entity.contentLength;
	data['Content-MD5'] = entity.contentMd5;
	return data;
}