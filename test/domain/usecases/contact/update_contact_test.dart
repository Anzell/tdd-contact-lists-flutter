import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/contact/update_contact.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'add_contact_test.mocks.dart';

@GenerateMocks([ContactRepository])
void main() {
  late ContactRepository mockContactRepository;
  late UpdateContactUseCase usecase;

  setUp(() {
    mockContactRepository = MockContactRepository();
    usecase = UpdateContactUseCase(repository: mockContactRepository);
  });

  final contactTest = Contact(id: "test Id", name: "test update contact", number: "123456");

  test("should return Right(None()) if sucessful update contact", () async {
    when(mockContactRepository.updateContact(contact: contactTest)).thenAnswer((_) async => const Right(None()));
    final result = await usecase(UpdateContactUseCaseParams(contact: contactTest));
    expect(result, equals(const Right(None())));
    verify(mockContactRepository.updateContact(contact: contactTest));
  });

  test("should return Left(ServerFailure()) if a error ocurred in repository", () async {
    when(mockContactRepository.updateContact(contact: contactTest)).thenAnswer((_) async => Left(ServerFailure()));
    final result = await usecase(UpdateContactUseCaseParams(contact: contactTest));
    expect(result, equals(Left(ServerFailure())));
    verify(mockContactRepository.updateContact(contact: contactTest));
  });

  test("should Equatable working for UpdateContactUseCaseParams", () {
    final contactTest = Contact(name: "test", number: "123456");
    final params1 = UpdateContactUseCaseParams(contact: contactTest);
    final params2 = UpdateContactUseCaseParams(contact: contactTest);
    expect(params1, equals(params2));
  });
}
