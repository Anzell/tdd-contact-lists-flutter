import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:contactlistwithhive/presentation/contacts/controller/contact_controller_bloc.dart';

class ControllersInjector {
  static Future<void> init() async {
    getIt.registerFactory<ContactControllerBloc>(() => ContactControllerBloc(
          addContactUseCase: getIt(),
          getAllContactsUseCase: getIt(),
          getContactsByFilterUseCase: getIt(),
          removeContactUseCase: getIt(),
          updateContactUseCase: getIt(),
          contactConverter: getIt(),
        ));
  }
}
