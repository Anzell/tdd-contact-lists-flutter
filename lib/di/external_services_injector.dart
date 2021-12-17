import 'dart:io';

import 'package:contactlistwithhive/data/models/contact_model.dart';
import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ExternalServicesInjector implements Injector {
  @override
  Future<void> init() async {
    //Permissions
    if (await Permission.storage.isGranted == false) {
      await Permission.storage.request();
    }

    //Path_provider
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    var directory = await Directory(appDocDirectory.path + '/' + 'dir').create(recursive: true);

    //Hive
    Hive
      ..init(directory.path)
      ..registerAdapter(ContactModelAdapter());
    getIt.registerFactory<HiveInterface>(() => Hive);
  }
}
