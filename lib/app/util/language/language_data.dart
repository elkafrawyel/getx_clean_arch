import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/app/util/constants.dart';
import 'package:getx_clean_arch/data/providers/storage/local_provider.dart';

class LanguageData {
  final String flag;
  final String name;
  final String languageCode;

  static var selectedLanguageIndex = languageList()
      .where((element) => element.languageCode == (Get.locale?.languageCode ?? Constants.mainAppLanguage))
      .first;

  LanguageData(this.flag, this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData("🇺🇸", "English", 'en'),
      LanguageData("🇸🇦", "اَلْعَرَبِيَّةُ", "ar"),
    ];
  }

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageData &&
          runtimeType == other.runtimeType &&
          flag == other.flag &&
          name == other.name &&
          languageCode == other.languageCode;

  @override
  int get hashCode => flag.hashCode ^ name.hashCode ^ languageCode.hashCode;

  static Future<void> changeLanguage(LanguageData value) async {
    await Get.updateLocale(Locale(value.languageCode));
    await LocalProvider.save(LocalProviderKeys.language, value.languageCode);
  }
}
