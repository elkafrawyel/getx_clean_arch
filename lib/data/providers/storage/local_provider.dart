import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_clean_arch/app/util/constants.dart';
import 'package:getx_clean_arch/app/util/util.dart';
import 'package:getx_clean_arch/data/models/user_response.dart';
import 'package:getx_clean_arch/data/providers/network/api_provider.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_binding.dart';
import 'package:getx_clean_arch/presentation/pages/home/home_page.dart';

enum LocalProviderKeys {
  language, //String
  apiToken, //String
  apiTokenType, //String
  notifications, //int
  userType, //String
  loggedInBySocial, //int
  phoneVerified, //int
}

class LocalProvider {
  static final GetStorage _box = GetStorage();

  static init() async {
    await GetStorage.init();
    if (get(LocalProviderKeys.language) == null) {
      String langCode = (Get.deviceLocale?.languageCode ?? Constants.mainAppLanguage);
      if (langCode == 'ar' || langCode == 'en') {
        await save(LocalProviderKeys.language, langCode);
      } else {
        await save(LocalProviderKeys.language, Constants.mainAppLanguage);
      }
    }
  }

  static String getAppLanguage() => get(LocalProviderKeys.language) ?? Constants.mainAppLanguage;

  static String getUserToken() => get(LocalProviderKeys.apiToken) ?? 'No Token';

  static bool isLogged() => get(LocalProviderKeys.apiToken) != null;

  /// ============= ============== ===================  =================
  static Future save(LocalProviderKeys localProviderKeys, dynamic value) async {
    Utils.logMessage('Setting value to ${localProviderKeys.name}');
    await GetStorage().write(localProviderKeys.name, value);
  }

  static String? get(LocalProviderKeys localProviderKeys) {
    Utils.logMessage('Getting value of ${localProviderKeys.name}');
    String? value = GetStorage().read(localProviderKeys.name);
    return value;
  }

  static Future<bool> saveUser(UserResponse? userResponse) async {
    try {
      if (userResponse?.accessToken != null) {
        await save(LocalProviderKeys.language, userResponse?.accessToken ?? 'no token');
        await save(LocalProviderKeys.apiTokenType, userResponse?.tokenType ?? Constants.defaultApiTokenType);
        await save(
          LocalProviderKeys.userType,
          userResponse?.user?.type ?? Constants.defaultUserType,
        ); // client , owner , broker
        await save(
          LocalProviderKeys.loggedInBySocial,
          userResponse?.user?.providerId == null ? 0 : 1,
        );
        await save(
          LocalProviderKeys.phoneVerified,
          userResponse?.user?.isVerified ?? 0,
        ); // 1,0
        return true;
      } else {
        Get.log('Failed To save user');
        return false;
      }
    } catch (e) {
      Get.log(e.toString());
      return false;
    }
  }

  static Future<void> signOut() async {
    await _box.erase();
    APIProvider.instance.updateApiToken('Ali');
    Get.offAll(() => HomePage(), binding: HomeBinding());
  }
}
