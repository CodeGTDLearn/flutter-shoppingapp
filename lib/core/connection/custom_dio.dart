import 'package:dio/dio.dart';

import '../configurable/app_properties.dart';
import 'custom_dio_interceptors.dart';

class CustomDio{

  Dio _dio;

  CustomDio() {
    _dio = Dio();
    _dio.interceptors.add(CustomDioInterceptors());
    _dio.options.connectTimeout = TIME_OUT;
  }

  Dio get connect => _dio;
}