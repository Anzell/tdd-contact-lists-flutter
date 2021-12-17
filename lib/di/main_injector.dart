import 'package:contactlistwithhive/di/controllers_injector.dart';
import 'package:contactlistwithhive/di/core_injector.dart';
import 'package:contactlistwithhive/di/datasources_injector.dart';
import 'package:contactlistwithhive/di/external_services_injector.dart';
import 'package:contactlistwithhive/di/repositories_injector.dart';
import 'package:contactlistwithhive/di/usecases_injector.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

abstract class Injector {
  Future<void> init();
}

class MainInjector extends Injector {
  @override
  Future<void> init() async {
    await CoreInjector().init();
    await DatasourcesInjector().init();
    await RepositoriesInjector().init();
    await UseCasesInjector().init();
    await ControllersInjector().init();
    await ExternalServicesInjector().init();
  }
}
