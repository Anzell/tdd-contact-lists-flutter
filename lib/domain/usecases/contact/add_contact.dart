import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddContactUseCase implements UseCase<None, AddContactUseCaseParams> {
  final ContactRepository repository;

  AddContactUseCase({required this.repository});

  @override
  Future<Either<Failure, None>> call(AddContactUseCaseParams params) async {
    return await repository.addContact(newContact: params.contact);
  }
}

class AddContactUseCaseParams extends Equatable {
  final Contact contact;

  const AddContactUseCaseParams({required this.contact});

  @override
  List<Object> get props => [contact];
}
