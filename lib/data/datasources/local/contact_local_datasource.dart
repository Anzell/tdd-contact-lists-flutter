import 'package:contactlistwithhive/core/constants/hive_boxes.dart';
import 'package:contactlistwithhive/core/errors/exceptions.dart';
import 'package:contactlistwithhive/core/helpers/string_helper.dart';
import 'package:contactlistwithhive/data/mappers/contact_mapper.dart';
import 'package:hive/hive.dart';

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

class ContactLocalDatasourceImpl implements ContactLocalDatasource {
  final HiveInterface hive;
  final StringHelper stringHelper;

  ContactLocalDatasourceImpl({required this.hive, required this.stringHelper});

  @override
  Future<void> addContact({required Contact newContact}) async {
    final uuid = stringHelper.generateUniqueId;
    final box = await hive.openBox(HiveBoxes.contacts);
    await box.put(uuid, {"id": uuid, ...ContactMapper.entityToModel(newContact).toJson()});
  }

  @override
  Future<List<ContactModel>> getAllContacts() async {
    final box = await hive.openBox(HiveBoxes.contacts);
    final contactsMap = box.toMap();
    List<ContactModel> contactsModel = [];
    contactsMap.forEach((key, value) {
      contactsModel.add(ContactModel.fromJson(value));
    });
    return contactsModel;
  }

  @override
  Future<List<ContactModel>> getContactsByFilter({required SearchFilter filter}) {
    // TODO: implement getContactsByFilter
    throw UnimplementedError();
  }

  @override
  Future<void> removeContact({required String contactId}) async {
    final box = await hive.openBox(HiveBoxes.contacts);
    final contacts = box.toMap();
    bool foundId = false;
    contacts.forEach((key, value) {
      if (key == contactId) {
        foundId = true;
        box.delete(key);
      }
    });
    if (!foundId) {
      throw NotFoundException();
    }
  }

  @override
  Future<void> updateContact({required Contact contact}) {
    // TODO: implement updateContact
    throw UnimplementedError();
  }
}
