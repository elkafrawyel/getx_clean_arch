import 'package:get/get.dart';
import 'package:getx_clean_arch/app/util/information_viewer.dart';
import 'package:getx_clean_arch/app/util/operationReply.dart';
import 'package:getx_clean_arch/data/providers/storage/local_storage.dart';
import 'package:getx_clean_arch/domain/entities/requests/login_request.dart';
import 'package:getx_clean_arch/domain/repositories/auth_repository.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_binding.dart';
import 'package:getx_clean_arch/presentation/pages/home/home_page.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);

  final AuthRepository _authRepository;
  RxBool loading = false.obs;

  Future login(String phone, String password) async {
    loading.value = true;
    OperationReply operationReply = await _authRepository.login(
      loginRequest: LoginRequest(
        phone: phone,
        password: password,
        countryCode: '+20',
        fcmToken: ''
      ),
    );
    loading.value = false;
    if (operationReply.isSuccess()) {
      await LocalStorage.saveUser(operationReply.returnData);
      Get.to(() => HomePage(), binding: HomeBinding());
    } else {
      InformationViewer.showErrorToast(msg: 'Error in login ==> ${operationReply.status} ${operationReply.message}');
    }
  }
}
