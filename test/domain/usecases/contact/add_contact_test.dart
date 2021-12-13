import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/contact/add_contact.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'add_contact_test.mocks.dart';

@GenerateMocks([ContactRepository])
void main() {
  late ContactRepository mockContactRepository;
  late AddContactUseCase usecase;

  setUp(() {
    mockContactRepository = MockContactRepository();
    usecase = AddContactUseCase(repository: mockContactRepository);
  });

  final contactTest = Contact(name: "test new contact", number: "123456");

  test("should return Right(None()) if sucessful add contact", () async {
    when(mockContactRepository.addContact(newContact: contactTest)).thenAnswer((_) async => const Right(None()));
    final result = await usecase(AddContactUseCaseParams(contact: contactTest));
    expect(result, equals(const Right(None())));
    verify(mockContactRepository.addContact(newContact: contactTest));
  });

  test("should return Left(ServerFailure()) if a error ocurred in repository", () async {
    when(mockContactRepository.addContact(newContact: contactTest)).thenAnswer((_) async => Left(ServerFailure()));
    final result = await usecase(AddContactUseCaseParams(contact: contactTest));
    expect(result, equals(Left(ServerFailure())));
    verify(mockContactRepository.addContact(newContact: contactTest));
  });

  test("should Equatable working for AddContactUseCaseParams", () {
    final contactTest = Contact(name: "test", number: "123456");
    final params1 = AddContactUseCaseParams(contact: contactTest);
    final params2 = AddContactUseCaseParams(contact: contactTest);
    expect(params1, equals(params2));
  });
}
