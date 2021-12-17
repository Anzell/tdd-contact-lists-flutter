import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:contactlistwithhive/domain/usecases/contact/add_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_all_contacts.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_contacts_by_filter.dart';
import 'package:contactlistwithhive/domain/usecases/contact/remove_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/update_contact.dart';

class UseCasesInjector implements Injector {
  @override
  Future<void> init() async {
    getIt.registerFactory<AddContactUseCase>(() => AddContactUseCase(repository: getIt()));
    getIt.registerFactory<RemoveContactUseCase>(() => RemoveContactUseCase(repository: getIt()));
    getIt.registerFactory<UpdateContactUseCase>(() => UpdateContactUseCase(repository: getIt()));
    getIt.registerFactory<GetAllContactsUseCase>(() => GetAllContactsUseCase(repository: getIt()));
    getIt.registerFactory<GetContactsByFilterUseCase>(() => GetContactsByFilterUseCase(repository: getIt()));
  }
}
