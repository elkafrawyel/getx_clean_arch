import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/presentation/controllers/auth/auth_binding.dart';
import 'package:getx_clean_arch/presentation/pages/login/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Get.to(() => const LoginPage(), binding: AuthBinding());
    });
    return Container(color: Colors.white);
  }
}
