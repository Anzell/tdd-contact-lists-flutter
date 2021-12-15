import 'package:contactlistwithhive/core/constants/error_messages.dart';
import 'package:contactlistwithhive/core/converters/contact.dart';
import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/usecases/contact/add_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_all_contacts.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_contacts_by_filter.dart';
import 'package:contactlistwithhive/domain/usecases/contact/remove_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/update_contact.dart';
import 'package:equatable/equatable.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_controller_bloc_events.dart';
part 'contact_controller_bloc_states.dart';

class ContactControllerBloc extends Bloc<ContactControllerBlocEvent, ContactControllerBlocState> {
  final AddContactUseCase addContactUseCase;
  final RemoveContactUseCase removeContactUseCase;
  final UpdateContactUseCase updateContactUseCase;
  final GetAllContactsUseCase getAllContactsUseCase;
  final GetContactsByFilterUseCase getContactsByFilterUseCase;
  final ContactConverter contactConverter;

  ContactControllerBloc({
    required this.addContactUseCase,
    required this.getAllContactsUseCase,
    required this.getContactsByFilterUseCase,
    required this.removeContactUseCase,
    required this.updateContactUseCase,
    required this.contactConverter,
  }) : super(Empty()) {
    on<ContactControllerBlocEvent>((event, emit) async {
      if (event is AddContactBlocEvent) {
        final contactResult = contactConverter.valueStringToContact(name: event.name, number: event.number);
        contactResult.fold((failure) => emit(Error(message: _mapFailureMessage(failure))), (contact) async {
          final addContactUseCaseResult = await addContactUseCase(AddContactUseCaseParams(contact: contact));
        });
      }
    });
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InvalidNameInputFailure:
        return ErrorMessages.invalidName;
      case InvalidNumberInputFailure:
        return ErrorMessages.invalidNumber;
      default:
        return ErrorMessages.unkowmnError;
    }
  }
}
