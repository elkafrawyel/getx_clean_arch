import 'package:getx_clean_arch/app/core/usecases/pram_usecase.dart';
import 'package:getx_clean_arch/app/util/operationReply.dart';
import 'package:getx_clean_arch/data/models/user_response.dart';
import 'package:getx_clean_arch/domain/repositories/auth_repository.dart';

class LoginRequest {
  String phone, password;

  LoginRequest({required this.phone,required this.password});
}

class LoginUseCase extends ParamUseCase<OperationReply<UserResponse>, LoginRequest> {
  final AuthRepository _repo;

  LoginUseCase(this._repo);

  @override
  Future<OperationReply<UserResponse>> execute(LoginRequest params) {
    return _repo.login(phone: params.phone, password: params.password);
  }
}
