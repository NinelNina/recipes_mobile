import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes/features/start/presentation/start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const Start());
  });
}

