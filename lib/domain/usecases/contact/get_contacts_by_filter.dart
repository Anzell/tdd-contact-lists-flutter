import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:contactlistwithhive/domain/usecases/usecase.dart';

class GetContactsByFilterUseCase implements UseCase<List<Contact>, GetContactsByFilterParams> {
  final ContactRepository repository;

  GetContactsByFilterUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Contact>>> call(GetContactsByFilterParams params) async {
    return await repository.getContactsByFilter(filter: params.filter);
  }
}

class GetContactsByFilterParams extends Equatable {
  final String filter;

  const GetContactsByFilterParams({required this.filter});

  @override
  List<Object?> get props => [filter];
}
