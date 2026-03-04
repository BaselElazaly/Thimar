import 'package:easy_localization/easy_localization.dart';

class Failure {
  final int code;
  final String message;
  Failure(this.code, this.message);
}

enum DataSource {
  success,
  badRequest,
  unauthorised,
  forbidden,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  noInternetConnection,
  defaultError
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(400, "bad_request_error".tr());
      case DataSource.unauthorised:
        return Failure(401, "unauthorized_error".tr());
      case DataSource.forbidden:
        return Failure(403, "forbidden_error".tr());
      case DataSource.notFound:
        return Failure(404, "not_found_error".tr());
      case DataSource.internalServerError:
        return Failure(500, "internal_server_error".tr());
      case DataSource.connectTimeout:
        return Failure(-1, "timeout_error".tr());
      case DataSource.noInternetConnection:
        return Failure(-6, "no_internet_error".tr());
      default:
        return Failure(-8, "unknown_error".tr());
    }
  }
}