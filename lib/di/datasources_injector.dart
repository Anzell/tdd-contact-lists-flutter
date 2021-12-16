import 'package:contactlistwithhive/data/datasources/local/contact_local_datasource.dart';
import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:uuid/uuid.dart';

class DatasourcesInjector {
  static Future<void> init() async {
    getIt.registerFactory<ContactLocalDatasource>(
      () => ContactLocalDatasourceImpl(hive: getIt(), stringHelper: getIt()),
    );
    getIt.registerFactory<Uuid>(() => Uuid());
  }
}
