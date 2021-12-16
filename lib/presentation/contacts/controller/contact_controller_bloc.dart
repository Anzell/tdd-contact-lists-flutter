import 'dart:async';

import 'package:contactlistwithhive/core/constants/error_messages.dart';
import 'package:contactlistwithhive/core/converters/contact.dart';
import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/usecases/contact/add_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_all_contacts.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_contacts_by_filter.dart';
import 'package:contactlistwithhive/domain/usecases/contact/remove_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/update_contact.dart';
import 'package:contactlistwithhive/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
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
        contactResult.fold((failure) async => emit(Error(message: _mapFailureMessage(failure))), (contact) async {
          emit(Loading());
          final addContactUseCaseResult = await addContactUseCase(AddContactUseCaseParams(contact: contact));
          _foldErrorOrEmitSuccess(addContactUseCaseResult);
        });
      }

      if (event is RemoveContactBlocEvent) {
        emit(Loading());
        final removeContactResult = await removeContactUseCase(RemoveContactUseCaseParams(contactId: event.id));
        _foldErrorOrEmitSuccess(removeContactResult);
      }

      if (event is UpdateContactBlocEvent) {
        emit(Loading());
        final contactResult =
            contactConverter.valueStringToContact(name: event.name, number: event.number, id: event.id);
        contactResult.fold((failure) => emit(Error(message: _mapFailureMessage(failure))), (contact) async {
          final updateContactResult = await updateContactUseCase(UpdateContactUseCaseParams(contact: contact));
          _foldErrorOrEmitSuccess(updateContactResult);
        });
      }

      if (event is GetAllContactsBlocEvent) {
        emit(Loading());
        final getContactsResult = await getAllContactsUseCase(NoParams());
        _foldErrorOrEmitLoaded(getContactsResult);
      }

      if (event is GetContactByFilterBlocEvent) {
        emit(Loading());
        final getContactsResult = await getContactsByFilterUseCase(GetContactsByFilterParams(filter: event.filter));
        _foldErrorOrEmitLoaded(getContactsResult);
      }
    });
  }

  void _foldErrorOrEmitLoaded(Either<Failure, List<Contact>> eitherResult) {
    eitherResult.fold(
      (failure) => emit(Error(message: _mapFailureMessage(failure))),
      (contacts) => emit(Loaded(contacts: contacts)),
    );
  }

  void _foldErrorOrEmitSuccess(Either<Failure, None> eitherResult) {
    eitherResult.fold(
      (failure) => emit(Error(message: _mapFailureMessage(failure))),
      (_) => emit(Success()),
    );
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InvalidNameInputFailure:
        return ErrorMessages.invalidName;
      case InvalidNumberInputFailure:
        return ErrorMessages.invalidNumber;
      case ServerFailure:
        return ErrorMessages.serverError;
      default:
        return ErrorMessages.unkowmnError;
    }
  }
}
