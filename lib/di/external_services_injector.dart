import 'dart:io';

import 'package:contactlistwithhive/data/models/contact_model.dart';
import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:hive/hive.dart';

class ExternalServicesInjector {
  static Future<void> init() async {
    //Hive
    var path = Directory.current.path;
    Hive
      ..init(path)
      ..registerAdapter(ContactModelAdapter());
    getIt.registerFactory<HiveInterface>(() => Hive);
  }
}
