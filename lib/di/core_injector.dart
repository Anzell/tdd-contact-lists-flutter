import 'package:contactlistwithhive/core/converters/contact.dart';
import 'package:contactlistwithhive/core/helpers/permissions_helper.dart';
import 'package:contactlistwithhive/core/helpers/string_helper.dart';
import 'package:contactlistwithhive/di/main_injector.dart';

class CoreInjector implements Injector {
  @override
  Future<void> init() async {
    getIt.registerFactory<StringHelper>(() => StringHelperImpl(uidGenerateService: getIt()));
    getIt.registerFactory<ContactConverter>(() => ContactConverter());
    getIt.registerFactory<PermissionHelper>(() => PermissionsHelperImpl());
  }
}
