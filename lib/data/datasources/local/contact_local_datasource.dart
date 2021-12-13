import 'package:contactlistwithhive/data/models/common/search_filter_model.dart';
import 'package:contactlistwithhive/data/models/contact_model.dart';

abstract class ContactLocalDatasource {
  Future<void> addContact({required ContactModel newContact});
  Future<void> removeContact({required String contactId});
  Future<void> updateContact({required ContactModel contact});
  Future<ContactModel> getAllContacts();
  Future<ContactModel> getContactsByFilter({required SearchFilterModel filter});
}
