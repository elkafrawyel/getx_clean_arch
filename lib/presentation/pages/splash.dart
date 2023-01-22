import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/presentation/controllers/auth/auth_binding.dart';
import 'package:getx_clean_arch/presentation/controllers/home/home_binding.dart';
import 'package:getx_clean_arch/presentation/pages/home_screen/home_page.dart';
import 'package:getx_clean_arch/presentation/pages/login/login_page.dart';
import 'package:getx_clean_arch/presentation/pages/login_screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Get.to(() => HomePage(), binding: HomeBinding());
    });
    return Container(color: Colors.white);
  }
}
