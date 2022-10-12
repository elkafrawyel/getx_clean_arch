import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:getx_clean_arch/app/util/enviroment.dart';
import 'package:getx_clean_arch/data/providers/storage/local_provider.dart';
import 'logging_interceptor.dart';

class APIProvider {
  static const requestTimeOut = 250000;

  final Dio _client = Dio(
    BaseOptions(
      baseUrl: Environment.url(),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.cacheControlHeader: 'no-Cache',
        if (LocalProvider.isLogged()) 'Authorization': 'Bearer ${LocalProvider.getUserToken}'
      },
      followRedirects: false,
      validateStatus: (status) => status! <= 500,
      connectTimeout: requestTimeOut,
      receiveTimeout: requestTimeOut,
    ),
  )..interceptors.add(LoggingInterceptor());

  static final _singleton = APIProvider();

  static APIProvider get instance => _singleton;

  updateApiToken(String? apiToken) {
    if (apiToken != null) {
      _client.options.headers['Authorization'] = apiToken;
    } else {
      _client.options.headers.removeWhere((key, value) => key == 'Authorization');
    }
  }

  Future<Response<dynamic>>? postBody(String path, {required Map<String, dynamic> body}) {
    final response = _client.post(path, data: FormData.fromMap(body));
    return response;
  }

  Future<Response<dynamic>> postMultiPart(String path, {required FormData formData}) {
    final response = _client.post(path, data: formData);
    return response;
  }

  Future<Response<dynamic>> get(String path) async {
    return await _client.get(path);
  }
}
