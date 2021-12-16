import 'package:contactlistwithhive/data/repositories/contact_repository_impl.dart';
import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';

class RepositoriesInjector {
  static Future<void> init() async {
    getIt.registerFactory<ContactRepository>(() => ContactRepositoryImpl(contactDatasource: getIt()));
  }
}
