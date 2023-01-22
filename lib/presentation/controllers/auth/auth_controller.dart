import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/app/util/information_viewer.dart';
import 'package:getx_clean_arch/app/util/operationReply.dart';
import 'package:getx_clean_arch/data/providers/storage/local_provider.dart';
import 'package:getx_clean_arch/domain/entities/requests/login_request.dart';
import 'package:getx_clean_arch/domain/repositories/auth_repository.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_binding.dart';
import 'package:getx_clean_arch/presentation/pages/home_screen/home_page.dart';

import '../../../data/models/user_response.dart';
import '../../../data/providers/network/exception.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);

  final AuthRepository _authRepository;
  RxBool loading = false.obs;

  Future login(String phone, String password) async {
    loading.value = true;
    Either<Exception, UserResponse> result = await _authRepository.login(
      loginRequest: LoginRequest(
        phone: phone,
        password: password,
        countryCode: '+20',
        fcmToken: '',
      ),
    );
    loading.value = false;
    result.fold(
      (exception) {
        if (exception is NotFoundException) {
          InformationViewer.showErrorToast(msg: exception.message);
        } else if (exception is UnauthorizedException) {
          InformationViewer.showErrorToast(msg: exception.message);
        } else if (exception is BadRequestException) {
          InformationViewer.showErrorToast(msg: exception.message);
        } else {
          InformationViewer.showErrorToast(msg: 'General Error');
        }
      },
      (data) async {
        await LocalProvider.saveUser(data);
        Get.to(() => HomePage(), binding: HomeBinding());
      },
    );
  }
}
