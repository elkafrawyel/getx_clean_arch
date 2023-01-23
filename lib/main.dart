import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'data/providers/storage/local_provider.dart';
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalProvider.init();
  await Firebase.initializeApp();

  await FCMConfig.instance
      .init(
    // Note once channel created it can not be changed
    // defaultAndroidForegroundIcon: "@mipmap/custom_icon",
    defaultAndroidChannel: const AndroidNotificationChannel(
      'fcm_channel',
      'Fcm config',
      importance: Importance.high,
    ),
  )
      .then((value) async {
    if (kDebugMode) {
      print(await FCMConfig.instance.messaging.getToken());
    }
    if (!kIsWeb) {
      FCMConfig.instance.messaging.subscribeToTopic('ssss_test_fcm_topic');
    }
  });
  runApp(const App());
}
