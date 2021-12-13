import 'package:contactlistwithhive/data/datasources/local/contact_local_datasource.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/domain/entities/common/search_filter.dart';
import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactLocalDatasource contactDatasource;

  ContactRepositoryImpl({required this.contactDatasource});

  @override
  Future<Either<Failure, None>> addContact({required Contact newContact}) {
    // TODO: implement addContact
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Contact>>> getAllContacts() {
    // TODO: implement getAllContacts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Contact>>> getContactsByFilter({required SearchFilter filter}) {
    // TODO: implement getContactsByFilter
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, None>> removeContact({required String contactId}) {
    // TODO: implement removeContact
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, None>> updateContact({required Contact contact}) {
    // TODO: implement updateContact
    throw UnimplementedError();
  }
}
