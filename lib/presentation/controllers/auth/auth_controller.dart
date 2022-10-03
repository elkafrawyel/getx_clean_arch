import 'package:get/get.dart';
import 'package:getx_clean_arch/app/util/information_viewer.dart';
import 'package:getx_clean_arch/app/util/operationReply.dart';
import 'package:getx_clean_arch/data/providers/storage/local_storage.dart';
import 'package:getx_clean_arch/domain/usecases/login_usecase.dart';
import 'package:getx_clean_arch/domain/usecases/profile_usecase.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_binding.dart';
import 'package:getx_clean_arch/presentation/pages/home/home_page.dart';

class AuthController extends GetxController {
  AuthController(this._loginUseCase, this._profileUseCase);

  final LoginUseCase _loginUseCase;
  final ProfileUseCase _profileUseCase;
  RxBool loading = false.obs;

  Future login(String phone, String password) async {
    loading.value = true;
    OperationReply operationReply = await _loginUseCase.execute(LoginRequest(
      phone: phone,
      password: password,
    ));
    loading.value = false;
    if (operationReply.isSuccess()) {
      await LocalStorage.saveUser(operationReply.returnData);
      Get.to(() => HomePage(), binding: HomeBinding());
    } else {
      InformationViewer.showErrorToast(msg: 'Error in login ==> ${operationReply.status} ${operationReply.message}');
    }
  }

  Future<void> getProfile() async {
    OperationReply operationReply = await _profileUseCase.execute(5);
    if(operationReply.isSuccess()){

    }else{
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
