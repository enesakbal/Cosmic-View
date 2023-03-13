// ignore_for_file: inference_failure_on_function_invocation, inference_failure_on_untyped_parameter

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/app_constants.dart';

class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio) {
    _dio
      ..options.baseUrl = ApplicationConstants.baseURL
      ..options.connectTimeout = connectionTimeout
      ..options.receiveTimeout = receiveTimeout
      ..options.responseType = ResponseType.json
      ..options.headers = {'x-api-key': ApplicationConstants.apiKEY}
      ..interceptors.add(LoggyDioInterceptor())
      ..interceptors.add(PrettyDioLogger())
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      )
      ..interceptors.add(
        RetryInterceptor(
          dio: _dio,
          logPrint: log,
          retryDelays: const [
            Duration(seconds: 2),
            Duration(seconds: 4),
            Duration(seconds: 10),
          ],
        ),
      );
  }

  /// * GET
  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// * POST
  Future<Response<dynamic>> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// * PUT
  Future<Response<dynamic>> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// * PUT
  Future<Response<dynamic>> patch(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }

  /// * DELETE
  Future<dynamic> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on Exception catch (_) {
      rethrow;
    }
  }
}

// receiveTimeout
const int receiveTimeout = 15000;

// connectTimeout
const int connectionTimeout = 15000;