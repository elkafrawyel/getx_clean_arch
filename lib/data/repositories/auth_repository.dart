import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:getx_clean_arch/app/util/network_helper.dart';
import 'package:getx_clean_arch/app/util/operationReply.dart';
import 'package:getx_clean_arch/data/models/user_response.dart';
import 'package:getx_clean_arch/data/providers/network/api_provider.dart';
import 'package:getx_clean_arch/domain/repositories/auth_repository.dart';

class AuthRepositoryIml extends AuthRepository {
  @override
  Future<OperationReply<UserResponse>> login({required String phone, required String password}) async {
    if (await NetworkHelper.isConnected()) {
      final Response<dynamic>? response = await APIProvider.instance.postBody(
        '/login',
        body: {
          'mobile': phone,
          'password': password,
          'country_code': '+20',
          "fcm_token": 'fcmToken',
        },
      );

      if(response!=null){
        if (NetworkHelper.isSuccess(response)) {
          UserResponse userResponse = UserResponse.fromJson(response.data);
          return OperationReply.success(returnData: userResponse);
        } else {
          return NetworkHelper.handleCommonNetworkCases(response).as<UserResponse>();
        }
      }else{
        return OperationReply.failed();
      }
    } else {
      return OperationReply.connectionDown();
    }
  }

  @override
  Future<OperationReply<UserResponse>> profile({required int userId}) async{
    return OperationReply.failed();
  }
}
