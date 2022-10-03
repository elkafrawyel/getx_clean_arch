import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:getx_clean_arch/data/providers/storage/local_storage.dart';
import 'logging_interceptor.dart';

class APIProvider {
  static const requestTimeOut = 250000;

  static const _baseUrl = 'https://host-n.com/api/app';

  final Dio _client = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.cacheControlHeader: 'no-Cache',
        if (LocalStorage.isLogged) 'Authorization': 'Bearer ${LocalStorage.getUserToken}'
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
    try {
      final response = _client.post(path, data: FormData.fromMap(body));
      return response;
    } on DioError catch (e) {

      return null;
    }
  }

  Future<Response<dynamic>> postMultiPart(String path, {required FormData formData}) {
    final response = _client.post(path, data: formData);
    return response;
  }

  Future<Response<dynamic>> get(String path) async {
    return await _client.get(path);
  }
}
