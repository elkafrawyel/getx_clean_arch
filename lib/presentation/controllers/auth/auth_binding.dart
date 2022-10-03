import 'package:get/get.dart';
import 'package:getx_clean_arch/data/repositories/auth_repository.dart';
import 'package:getx_clean_arch/domain/usecases/login_usecase.dart';
import 'package:getx_clean_arch/domain/usecases/profile_usecase.dart';
import 'package:getx_clean_arch/presentation/controllers/auth/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepositoryIml());
    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepositoryIml>()));
    Get.lazyPut(() => ProfileUseCase(Get.find<AuthRepositoryIml>()));
    Get.lazyPut(() => AuthController(Get.find<LoginUseCase>(), Get.find<ProfileUseCase>()));
  }
}
