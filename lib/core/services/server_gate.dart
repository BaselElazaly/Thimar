// ignore_for_file: unused_catch_clause

import 'package:dio/dio.dart';
import 'package:thimar/core/cache/cache_helper.dart';

class ServerGate {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://thimar.amr.aait-d.com/public/api/',
    ),
  );

  Map<String, dynamic> _getHeaders() {
    return {
      'Authorization': 'Bearer ${CacheHelper.getToken()}',
      'Accept': 'application/json',
      'Accept-Language': CacheHelper.getData(key: 'lang').isEmpty
          ? 'ar'
          : CacheHelper.getData(key: 'lang'),
    };
  }

  Future<Response> sendRequest({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        options: Options(
          headers: _getHeaders(),
        ),
      );
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<CustomResponse> get({
    required String path,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: params,
        options: Options(
          headers: _getHeaders(),
        ),
      );

      return CustomResponse(
        isSuccess: true,
        data: response.data,
        message: response.data['message'] ?? "The operation was successful",
      );
    } on DioException catch (e) {
      return CustomResponse(
        isSuccess: false,
        data: e.response?.data,
        message: e.response?.data?['message'] ?? "Something went wrong",
      );
    }
  }

  Future<CustomResponse> delete({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: params,
        options: Options(headers: _getHeaders()),
      );

      String msg = "تم الحذف بنجاح";
      if (response.data is Map) {
        msg = response.data['message'] ?? msg;
      }

      return CustomResponse(
        isSuccess: true,
        data: response.data,
        message: msg,
      );
    } on DioException catch (e) {
      String errMsg = "حدث خطأ غير متوقع";

      if (e.response?.data is Map) {
        errMsg = e.response?.data['message'] ?? errMsg;
      } else {
        errMsg = "خطأ في السيرفر (Server Error)";
      }

      return CustomResponse(
        isSuccess: false,
        message: errMsg,
        data: e.response?.data,
      );
    }
  }

  Future<CustomResponse> put({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        options: Options(headers: _getHeaders()),
      );

      return CustomResponse(
        isSuccess: true,
        data: response.data,
        message: response.data['message'] ?? "تم التعديل بنجاح",
      );
    } on DioException catch (e) {
      return CustomResponse(
        isSuccess: false,
        data: e.response?.data,
        message: e.response?.data?['message'] ?? "فشلت عملية التعديل",
      );
    }
  }
}

class CustomResponse {
  final bool isSuccess;
  final dynamic data;
  final String message;

  CustomResponse({
    required this.isSuccess,
    this.data,
    required this.message,
  });
}
