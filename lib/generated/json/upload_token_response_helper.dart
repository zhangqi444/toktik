import 'package:toktik/model/response/upload_token_response.dart';

uploadTokenResponseFromJson(UploadTokenResponse data, Map<String, dynamic> json) {
	if (json['tokens'] != null) {
		data.tokens = (json['tokens'] as List).map((v) => UploadTokenToken().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> uploadTokenResponseToJson(UploadTokenResponse entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['tokens'] =  entity.tokens?.map((v) => v!.toJson())?.toList();
	return data;
}

uploadTokenTokenFromJson(UploadTokenToken data, Map<String, dynamic> json) {
	if (json['method'] != null) {
		data.method = json['method'].toString();
	}
	if (json['uploadUrl'] != null) {
		data.uploadUrl = json['uploadUrl'].toString();
	}
	if (json['effectUrl'] != null) {
		data.effectUrl = json['effectUrl'].toString();
	}
	if (json['headers'] != null) {
		data.headers = UploadTokenTokensHeaders().fromJson(json['headers']);
	}
	return data;
}

Map<String, dynamic> uploadTokenTokenToJson(UploadTokenToken entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['method'] = entity.method;
	data['uploadUrl'] = entity.uploadUrl;
	data['effectUrl'] = entity.effectUrl;
	data['headers'] = entity.headers?.toJson();
	return data;
}

uploadTokenTokensHeadersFromJson(UploadTokenTokensHeaders data, Map<String, dynamic> json) {
	if (json['Authorization'] != null) {
		data.authorization = json['Authorization'].toString();
	}
	if (json['Content-Type'] != null) {
		data.contentType = json['Content-Type'].toString();
	}
	if (json['Date'] != null) {
		data.date = json['Date'].toString();
	}
	if (json['Content-Length'] != null) {
		data.contentLength = json['Content-Length'].toString();
	}
	if (json['Content-MD5'] != null) {
		data.contentMd5 = json['Content-MD5'].toString();
	}
	return data;
}

Map<String, dynamic> uploadTokenTokensHeadersToJson(UploadTokenTokensHeaders entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['Authorization'] = entity.authorization;
	data['Content-Type'] = entity.contentType;
	data['Date'] = entity.date;
	data['Content-Length'] = entity.contentLength;
	data['Content-MD5'] = entity.contentMd5;
	return data;
}