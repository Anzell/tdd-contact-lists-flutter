import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/common/search_filter.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:dartz/dartz.dart';

abstract class ContactRepository {
  Future<Either<Failure, None>> addContact({required Contact newContact});
  Future<Either<Failure, None>> removeContact({required String contactId});
  Future<Either<Failure, None>> updateContact({required Contact contact});
  Future<Either<Failure, List<Contact>>> getAllContacts();
  Future<Either<Failure, List<Contact>>> getContactsByFilter({required SearchFilter filter});
}
