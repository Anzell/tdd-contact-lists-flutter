import 'package:contactlistwithhive/core/errors/exceptions.dart';
import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/data/datasources/local/contact_local_datasource.dart';
import 'package:contactlistwithhive/data/models/contact_model.dart';
import 'package:contactlistwithhive/data/repositories/contact_repository_impl.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'contact_repository_impl_test.mocks.dart';

@GenerateMocks([ContactLocalDatasource])
void main() {
  late MockContactLocalDatasource mockContactLocalDatasource;
  late ContactRepository contactRepository;

  setUp(() {
    mockContactLocalDatasource = MockContactLocalDatasource();
    contactRepository = ContactRepositoryImpl(contactDatasource: mockContactLocalDatasource);
  });

  group("add contact", () {
    final contactModel = ContactModel(name: "andriel test", number: "123456");

    test("should return None when the call to datasource is sucessful", () async {
      when(mockContactLocalDatasource.addContact(newContact: contactModel)).thenAnswer((_) async => const None());
      final result = await contactRepository.addContact(newContact: contactModel);
      expect(result, equals(const Right(None())));
      verify(mockContactLocalDatasource.addContact(newContact: contactModel)).called(1);
    });

    test("should return Left(ServerFailure()) when call to datasource throws a ServerException", () async {
      when(mockContactLocalDatasource.addContact(newContact: contactModel)).thenThrow(ServerException());
      final result = await contactRepository.addContact(newContact: contactModel);
      expect(result, equals(Left(ServerFailure())));
      verify(mockContactLocalDatasource.addContact(newContact: contactModel)).called(1);
    });

    test("should return Left(UnkownFailure()) when call to datasource throws a non handle Exception", () async {
      when(mockContactLocalDatasource.addContact(newContact: contactModel)).thenThrow(Exception());
      final result = await contactRepository.addContact(newContact: contactModel);
      expect(result, equals(Left(UnkownFailure())));
      verify(mockContactLocalDatasource.addContact(newContact: contactModel)).called(1);
    });
  });

  group("get all contacts", () {
    final List<ContactModel> listContacts = [
      ContactModel(id: "123456", name: "test contact 1", number: "123456"),
      ContactModel(id: "123456", name: "test contact 2", number: "654321"),
    ];
    test("should return a valid List<Contact> when the call to datasource is sucessful", () async {
      when(mockContactLocalDatasource.getAllContacts()).thenAnswer((_) async => listContacts);
      final result = await contactRepository.getAllContacts();
      expect(result, equals(Right(listContacts)));
      verify(mockContactLocalDatasource.getAllContacts()).called(1);
    });

    test("should return a Left(ServerFailure()) when the call to datasource throws a ServerException", () async {
      when(mockContactLocalDatasource.getAllContacts()).thenThrow(ServerException());
      final result = await contactRepository.getAllContacts();
      expect(result, equals(Left(ServerFailure())));
      verify(mockContactLocalDatasource.getAllContacts()).called(1);
    });

    test("should return Left(UnkownFailure()) when call to datasource throws a non handle Exception", () async {
      when(mockContactLocalDatasource.getAllContacts()).thenThrow(Exception());
      final result = await contactRepository.getAllContacts();
      expect(result, equals(Left(UnkownFailure())));
      verify(mockContactLocalDatasource.getAllContacts()).called(1);
    });
  });

  group("get list contacts by filter", () {
    final String filter = "test contact";
    final List<ContactModel> listContacts = [
      ContactModel(id: "123456", name: "test contact 1", number: "123456"),
      ContactModel(id: "123456", name: "test contact 2", number: "654321"),
    ];
    test("should return a valid List<Contact> when the call to datasource is sucessful", () async {
      when(mockContactLocalDatasource.getContactsByFilter(filter: filter)).thenAnswer((_) async => listContacts);
      final result = await contactRepository.getContactsByFilter(filter: filter);
      expect(result, equals(Right(listContacts)));
      verify(mockContactLocalDatasource.getContactsByFilter(filter: filter)).called(1);
    });

    test("should return a Left(ServerFailure()) when the call to datasource throws a ServerException", () async {
      when(mockContactLocalDatasource.getContactsByFilter(filter: filter)).thenThrow(ServerException());
      final result = await contactRepository.getContactsByFilter(filter: filter);
      expect(result, equals(Left(ServerFailure())));
      verify(mockContactLocalDatasource.getContactsByFilter(filter: filter)).called(1);
    });

    test("should return Left(UnkownFailure()) when call to datasource throws a non handle Exception", () async {
      when(mockContactLocalDatasource.getContactsByFilter(filter: filter)).thenThrow(Exception());
      final result = await contactRepository.getContactsByFilter(filter: filter);
      expect(result, equals(Left(UnkownFailure())));
      verify(mockContactLocalDatasource.getContactsByFilter(filter: filter)).called(1);
    });
  });

  group("remove contact by id", () {
    final String id = "101";
    test("should return a Right(None()) when the call to datasource is sucessful", () async {
      when(mockContactLocalDatasource.removeContact(contactId: id)).thenAnswer((_) async => 0);
      final result = await contactRepository.removeContact(contactId: id);
      expect(result, equals(Right(None())));
      verify(mockContactLocalDatasource.removeContact(contactId: id)).called(1);
    });

    test("should return a Left(ServerFailure()) when the call to datasource throws a ServerException", () async {
      when(mockContactLocalDatasource.removeContact(contactId: id)).thenThrow(ServerException());
      final result = await contactRepository.removeContact(contactId: id);
      expect(result, equals(Left(ServerFailure())));
      verify(mockContactLocalDatasource.removeContact(contactId: id)).called(1);
    });

    test("should return Left(UnkownFailure()) when call to datasource throws a non handle Exception", () async {
      when(mockContactLocalDatasource.removeContact(contactId: id)).thenThrow(Exception());
      final result = await contactRepository.removeContact(contactId: id);
      expect(result, equals(Left(UnkownFailure())));
      verify(mockContactLocalDatasource.removeContact(contactId: id)).called(1);
    });

    test("should return Left(NotFoundFailure()) when call to datasource not find the provided id", () async {
      when(mockContactLocalDatasource.removeContact(contactId: id)).thenThrow(NotFoundException());
      final result = await contactRepository.removeContact(contactId: id);
      expect(result, equals(Left(NotFoundFailure())));
      verify(mockContactLocalDatasource.removeContact(contactId: id)).called(1);
    });
  });

  group("update contact", () {
    final Contact contactUpdated = Contact(id: "123", name: "andriel test", number: "123456");
    test("should return a Right(None()) when the call to datasource is sucessful", () async {
      when(mockContactLocalDatasource.updateContact(contact: contactUpdated)).thenAnswer((_) async => 0);
      final result = await contactRepository.updateContact(contact: contactUpdated);
      expect(result, equals(Right(None())));
      verify(mockContactLocalDatasource.updateContact(contact: contactUpdated)).called(1);
    });

    test("should return a Left(ServerFailure()) when the call to datasource throws a ServerException", () async {
      when(mockContactLocalDatasource.updateContact(contact: contactUpdated)).thenThrow(ServerException());
      final result = await contactRepository.updateContact(contact: contactUpdated);
      expect(result, equals(Left(ServerFailure())));
      verify(mockContactLocalDatasource.updateContact(contact: contactUpdated)).called(1);
    });

    test("should return Left(UnkownFailure()) when call to datasource throws a non handle Exception", () async {
      when(mockContactLocalDatasource.updateContact(contact: contactUpdated)).thenThrow(Exception());
      final result = await contactRepository.updateContact(contact: contactUpdated);
      expect(result, equals(Left(UnkownFailure())));
      verify(mockContactLocalDatasource.updateContact(contact: contactUpdated)).called(1);
    });

    test("should return Left(NotFoundFailure()) when call to datasource not find the provided id", () async {
      when(mockContactLocalDatasource.updateContact(contact: contactUpdated)).thenThrow(NotFoundException());
      final result = await contactRepository.updateContact(contact: contactUpdated);
      expect(result, equals(Left(NotFoundFailure())));
      verify(mockContactLocalDatasource.updateContact(contact: contactUpdated)).called(1);
    });
  });
}
