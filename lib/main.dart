import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:contactlistwithhive/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.init();
  runApp(MyApp());
}
