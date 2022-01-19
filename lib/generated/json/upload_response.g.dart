import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/upload_response.dart';

UploadResponse $UploadResponseFromJson(Map<String, dynamic> json) {
	final UploadResponse uploadResponse = UploadResponse();
	final String? effectUrl = jsonConvert.convert<String>(json['effectUrl']);
	if (effectUrl != null) {
		uploadResponse.effectUrl = effectUrl;
	}
	return uploadResponse;
}

Map<String, dynamic> $UploadResponseToJson(UploadResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['effectUrl'] = entity.effectUrl;
	return data;
}