import 'package:flutter/material.dart';
import 'data/providers/storage/local_provider.dart';
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalProvider.init();
  runApp(const App());
}
