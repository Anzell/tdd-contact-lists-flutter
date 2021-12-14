import 'package:contactlistwithhive/data/models/common/search_filter_model.dart';
import 'package:contactlistwithhive/data/models/contact_model.dart';
import 'package:contactlistwithhive/domain/entities/common/search_filter.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';

abstract class ContactLocalDatasource {
  Future<void> addContact({required Contact newContact});
  Future<void> removeContact({required String contactId});
  Future<void> updateContact({required Contact contact});
  Future<List<ContactModel>> getAllContacts();
  Future<List<ContactModel>> getContactsByFilter({required SearchFilter filter});
}
