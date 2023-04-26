import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio});

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (statusCode! >= 200 && statusCode < 300) {
          return response.data;
        }
        throw Exception(statusCode);
      }
      throw Exception(response.data.toString());
    } on DioError catch (error) {
      if (error.message != null && error.message!.toLowerCase().contains('socket')) {
        throw Exception("No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw Exception(error.response!.statusCode!);
      }
      throw Exception(error.message);
    } on SocketException {
      throw Exception("No Internet Connection");
    } on TimeoutException {
      throw Exception("Server Not Responding");
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (statusCode! >= 200 && statusCode < 300) {
          return response.data;
        }
        throw Exception(statusCode);
      }
      throw Exception(response.data.toString());
    } on DioError catch (error) {
      if (error.message != null && error.message!.toLowerCase().contains('socket')) {
        throw Exception("No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw Exception(error.response!.statusCode!);
      }
      throw Exception(error.message);
    } on SocketException {
      throw Exception("No Internet Connection");
    } on TimeoutException {
      throw Exception("Server Not Responding");
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (statusCode! >= 200 && statusCode < 300) {
          return response.data;
        }
        throw Exception(statusCode);
      }
      throw Exception(response.data.toString());
    } on DioError catch (error) {
      if (error.message != null && error.message!.toLowerCase().contains('socket')) {
        throw Exception("No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw Exception(error.response!.statusCode!);
      }
      throw Exception(error.message);
    } on SocketException {
      throw Exception("No Internet Connection");
    } on TimeoutException {
      throw Exception("Server Not Responding");
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (response.statusCode != null) {
        final statusCode = response.statusCode;
        if (statusCode! >= 200 && statusCode < 300) {
          return response.data;
        }
        throw Exception(statusCode);
      }
      throw Exception(response.data.toString());
    } on DioError catch (error) {
      if (error.message != null && error.message!.toLowerCase().contains('socket')) {
        throw Exception("No Internet Connection");
      }
      if (error.response?.statusCode != null) {
        throw Exception(error.response!.statusCode!);
      }
      throw Exception(error.message);
    } on SocketException {
      throw Exception("No Internet Connection");
    } on TimeoutException {
      throw Exception("Server Not Responding");
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
