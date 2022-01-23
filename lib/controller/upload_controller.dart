import 'dart:async';
import 'dart:io';

import 'package:toktik/model/response/upload_token_response.dart';
import 'package:toktik/net/api.dart';
import 'package:get/get.dart';

class UploadController extends GetxController{

  late UploadTokenResponse uploadResponse;

  Future<bool?> uploadSingleFile(String fileSuffix,File file) async{

    var uploadTokenResponse = await (Api.getSingleUploadToken([fileSuffix]) as FutureOr<UploadTokenResponse>);

    uploadResponse = uploadTokenResponse;

    var success = await Api.uploadSingleFile(file, uploadTokenResponse,fileSuffix);
    return success;
  }

}