import 'package:contactlistwithhive/core/errors/exceptions.dart';
import 'package:contactlistwithhive/data/datasources/local/contact_local_datasource.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactLocalDatasource contactDatasource;

  ContactRepositoryImpl({required this.contactDatasource});

  @override
  Future<Either<Failure, None>> addContact({required Contact newContact}) async {
    try {
      await contactDatasource.addContact(newContact: newContact);
      return Right(None());
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getAllContacts() async {
    try {
      final result = await contactDatasource.getAllContacts();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getContactsByFilter({required String filter}) async {
    try {
      final result = await contactDatasource.getContactsByFilter(filter: filter);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, None>> removeContact({required String contactId}) async {
    try {
      await contactDatasource.removeContact(contactId: contactId);
      return Right(None());
    } on ServerException {
      return Left(ServerFailure());
    } on NotFoundException {
      return Left(NotFoundFailure());
    } catch (e) {
      return Left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, None>> updateContact({required Contact contact}) async {
    try {
      await contactDatasource.updateContact(contact: contact);
      return Right(None());
    } on ServerException {
      return Left(ServerFailure());
    } on NotFoundException {
      return Left(NotFoundFailure());
    } catch (e) {
      return Left(UnkownFailure());
    }
  }
}
