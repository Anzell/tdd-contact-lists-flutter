import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_all_contacts.dart';
import 'package:contactlistwithhive/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_contacts_test.mocks.dart';

@GenerateMocks([ContactRepository])
void main() {
  late ContactRepository mockContactRepository;
  late GetAllContactsUseCase usecase;

  setUp(() {
    mockContactRepository = MockContactRepository();
    usecase = GetAllContactsUseCase(repository: mockContactRepository);
  });

  final List<Contact> testContactsList = [
    Contact(id: "123456", name: "test contact 1", number: "123456"),
    Contact(id: "123456", name: "test contact 2", number: "654321"),
  ];

  test("should return Right(List<Contact>) if sucessful return a list of all contacts", () async {
    when(mockContactRepository.getAllContacts()).thenAnswer((_) async => Right(testContactsList));
    final result = await usecase(NoParams());
    expect(result, equals(Right(testContactsList)));
    verify(mockContactRepository.getAllContacts());
  });

  test("should return Left(ServerFailure()) if a error ocurred in repository", () async {
    when(mockContactRepository.getAllContacts()).thenAnswer((_) async => Left(ServerFailure()));
    final result = await usecase(NoParams());
    expect(result, equals(Left(ServerFailure())));
    verify(mockContactRepository.getAllContacts());
  });
}
