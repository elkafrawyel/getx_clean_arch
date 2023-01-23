import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_clean_arch/app/util/constants.dart';
import 'package:getx_clean_arch/app/util/util.dart';
import 'package:getx_clean_arch/data/models/user_response.dart';
import 'package:getx_clean_arch/domain/entities/models/user_model.dart';
import 'package:getx_clean_arch/presentation/controllers/auth/auth_binding.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_binding.dart';
import 'package:getx_clean_arch/presentation/pages/home_screen/home_page.dart';
import 'package:getx_clean_arch/presentation/pages/login/login_page.dart';

enum LocalProviderKeys {
  language, //String
  apiToken, //String
  apiTokenType, //String
  notifications, //int
  userModel, //Json String
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

  static String? getUserToken() => get(LocalProviderKeys.apiToken);

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
        await save(LocalProviderKeys.apiToken, userResponse?.accessToken ?? 'no token');
        await save(LocalProviderKeys.apiTokenType, userResponse?.tokenType ?? Constants.defaultApiTokenType);
        await save(LocalProviderKeys.userModel, jsonEncode(userResponse?.user?.toJson())); // userModel jsonString
        return true;
      } else {
        debugPrint('Failed To save user');
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static UserModel? getUser() {
    String? userModelString = get(LocalProviderKeys.userModel);
    if (userModelString == null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userModelString));
    return userModel;
  }

  static Future<void> signOut() async {
    await _box.erase();
    Get.offAll(() => const LoginPage(), binding: AuthBinding());
  }
}
