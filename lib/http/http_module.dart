import 'package:dio/dio.dart';
import 'package:dwarf_doc/util/logger.dart';
import 'package:meta/meta.dart';

class HttpModule {
  static String TAG = 'HttpModule';
  Dio _dio;

  HttpModule(Dio dio) {
    _dio = dio;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        Logger.d(HttpModule.TAG, 'request:\t${options.path}\nmethod:\t${options.method}\nqueryParams:\t${options.queryParameters.toString()}\ndata:\t${options.data.toString()}');
        return options;
      },
      onResponse: (Response response) {
        Logger.d(HttpModule.TAG, 'response:\t${response.request.path}\nmethod:\t${response.request.method}\ndata:\t${response.data.toString()}');
        return response;
      },
    ));
  }

  Future get(String path, {Map<String, dynamic> params}) async {
    var response = await _dio.get(path, queryParameters: params);
    return response.data;
  }

  Future post(String path, {Map<String, dynamic> params}) async {
    var response = await _dio.post(path, data: params);
    return response.data;
  }
}
