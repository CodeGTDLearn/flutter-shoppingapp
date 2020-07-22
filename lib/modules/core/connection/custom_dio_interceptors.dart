import 'package:dio/dio.dart';

class CustomDioInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print("REQ-INTERCEPT ->"
        " ${options.method} -> ${options.path}");
    return super.onRequest(options);
  }

  // intercept only the CODES: 200 / 201
  @override
  Future onResponse(Response response) {
    //cachear DADOS com o SHARED_PREFERENCES qdo vier 200
    print("RESP-INTERCEPT ->"
        " ${response.statusCode} -> ${response.request.path}");
    return super.onResponse(response);
  }

  // intercept ALL-OTHERS CODES
  @override
  Future onError(DioError error) {
    print("EXCEPTION-INTERCEPT ->"
        " ${error.response.statusCode} -> ${error.request.path}");
    return super.onError(error);
  }
}
