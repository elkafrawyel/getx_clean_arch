import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:getx_clean_arch/app/util/network_helper.dart';
import 'package:getx_clean_arch/app/util/operationReply.dart';
import 'package:getx_clean_arch/data/models/user_response.dart';
import 'package:getx_clean_arch/data/providers/network/api_provider.dart';
import 'package:getx_clean_arch/data/providers/network/exception.dart';
import 'package:getx_clean_arch/domain/entities/requests/change_password_request.dart';
import 'package:getx_clean_arch/domain/entities/requests/change_phone_request.dart';
import 'package:getx_clean_arch/domain/entities/requests/login_request.dart';
import 'package:getx_clean_arch/domain/entities/requests/register_request.dart';
import 'package:getx_clean_arch/domain/entities/requests/update_profile_request.dart';
import 'package:getx_clean_arch/domain/repositories/auth_repository.dart';

import '../providers/network/api_client.dart';

class AuthRepositoryIml extends AuthRepository {
  final apiClient = ApiClient();

  safeCallApi(Function() call) async {
    if (await NetworkHelper.isConnected()) {
      call();
    } else {
      return OperationReply.connectionDown();
    }
  }

  @override
  Future<Either<ApiException, UserResponse>> login({required LoginRequest loginRequest}) async {
    if (await NetworkHelper.isConnected()) {
      final Either<ApiException, dynamic> response = await apiClient.post(
        '/login',
        {
          'mobile': loginRequest.phone,
          'password': loginRequest.password,
          'country_code': loginRequest.countryCode,
          "fcm_token": loginRequest.fcmToken,
        },
      );

      return response.fold(
        (exception) => left(exception),
        (data) => right(UserResponse.fromJson(data)),
      );
    } else {
      return left(NoConnectionException(message: 'No connection available'));
    }
  }

  @override
  Future<OperationReply<UserResponse>> register({required RegisterRequest registerRequest}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<UserResponse>> profile({required int userId}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<UserResponse>> forgetPasswordByEmail({required String email}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<UserResponse>> forgetPasswordByPhone({required String phone}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> changePassword({required ChangePasswordRequest changePasswordRequest}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> changePhoneNumber({required ChangePhoneRequest changePhoneRequest}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> deleteAccount() async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> logOut() async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> resendSms({required String phone}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<UserResponse>> updateProfileAvatar({required File image}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<UserResponse>> updateProfileInformation(
      {required UpdateProfileRequest updateProfileRequest}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> verifyOtpCode({required String code}) async {
    return OperationReply.failed();
  }
}
