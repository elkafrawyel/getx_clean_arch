import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/app/util/futureState.dart';
import 'package:getx_clean_arch/app/util/information_viewer.dart';
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
  FutureState futureState = FutureState(FutureStateOptions.initiating);

  Future login(String phone, String password) async {
    futureState.load();
    update();
    Either<ApiException, UserResponse> result = await _authRepository.login(
      loginRequest: LoginRequest(
        phone: phone,
        password: password,
        countryCode: '+20',
        fcmToken: '',
      ),
    );
    result.fold(
      (ApiException exception) {
        InformationViewer.showSnackBar(exception.message);
        futureState.fail();
      },
      (data) async {
        futureState.complete();
        await LocalProvider.saveUser(data);
        Get.off(() => HomePage(), binding: HomeBinding());
      },
    );
    update();
  }
}
