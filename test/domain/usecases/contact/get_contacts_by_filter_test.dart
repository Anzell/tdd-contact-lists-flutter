import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/common/search_filter.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_contacts_by_filter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_contacts_by_filter_test.mocks.dart';

@GenerateMocks([ContactRepository])
void main() {
  late ContactRepository mockContactRepository;
  late GetContactsByFilterUseCase usecase;

  setUp(() {
    mockContactRepository = MockContactRepository();
    usecase = GetContactsByFilterUseCase(repository: mockContactRepository);
  });

  final filterTest = SearchFilter(name: "test new contact", number: "123456");
  final List<Contact> testContactsList = [
    Contact(id: "123456", name: "test contact 1", number: "123456"),
    Contact(id: "123456", name: "test contact 2", number: "654321"),
  ];

  test("should return Right(List<Contact>) if sucessful return contacts by filter", () async {
    when(mockContactRepository.getContactsByFilter(filter: filterTest))
        .thenAnswer((_) async => Right(testContactsList));
    final result = await usecase(GetContactsByFilterParams(filter: filterTest));
    expect(result, equals(Right(testContactsList)));
    verify(mockContactRepository.getContactsByFilter(filter: filterTest));
  });

  test("should return Left(ServerFailure()) if a error ocurred in repository", () async {
    when(mockContactRepository.getContactsByFilter(filter: filterTest)).thenAnswer((_) async => Left(ServerFailure()));
    final result = await usecase(GetContactsByFilterParams(filter: filterTest));
    expect(result, equals(Left(ServerFailure())));
    verify(mockContactRepository.getContactsByFilter(filter: filterTest));
  });

  test("should Equatable working for GetContactByFilterUseCaseParams", () {
    final params1 = GetContactsByFilterParams(filter: filterTest);
    final params2 = GetContactsByFilterParams(filter: filterTest);
    expect(params1, equals(params2));
  });
}
