class ApiException implements Exception {
  final String message;

  ApiException({required this.message});

  @override
  String toString() => message;
}

class NoConnectionException extends ApiException {
  NoConnectionException({required String message}) : super(message: message);
}

class BadRequestException extends ApiException {
  BadRequestException({required String message}) : super(message: message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({required String message}) : super(message: message);
}

class ForbiddenException extends ApiException {
  ForbiddenException({required String message}) : super(message: message);
}

class NotFoundException extends ApiException {
  NotFoundException({required String message}) : super(message: message);
}

class ConflictException extends ApiException {
  ConflictException({required String message}) : super(message: message);
}

class InternalServerErrorException extends ApiException {
  InternalServerErrorException({required String message}) : super(message: message);
}

class BadGatewayException extends ApiException {
  BadGatewayException({required String message}) : super(message: message);
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException({required String message}) : super(message: message);
}

class ApiErrorHandler {
  static Exception handleError(statusCode) {
    // I usually use Dio package for networking. If you use Http, you have to change here to HttpError
    final e = statusCode;
    switch (e) {
      case 400:
        return BadRequestException(message: 'Bad Request Error');
      case 401:
        return UnauthorizedException(message: 'Unauthorized Request Error');
      case 403:
        return ForbiddenException(message: 'Forbidden Request Error');
      case 404:
        return NotFoundException(message: 'NotFound Request Error');
      case 409:
        return ConflictException(message: 'Conflict Request Error');
      case 500:
        return InternalServerErrorException(message: 'InternalServerError Request Error');
      case 502:
        return BadGatewayException(message: 'BadGateway Request Error');
      case 503:
        return ServiceUnavailableException(message: 'ServiceUnavailable Request Error');
      default:
        return ApiException(message: 'general error');
    }
  }
}
