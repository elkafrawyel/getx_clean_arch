import 'package:getx_clean_arch/app/core/usecases/pram_usecase.dart';
import 'package:getx_clean_arch/app/util/operationReply.dart';
import 'package:getx_clean_arch/data/models/user_response.dart';
import 'package:getx_clean_arch/domain/repositories/auth_repository.dart';

class ProfileUseCase extends ParamUseCase<OperationReply<UserResponse>, int> {
  final AuthRepository _repo;

  ProfileUseCase(this._repo);

  @override
  Future<OperationReply<UserResponse>> execute(int params) {
    return _repo.profile(userId: params);
  }
}
