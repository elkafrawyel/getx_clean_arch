import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:getx_clean_arch/app/util/operationReply.dart';
import 'package:getx_clean_arch/data/models/user_response.dart';
import 'package:getx_clean_arch/domain/entities/requests/change_password_request.dart';
import 'package:getx_clean_arch/domain/entities/requests/change_phone_request.dart';
import 'package:getx_clean_arch/domain/entities/requests/login_request.dart';
import 'package:getx_clean_arch/domain/entities/requests/register_request.dart';
import 'package:getx_clean_arch/domain/entities/requests/update_profile_request.dart';

import '../../data/providers/network/exception.dart';

abstract class AuthRepository {
  Future<Either<ApiException, UserResponse>> login({required LoginRequest loginRequest});

  Future<OperationReply<UserResponse>> register({required RegisterRequest registerRequest});

  Future<OperationReply<UserResponse>> profile({required int userId});

  Future<OperationReply<UserResponse>> updateProfileInformation({required UpdateProfileRequest updateProfileRequest});

  Future<OperationReply<UserResponse>> updateProfileAvatar({required File image});

  Future<OperationReply<void>> forgetPasswordByPhone({required String phone});

  Future<OperationReply<void>> forgetPasswordByEmail({required String email});

  Future<OperationReply<void>> changePassword({required ChangePasswordRequest changePasswordRequest});

  Future<OperationReply<void>> changePhoneNumber({required ChangePhoneRequest changePhoneRequest});

  Future<OperationReply<void>> verifyOtpCode({required String code});

  Future<OperationReply<void>> resendSms({required String phone});

  Future<OperationReply<void>> deleteAccount();

  Future<OperationReply<void>> logOut();
}
