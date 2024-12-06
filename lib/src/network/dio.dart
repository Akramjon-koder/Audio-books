
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

import 'links.dart';

class DioClient {
  Function(DioExceptionType type)? _onExeption;
  Dio? _dio;
  Dio get dio {
    if (_dio == null) {
      _dio = Dio();
      _dio!
        ..interceptors.add(PrettyDioLogger(
          requestHeader: kDebugMode,
          requestBody: kDebugMode,
          responseBody: kDebugMode,
          responseHeader: false,
          error: kDebugMode,
          canShowLog: kDebugMode,
          showCUrl: kDebugMode,
        ))
        ..options.baseUrl = Links.baseUrl
        ..options.connectTimeout = const Duration(seconds: 30)
        ..options.receiveTimeout = const Duration(seconds: 30)
        ..httpClientAdapter
        ..options.headers = {
          'Content-Type': 'application/json; charset=UTF-8',
        };
    }
    return _dio!;
  }

  Future<Response> get(
      String uri, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        bool withoutHeader = false,
      }) async {
    try {
      final response = await dio.get(
        uri,
        data: FormData.fromMap(data ?? {}),
        queryParameters: queryParameters,
        options: Options(headers: withoutHeader ? {} : _header()),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      if (e is DioException) {
        _notifyExeption(e.type);
        return e.response ?? defaultResponce;
      }
      return defaultResponce;
    }
  }

  Future<Response> post(
      String uri, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await dio.post(
        uri,
        data: FormData.fromMap(data ?? {}),
        queryParameters: queryParameters,
        options: Options(headers: await _header()),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      debugPrint('dioError: $e');
      if (e is DioException) {
        _notifyExeption(e.type);
        return e.response ?? defaultResponce;
      }
      return defaultResponce;
    }
  }

  Map<String, String> _header()  {
    return {};
    // String token = pref.getString(PrefKeys.access) ?? "";
    // String lan = pref.getString(PrefKeys.language) ?? "en";
    // if (token == "") {
    //   return {
    //     "Accept-Language": lan,
    //   };
    // } else {
    //   return {
    //     "Authorization": "Bearer $token",
    //     "Accept-Language": lan,
    //   };
    // }
  }

  void _notifyExeption(DioExceptionType type){
    if(
    _onExeption != null &&
        type != DioExceptionType.badCertificate &&
        type != DioExceptionType.badResponse &&
        type != DioExceptionType.unknown
    ){
      _onExeption!(type);
    }
  }

  void setExeptionNotify(Function(DioExceptionType type) _) => _onExeption = _;
}

final defaultResponce = Response(
    requestOptions: RequestOptions(),
    statusCode: 403,
    statusMessage: 'Internet Error'
);