import 'package:get/get_core/get_core.dart';

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void logMessage(String message, {bool isError = false}) {
    Get.log(message, isError: isError);
  }
}
