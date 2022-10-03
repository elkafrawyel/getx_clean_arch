import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/presentation/pages/splash.dart';
import 'package:oktoast/oktoast.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OKToast(
      child: GetMaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
