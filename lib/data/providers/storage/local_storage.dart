import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_clean_arch/data/models/user_response.dart';
import 'package:getx_clean_arch/data/providers/network/api_provider.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_binding.dart';
import 'package:getx_clean_arch/presentation/pages/home/home_page.dart';

class LocalStorage {
  static final GetStorage _box = GetStorage();
  static const String languageKey = 'language';
  static const String apiToken = 'token';
  static const String apiTokenType = 'token_type';
  static const String allowNotificationKey = 'notification';
  static const String currencyKey = 'currency';
  static const String introductionKey = 'introduction';
  static const String userType = 'userType';
  static const String providerId = 'providerId';
  static const String phoneVerified = 'phoneVerified';

  static init() async {
    await GetStorage.init();
  }

  static String getUserToken = getString(apiToken) ?? 'No Token';

  static bool get isLogged => getString(apiToken) != null;

  /// ============= ============== ===================  =================
  static Future setString(String key, String value) async {
    await GetStorage().write(key, value);
  }

  static String? getString(String key) {
    String? value = GetStorage().read(key);
    return value;
  }

  static Future setBool(String key, bool value) async {
    await GetStorage().write(key, value);
  }

  static bool getBool(String key) {
    bool? value = GetStorage().read(key);
    return value ?? false;
  }

  static setInt(String key, int value) async {
    await GetStorage().write(key, value);
  }

  static int getInt(String key) {
    return GetStorage().read(key) ?? 0;
  }

  static Future<bool> saveUser(UserResponse? userResponse) async {
    try {
      if (userResponse?.accessToken != null) {
        await setString(apiToken, userResponse?.accessToken ?? 'no token');
        await setString(apiTokenType, userResponse?.tokenType ?? 'no type');
        await setString(userType, userResponse?.user?.type ?? 'client'); // client , owner , broker
        await setString(providerId, userResponse?.user?.providerId ?? 'no provider');
        await setInt(phoneVerified, userResponse?.user?.isVerified ?? 0); // 1,0
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
