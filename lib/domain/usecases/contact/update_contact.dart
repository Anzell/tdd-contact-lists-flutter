import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class UpdateContactUseCase implements UseCase<None, UpdateContactUseCaseParams> {
  final ContactRepository repository;

  UpdateContactUseCase({required this.repository});

  @override
  Future<Either<Failure, None>> call(UpdateContactUseCaseParams params) async {
    return await repository.updateContact(contact: params.contact);
  }
}

class UpdateContactUseCaseParams extends Equatable {
  final Contact contact;

  const UpdateContactUseCaseParams({required this.contact});

  @override
  List<Object> get props => [contact];
}
