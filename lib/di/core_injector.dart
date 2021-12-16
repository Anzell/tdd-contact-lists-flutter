import 'package:contactlistwithhive/core/converters/contact.dart';
import 'package:contactlistwithhive/core/helpers/string_helper.dart';
import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';

class CoreInjector {
  static Future<void> init() async {
    getIt.registerFactory<StringHelper>(() => StringHelperImpl(uidGenerateService: getIt()));
    getIt.registerFactory<ContactConverter>(() => ContactConverter());
  }
}
