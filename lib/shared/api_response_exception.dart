import 'dart:io';

class ApiResponseException extends HttpException {
  ApiResponseException(
    super.message, {
    Uri? uri,
    required this.statusCode,
  });

  final int statusCode;
}

