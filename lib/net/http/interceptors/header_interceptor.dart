import 'package:dio/dio.dart';
import 'package:toktik/common/sp_keys.dart';
import 'package:toktik/util/sp_util.dart';

class HeaderInterceptor implements Interceptor{
  @override
  Future onError(DioError err, ErrorInterceptorHandler i)async {
    return err;
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler i) async{
    int userUid = -1;
    await SPUtil.getString(SPKeys.userId).then((uid){
      userUid = uid;
    });
    String token = '';
    await SPUtil.getString(SPKeys.token).then((text){
      token = text;
    });

    options.headers['x-bm-uid'] = userUid??'';
    if(null != token && token.length > 0)options.headers['Authorization'] = 'Bearer ' + token??'';
    return options;
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler i) async{
    return response;
  }

}