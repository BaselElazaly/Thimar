import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/core/cache/cache_helper.dart';
import 'package:thimar/core/services/failure_handler.dart';

class ServerGate {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://thimar.amr.aait-d.com/public/api/',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  Map<String, dynamic> _getHeaders() => {
        'Authorization': 'Bearer ${CacheHelper.getToken()}',
        'Accept': 'application/json',
        'Accept-Language': CacheHelper.getData(key: 'lang').isEmpty ? 'ar' : CacheHelper.getData(key: 'lang'),
      };

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.connectionError:
        return DataSource.noInternetConnection.getFailure();
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      default:
        return DataSource.defaultError.getFailure();
    }
  }

  Failure _handleBadResponse(DioException error) {
    final code = error.response?.statusCode ?? 500;

    if (code == 401) return DataSource.unauthorised.getFailure();
    if (code == 403) return DataSource.forbidden.getFailure();
    if (code == 404) return DataSource.notFound.getFailure();

    String message = "default_error".tr();
    if (error.response?.data is Map) {
      message = error.response?.data['message'] ?? message;
    }
    return Failure(code, message);
  }

  Future<CustomResponse> sendRequest({required String path, Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post(path, data: data, options: Options(headers: _getHeaders()));
      return CustomResponse(isSuccess: true, data: response.data, message: response.data['message'] ?? "");
    } on DioException catch (e) {
      Failure failure = _handleError(e);
      return CustomResponse(isSuccess: false, message: failure.message);
    }
  }

  Future<CustomResponse> get({required String path, Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(path, queryParameters: params, options: Options(headers: _getHeaders()));
      return CustomResponse(isSuccess: true, data: response.data, message: response.data['message'] ?? "");
    } on DioException catch (e) {
      Failure failure = _handleError(e);
      return CustomResponse(isSuccess: false, message: failure.message);
    }
  }

  Future<CustomResponse> put({required String path, Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(path, data: data, options: Options(headers: _getHeaders()));
      return CustomResponse(isSuccess: true, data: response.data, message: response.data['message'] ?? "");
    } on DioException catch (e) {
      Failure failure = _handleError(e);
      return CustomResponse(isSuccess: false, message: failure.message);
    }
  }

  Future<CustomResponse> delete({required String path, Map<String, dynamic>? data, Map<String, dynamic>? params}) async {
    try {
      final response = await dio.delete(path, data: data, queryParameters: params, options: Options(headers: _getHeaders()));
      return CustomResponse(isSuccess: true, data: response.data, message: response.data['message'] ?? "تم الحذف بنجاح");
    } on DioException catch (e) {
      Failure failure = _handleError(e);
      return CustomResponse(isSuccess: false, message: failure.message);
    }
  }
}

class CustomResponse {
  final bool isSuccess;
  final dynamic data;
  final String message;

  CustomResponse({required this.isSuccess, this.data, required this.message});
}