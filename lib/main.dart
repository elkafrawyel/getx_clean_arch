import 'package:flutter/material.dart';
import 'data/providers/storage/local_storage.dart';
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.init();
  runApp(const App());
}
