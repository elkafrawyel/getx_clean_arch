import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getx_clean_arch/data/providers/storage/local_provider.dart';

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

class UnDefinedException extends ApiException {
  UnDefinedException({required String message}) : super(message: message);
}

class ApiErrorHandler {
  static String errorMessage = 'Something went wrong with the response data';

  static ApiException handleError({Response? response, String? message}) {
    if (response == null) {
      return UnDefinedException(message: message ?? errorMessage);
    } else {
      final int code = response.statusCode ?? 500;

      switch (code) {
        case 400:
          return BadRequestException(message: 'Bad Request Error');
        case 401:
          LocalProvider.signOut();
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
          return _handleBackEndError(response);
      }
    }
  }

  static ApiException _handleBackEndError(Response response) {
    Map? body = response.data;

    if (body != null && body['errors'] != null) {
      errorMessage = '';
      Map<String, dynamic> errorMap = body['errors'];
      errorMap.forEach((key, value) {
        List errors = value;
        errorMessage = errorMessage + errors.first.toString();
      });
      return UnDefinedException(message: errorMessage);
    } else if (body != null && body['message'] != null && body['message'].length < 255) {
      errorMessage = '';
      if (body['message'].toString().isNotEmpty) {
        errorMessage = body['message'].toString();
      } else if (body['exception'] != null && body['exception'].toString().isNotEmpty) {
        errorMessage = body['exception'].toString();
      }
    } else if (body != null && body['error'] != null) {
      errorMessage = '';
      Map<String, dynamic> errorMap = body['error'];
      errorMap.forEach((key, value) => errorMessage = errorMessage + value.toString());
    }
    return UnDefinedException(message: errorMessage);
  }
}
