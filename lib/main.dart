import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:contactlistwithhive/presentation/home/home_screen.dart';
import 'package:contactlistwithhive/presentation/not_granted_permission/not_granted_permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainInjector().init();
  if (await Permission.storage.isGranted == true) {
    runApp(MyApp());
  } else {
    runApp(NotGrantedPermissionScreen());
  }
}
