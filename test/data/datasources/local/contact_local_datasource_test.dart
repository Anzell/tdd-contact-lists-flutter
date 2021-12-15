import 'dart:convert';

import 'package:contactlistwithhive/core/constants/hive_boxes.dart';
import 'package:contactlistwithhive/core/errors/exceptions.dart';
import 'package:contactlistwithhive/core/helpers/string_helper.dart';
import 'package:contactlistwithhive/data/datasources/local/contact_local_datasource.dart';
import 'package:contactlistwithhive/data/models/contact_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:hive/hive.dart';

import '../../../fixtures/fixture_reader.dart';
import 'contact_local_datasource_test.mocks.dart';

@GenerateMocks([HiveInterface, Box, StringHelper])
void main() {
  late HiveInterface mockHive;
  late Box mockHiveBox;
  late ContactLocalDatasource datasource;
  late StringHelper mockStringHelper;

  setUp(() {
    mockHive = MockHiveInterface();
    mockHiveBox = MockBox();
    mockStringHelper = MockStringHelper();
    datasource = ContactLocalDatasourceImpl(hive: mockHive, stringHelper: mockStringHelper);
  });

  group("add contact", () {
    final contactModel = ContactModel(name: "andriel test", number: "123456");
    final testUuid = "123";

    test("should register a new contact", () async {
      when(mockHive.openBox("contacts")).thenAnswer((_) async => mockHiveBox);
      when(mockStringHelper.generateUniqueId).thenReturn(testUuid);
      when(mockHiveBox.put(testUuid, any)).thenAnswer((_) async => 1);
      await datasource.addContact(newContact: contactModel);
      verify(mockStringHelper.generateUniqueId).called(1);
      verify(mockHive.openBox("contacts")).called(1);
      verify(mockHiveBox.put(testUuid, any)).called(1);
    });
  });

  group("remove contact", () {
    final testId = "1";
    final Map<dynamic, dynamic> contactsList = json.decode(fixture("contacts.json"));

    test("should remove a contact by provided id", () async {
      when(mockHive.openBox(HiveBoxes.contacts)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.delete(any)).thenAnswer((_) async => 1);
      when(mockHiveBox.toMap()).thenReturn(contactsList);
      await datasource.removeContact(contactId: testId);
      verify(mockHive.openBox(HiveBoxes.contacts)).called(1);
      verify(mockHiveBox.delete(any)).called(1);
    });

    test("should throw a NotFoundException when the provided id is not valid", () async {
      when(mockHive.openBox(HiveBoxes.contacts)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.delete(any)).thenAnswer((_) async => 1);
      when(mockHiveBox.toMap()).thenReturn(contactsList);
      final result = datasource.removeContact(contactId: "not valid id");
      expect(() => result, throwsA(isA<NotFoundException>()));
      verify(mockHive.openBox(HiveBoxes.contacts)).called(1);
      verifyNever(mockHiveBox.delete(any));
    });
  });

  group("get all contacts", () {
    final Map<dynamic, dynamic> contacts = json.decode(fixture("contacts.json"));
    final List<ContactModel> listContactModel = [
      ContactModel(id: "1", name: "andriel", number: "123"),
      ContactModel(id: "2", name: "pedro", number: "321"),
      ContactModel(id: "3", name: "fernando", number: "456"),
    ];

    test("should return a valid List<ContactModel>", () async {
      when(mockHive.openBox(HiveBoxes.contacts)).thenAnswer((_) async => mockHiveBox);
      when(mockHiveBox.toMap()).thenReturn(contacts);
      final result = await datasource.getAllContacts();
      expect(result, equals(listContactModel));
    });
  });
}
