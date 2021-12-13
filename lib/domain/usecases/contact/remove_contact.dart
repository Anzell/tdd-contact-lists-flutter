import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RemoveContactUseCase implements UseCase<None, RemoveContactUseCaseParams> {
  final ContactRepository repository;

  RemoveContactUseCase({required this.repository});

  @override
  Future<Either<Failure, None>> call(RemoveContactUseCaseParams params) async {
    return await repository.removeContact(contactId: params.contactId);
  }
}

class RemoveContactUseCaseParams extends Equatable {
  final String contactId;

  const RemoveContactUseCaseParams({required this.contactId});

  @override
  List<Object> get props => [contactId];
}
