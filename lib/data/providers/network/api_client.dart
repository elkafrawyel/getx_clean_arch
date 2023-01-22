import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_storage/get_storage.dart';
import '../../../app/util/environment.dart';
import '../storage/local_provider.dart';
import 'exception.dart';
import 'logging_interceptor.dart';

const requestTimeOut = 250000;

class ApiClient {
  final Dio dio = Dio(BaseOptions(
    baseUrl: Environment.url(),
    followRedirects: false,
    validateStatus: (status) => status! <= 500,
    connectTimeout: requestTimeOut,
    receiveTimeout: requestTimeOut,
  ))
    ..interceptors.add(LoggingInterceptor());

  final Map<String, String>? headers;

  ApiClient({this.headers}) {
    dio.options.headers = headers;
    //todo if there is any auth_tokens uncomment here
    dio.options.headers
        .putIfAbsent("Authorization", () => "Bearer ${GetStorage().read(LocalProviderKeys.apiToken.name)}");
    dio.options.headers.putIfAbsent("Language", () => "${GetStorage().read(LocalProviderKeys.language.name)}");
    dio.options.headers.putIfAbsent("Content-Type", () => "application/json");
  }

  Future<Either<Exception, dynamic>> _handleResponse(
    Future<Response> request,
  ) async {
    try {
      final response = await request;
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return right(response.data);
      } else {
        return left(ApiErrorHandler.handleError(response.statusCode));
      }
    } catch (e) {
      return left(ApiErrorHandler.handleError(e));
    }
  }

  Future<Either<Exception, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.get(
      url,
      options: Options(headers: headers, validateStatus: (status) => true),
      queryParameters: {
        if (queryParameters != null) ...queryParameters,
      },
    );
    return _handleResponse(request);
  }

  Future<Either<Exception, dynamic>> post(
    String url,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.post(
      url,
      options: Options(headers: headers, validateStatus: (status) => true),
      data: data,
      queryParameters: queryParameters,
    );
    return _handleResponse(request);
  }

  Future<Either<Exception, dynamic>> put(
    String url,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.put(
      url,
      options: Options(headers: headers, validateStatus: (status) => true),
      data: data,
      queryParameters: queryParameters,
    );
    return _handleResponse(request);
  }

  Future<Either<Exception, dynamic>> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.delete(
      url,
      options: Options(headers: headers, validateStatus: (status) => true),
      queryParameters: queryParameters,
    );
    return _handleResponse(request);
  }

  Future<Either<Exception, dynamic>> request(
    String url, {
    String? method, // if request is not one of CRUD operations, give request type name here and use this function
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final request = dio.request(
      url,
      options: Options(
        method: method,
        headers: headers,
        validateStatus: (status) => true,
      ),
      data: data,
      queryParameters: queryParameters,
    );
    return _handleResponse(request);
  }
}
