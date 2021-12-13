import 'package:dartz/dartz.dart';

import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/usecase.dart';

class GetAllContactsUseCase implements UseCase<List<Contact>, NoParams> {
  final ContactRepository repository;

  GetAllContactsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Contact>>> call(NoParams params) async {
    return await repository.getAllContacts();
  }
}
