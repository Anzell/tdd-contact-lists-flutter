import 'package:bloc_test/bloc_test.dart';
import 'package:contactlistwithhive/core/constants/error_messages.dart';
import 'package:contactlistwithhive/core/converters/contact.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/add_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_all_contacts.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_contacts_by_filter.dart';
import 'package:contactlistwithhive/domain/usecases/contact/remove_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/update_contact.dart';
import 'package:contactlistwithhive/presentation/contacts/controller/contact_controller_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'contact_controller_bloc_test.mocks.dart';

@GenerateMocks([
  AddContactUseCase,
  RemoveContactUseCase,
  UpdateContactUseCase,
  GetAllContactsUseCase,
  GetContactsByFilterUseCase,
  ContactConverter,
])
void main() {
  late AddContactUseCase mockAddContactUseCase;
  late RemoveContactUseCase mockRemoveContactUseCase;
  late UpdateContactUseCase mockUpdateContactUseCase;
  late GetAllContactsUseCase mockGetAllContactsUseCase;
  late GetContactsByFilterUseCase mockGetContactsByFilterUseCase;
  late MockContactConverter mockContactConverter;
  late ContactControllerBloc bloc;

  setUp(() {
    mockAddContactUseCase = MockAddContactUseCase();
    mockRemoveContactUseCase = MockRemoveContactUseCase();
    mockUpdateContactUseCase = MockUpdateContactUseCase();
    mockGetAllContactsUseCase = MockGetAllContactsUseCase();
    mockGetContactsByFilterUseCase = MockGetContactsByFilterUseCase();
    mockContactConverter = MockContactConverter();
    bloc = ContactControllerBloc(
      addContactUseCase: mockAddContactUseCase,
      getAllContactsUseCase: mockGetAllContactsUseCase,
      getContactsByFilterUseCase: mockGetContactsByFilterUseCase,
      removeContactUseCase: mockRemoveContactUseCase,
      updateContactUseCase: mockUpdateContactUseCase,
      contactConverter: mockContactConverter,
    );
  });

  test("inicial state should be Empty", () {
    expect(bloc.state, equals(Empty()));
  });

  group("add contact", () {
    final contact = Contact(name: "andriel", number: "123456");
    final String name = "andriel";
    final String number = "123456";

    test("should call ContactConverter and convert a name and number to a valid Contact", () async {
      when(mockContactConverter.valueStringToContact(name: name, number: number)).thenReturn(right(contact));
      when(mockAddContactUseCase(AddContactUseCaseParams(contact: contact))).thenAnswer((_) async => right(None()));
      bloc.add(AddContactBlocEvent(name: name, number: number));
      await untilCalled(mockContactConverter.valueStringToContact(name: name, number: number));
      verify(mockContactConverter.valueStringToContact(name: name, number: number));
    });

    blocTest(
      "should emit [Error] when call to ContactConverter returns left (name input error)",
      build: () {
        when(mockContactConverter.valueStringToContact(name: name, number: number))
            .thenReturn(left(InvalidNameInputFailure()));
        when(mockAddContactUseCase(AddContactUseCaseParams(contact: contact))).thenAnswer((_) async => right(None()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(AddContactBlocEvent(name: name, number: number)),
      expect: () => [Error(message: ErrorMessages.invalidName)],
    );

    blocTest(
      "should emit [Error] when call to ContactConverter returns left (number input error)",
      build: () {
        when(mockContactConverter.valueStringToContact(name: name, number: number))
            .thenReturn(left(InvalidNumberInputFailure()));
        when(mockAddContactUseCase(AddContactUseCaseParams(contact: contact))).thenAnswer((_) async => right(None()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(AddContactBlocEvent(name: name, number: number)),
      expect: () => [Error(message: ErrorMessages.invalidNumber)],
    );
  });
}
