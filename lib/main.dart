import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Injector.init();
}
