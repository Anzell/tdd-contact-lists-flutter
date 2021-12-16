import 'package:bloc_test/bloc_test.dart';
import 'package:contactlistwithhive/core/constants/error_messages.dart';
import 'package:contactlistwithhive/core/converters/contact.dart';
import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/add_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_all_contacts.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_contacts_by_filter.dart';
import 'package:contactlistwithhive/domain/usecases/contact/remove_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/update_contact.dart';
import 'package:contactlistwithhive/domain/usecases/usecase.dart';
import 'package:contactlistwithhive/presentation/contacts/controller/contact_controller_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
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
  late MockAddContactUseCase mockAddContactUseCase;
  late MockRemoveContactUseCase mockRemoveContactUseCase;
  late MockUpdateContactUseCase mockUpdateContactUseCase;
  late MockGetAllContactsUseCase mockGetAllContactsUseCase;
  late MockGetContactsByFilterUseCase mockGetContactsByFilterUseCase;
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

  blocTest(
    "should emit [Error] when a UnkownFailure is returned by UseCase",
    build: () {
      final contact = Contact(name: "andriel", number: "123456");
      when(mockContactConverter.valueStringToContact(name: "andriel", number: "123456")).thenReturn(right(contact));
      when(mockAddContactUseCase(AddContactUseCaseParams(contact: contact)))
          .thenAnswer((_) async => left(UnkownFailure()));
      return bloc;
    },
    act: (ContactControllerBloc bloc) => bloc.add(AddContactBlocEvent(name: "andriel", number: "123456")),
    expect: () => [Error(message: ErrorMessages.unkowmnError)],
  );

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

    blocTest(
      "should Emit [Error] when call to AddContactUseCase returns left",
      build: () {
        when(mockContactConverter.valueStringToContact(name: name, number: number)).thenReturn(right(contact));
        when(mockAddContactUseCase(AddContactUseCaseParams(contact: contact)))
            .thenAnswer((_) async => left(ServerFailure()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(AddContactBlocEvent(name: name, number: number)),
      expect: () => [Error(message: ErrorMessages.serverError)],
    );

    blocTest(
      "should emit [Success] when call to AddContact returns sucessfull",
      build: () {
        when(mockContactConverter.valueStringToContact(name: name, number: number)).thenReturn(right(contact));
        when(mockAddContactUseCase(AddContactUseCaseParams(contact: contact))).thenAnswer((_) async => right(None()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(AddContactBlocEvent(name: name, number: number)),
      expect: () => [Success()],
    );
  });

  group("remove contact", () {
    final testId = "1";

    blocTest(
      "should emit [Error] when call to RemoveContact returns left",
      build: () {
        when(mockRemoveContactUseCase(RemoveContactUseCaseParams(contactId: testId)))
            .thenAnswer((_) async => left(ServerFailure()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(RemoveContactBlocEvent(id: testId)),
      expect: () => [Error(message: ErrorMessages.serverError)],
    );
    blocTest(
      "should emit [Success] when call to RemoveContact returns sucessfull",
      build: () {
        when(mockRemoveContactUseCase(RemoveContactUseCaseParams(contactId: testId)))
            .thenAnswer((_) async => right(None()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(RemoveContactBlocEvent(id: testId)),
      expect: () => [Success()],
    );
  });

  group("update contact", () {
    final name = "andriel";
    final number = "123456";
    final id = "1";
    final contact = Contact(name: "andriel", number: "123456", id: "1");

    test("should call ContactConverter and convert a name and number to a valid Contact", () async {
      when(mockContactConverter.valueStringToContact(name: name, number: number, id: id)).thenReturn(right(contact));
      when(mockUpdateContactUseCase(UpdateContactUseCaseParams(contact: contact)))
          .thenAnswer((_) async => right(None()));
      bloc.add(UpdateContactBlocEvent(name: name, number: number, id: id));
      await untilCalled(mockContactConverter.valueStringToContact(name: name, number: number, id: id));
      verify(mockContactConverter.valueStringToContact(name: name, number: number, id: id));
    });

    blocTest(
      "should emit [Error] when call to ContactConverter returns left (name input error)",
      build: () {
        when(mockContactConverter.valueStringToContact(name: name, number: number, id: id))
            .thenReturn(left(InvalidNameInputFailure()));
        when(mockUpdateContactUseCase(UpdateContactUseCaseParams(contact: contact)))
            .thenAnswer((_) async => right(None()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(UpdateContactBlocEvent(id: id, name: name, number: number)),
      expect: () => [Error(message: ErrorMessages.invalidName)],
    );

    blocTest(
      "should emit [Error] when call to UpdateContact returns left",
      build: () {
        when(mockContactConverter.valueStringToContact(name: name, number: number, id: id)).thenReturn(right(contact));
        when(mockUpdateContactUseCase(UpdateContactUseCaseParams(contact: contact)))
            .thenAnswer((_) async => left(ServerFailure()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(UpdateContactBlocEvent(name: name, number: number, id: id)),
      expect: () => [Error(message: ErrorMessages.serverError)],
    );
  });

  group("get all contacts", () {
    final List<Contact> testContactsList = [
      Contact(id: "123456", name: "test contact 1", number: "123456"),
      Contact(id: "123456", name: "test contact 2", number: "654321"),
    ];

    blocTest(
      "should emit a [Loaded] with a valid List<Contact> when GetAllContactsUseCase is called",
      build: () {
        when(mockGetAllContactsUseCase(any)).thenAnswer((_) async => right(testContactsList));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(GetAllContactsBlocEvent()),
      expect: () => [Loaded(contacts: testContactsList)],
    );

    blocTest(
      "should emit a [Error] when a call in GetAllContactsUseCase returns left(ServerFailure())",
      build: () {
        when(mockGetAllContactsUseCase(any)).thenAnswer((_) async => left(ServerFailure()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(GetAllContactsBlocEvent()),
      expect: () => [Error(message: ErrorMessages.serverError)],
    );
  });

  group("get contacts by filter", () {
    final List<Contact> testContactsList = [
      Contact(id: "123456", name: "test contact 1", number: "123456"),
      Contact(id: "123456", name: "test contact 2", number: "654321"),
    ];
    final filter = "test contact";

    blocTest(
      "should emit a [Loaded] with List<Contact> when a call in GetContactsByFilterUseCase is sucessfull",
      build: () {
        when(mockGetContactsByFilterUseCase(any)).thenAnswer((_) async => right(testContactsList));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(GetContactByFilterBlocEvent(filter: filter)),
      expect: () => [Loaded(contacts: testContactsList)],
    );

    blocTest(
      "should emit a [Error] when a call in GetContactsByFilterUseCase returns left(ServerFailure())",
      build: () {
        when(mockGetContactsByFilterUseCase(any)).thenAnswer((_) async => left(ServerFailure()));
        return bloc;
      },
      act: (ContactControllerBloc bloc) => bloc.add(GetContactByFilterBlocEvent(filter: filter)),
      expect: () => [Error(message: ErrorMessages.serverError)],
    );
  });
}
