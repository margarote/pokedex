import '../constants/app_strings.dart';

sealed class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class ServerException extends AppException {
  final int? statusCode;
  const ServerException([
    super.message = AppStrings.serverError,
    this.statusCode,
  ]);
}

class NetworkException extends AppException {
  const NetworkException([super.message = AppStrings.networkError]);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = AppStrings.notFoundError]);
}
