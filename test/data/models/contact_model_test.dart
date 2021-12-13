import 'dart:convert';

import 'package:contactlistwithhive/data/models/contact_model.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final contactModel = ContactModel(name: "andriel test", number: "123456", id: "101");

  test("should be a subclass Contact entity", () {
    expect(contactModel, isA<Contact>());
  });

  test("should return a valid model", () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("contact_model.json"));
    final result = ContactModel.fromJson(jsonMap);
    expect(result, equals(contactModel));
  });

  test("should return a json containing the proper data", () {
    final result = contactModel.toJson();
    final expected = {"name": "andriel test", "id": "101", "number": "123456"};
    expect(result, equals(expected));
  });
}
