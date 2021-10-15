import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ApiException {
  int statusCode;
  String message;

  ApiException(this.message, this.statusCode);
  factory ApiException.fromError(String message, int statusCode) {
    switch (statusCode) {
      case 400:
        return BadRequestException(message);
        break;
      case 401:
        return UnauthorizedException(message);
        break;
      case 403:
        return ForbiddenException(message);
        break;
      case 404:
        return NotFoundException(message);
        break;
      default:
        return UnknownApiException(message, statusCode);
    }
  }

  @override
  String toString() {
    return "Error occured with status $statusCode and with message$message";
  }
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super(message, 400);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message, 401);
}

class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super(message, 403);
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message, 404);
}

class UnknownApiException extends ApiException {
  UnknownApiException(String message, int statusCode)
      : super(message, statusCode);
}
