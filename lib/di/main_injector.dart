import 'package:contactlistwithhive/di/controllers_injector.dart';
import 'package:contactlistwithhive/di/core_injector.dart';
import 'package:contactlistwithhive/di/datasources_injector.dart';
import 'package:contactlistwithhive/di/external_services_injector.dart';
import 'package:contactlistwithhive/di/repositories_injector.dart';
import 'package:contactlistwithhive/di/usecases_injector.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class Injector {
  static Future<void> init() async {
    await Future.wait([
      ExternalServicesInjector.init(),
      CoreInjector.init(),
      DatasourcesInjector.init(),
      RepositoriesInjector.init(),
      UseCasesInjector.init(),
      ControllersInjector.init(),
    ]);
  }
}
