import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/contact/remove_contact.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'remove_contact_test.mocks.dart';

@GenerateMocks([ContactRepository])
void main() {
  late ContactRepository mockContactRepository;
  late RemoveContactUseCase usecase;

  setUp(() {
    mockContactRepository = MockContactRepository();
    usecase = RemoveContactUseCase(repository: mockContactRepository);
  });

  final testId = "123456";

  test("should return Right(None()) if sucessful remove contact", () async {
    when(mockContactRepository.removeContact(contactId: testId)).thenAnswer((_) async => const Right(None()));
    final result = await usecase(RemoveContactUseCaseParams(contactId: testId));
    expect(result, equals(const Right(None())));
    verify(mockContactRepository.removeContact(contactId: testId));
  });

  test("should return Left(ServerFailure()) if a error ocurred in repository", () async {
    when(mockContactRepository.removeContact(contactId: testId)).thenAnswer((_) async => Left(ServerFailure()));
    final result = await usecase(RemoveContactUseCaseParams(contactId: testId));
    expect(result, equals(Left(ServerFailure())));
    verify(mockContactRepository.removeContact(contactId: testId));
  });

  test("should Equatable working for RemoveContactUseCaseParams", () {
    final testParams1 = RemoveContactUseCaseParams(contactId: testId);
    final testParams2 = RemoveContactUseCaseParams(contactId: testId);
    expect(testParams1, equals(testParams2));
  });
}
