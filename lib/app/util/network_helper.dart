import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:getx_clean_arch/data/providers/storage/local_storage.dart';

import 'operationReply.dart';

class NetworkHelper {
  static const int noInternetConnectionCode = 415;
  static const int errorCode = 500;

  static bool isSuccess(Response response) {
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }

  static Future<bool> isConnected() async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }

  ///Don't forget to cast it to function return type using [as] method
  static OperationReply handleCommonNetworkCases(Response response) {
    bool isAr = Get.locale?.languageCode == 'ar';
    Map? body;
    try {
      body = response.data;
    } catch (e) {
      Get.log('error in api:\n${response.data}');
    }

    if (response.statusCode == errorCode) {
      // handle errors
      return OperationReply(OperationStatus.failed, message: isAr ? 'حدث خطأ ما' : 'General Error');
    } else if (response.statusCode == noInternetConnectionCode) {
      // handle connection
      return OperationReply(
        OperationStatus.connectionDown,
        message: isAr ? 'لا يوجد اتصال بالانترنت' : 'No internet connection',
      );
    } else if (body != null && body['errors'] != null) {
      // handle api errors
      String errorMessage = '';
      Map<String, dynamic> errorMap = body['errors'];
      errorMap.forEach((key, value) {
        List errors = value;
        errorMessage = errorMessage + errors.first.toString();
      });
      return OperationReply(OperationStatus.failed, message: errorMessage);
    } else if (body != null && body['message'] != null && body['message'].length < 255) {
      if (body['message'].toString().contains('Unauthenticated')) {
        LocalStorage.signOut();
      }
      String errorMessage = '';
      if (body['message'].toString().isNotEmpty) {
        errorMessage = body['message'].toString();
      } else if (body['exception'] != null && body['exception'].toString().isNotEmpty) {
        errorMessage = body['exception'].toString();
      }
      return OperationReply(OperationStatus.failed, message: errorMessage);
    } else if (body != null && body['error'] != null) {
      String errorMessage = '';
      Map<String, dynamic> errorMap = body['error'];
      errorMap.forEach((key, value) => errorMessage = errorMessage + value.toString());
      return OperationReply(OperationStatus.failed, message: errorMessage);
    } else {
      return OperationReply(OperationStatus.failed, message: isAr ? 'حدث خطأ ما' : 'General Error');
    }
  }
}
