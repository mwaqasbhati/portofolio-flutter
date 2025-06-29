import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import '../core/logging_interceptor.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio();
    dio.interceptors.add(LoggingInterceptor());
    return dio;
  }
}

