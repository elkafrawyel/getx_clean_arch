import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/app/util/environment.dart';
import 'package:getx_clean_arch/app/util/language/translation.dart';
import 'package:getx_clean_arch/data/providers/storage/local_provider.dart';
import 'package:getx_clean_arch/presentation/controllers/auth/auth_binding.dart';
import 'package:getx_clean_arch/presentation/pages/splash.dart';
import 'package:oktoast/oktoast.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: Environment.appMode == AppMode.staging || Environment.appMode == AppMode.testing,
        defaultTransition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 300),
        title: 'HostN',
        theme: ThemeData(primaryColor: const Color(0xffB3171C)),
        translations: Translation(),
        locale: Locale(LocalProvider.getAppLanguage()),
        fallbackLocale: Locale(LocalProvider.getAppLanguage()),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialBinding: AuthBinding(),
        builder: (context, navigatorWidget) {
          try {
            /// very important to handle text size difference on mobile screens
            return MediaQuery(
              child: navigatorWidget ?? const SizedBox(),
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
            );
          } catch (e) {
            return navigatorWidget ?? const SizedBox();
          }
        },
        supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
      ),
    );
  }
}
