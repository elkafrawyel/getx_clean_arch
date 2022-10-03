import 'package:getx_clean_arch/app/util/operationReply.dart';
import 'package:getx_clean_arch/data/models/user_response.dart';

abstract class AuthRepository {
  Future<OperationReply<UserResponse>> login({required String phone,required String password});
  Future<OperationReply<UserResponse>> profile({required int userId});

}
