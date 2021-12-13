import 'dart:convert';

import 'package:contactlistwithhive/data/models/common/search_filter_model.dart';
import 'package:contactlistwithhive/domain/entities/common/search_filter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final searchFilterModel = SearchFilterModel(name: "andriel test", number: "123456");

  test("should be a subclass SearchFilter entity", () {
    expect(searchFilterModel, isA<SearchFilter>());
  });

  test("should return a valid model", () {
    final Map<String, dynamic> jsonMap = json.decode(fixture("filter_search_model.json"));
    final result = SearchFilterModel.fromJson(jsonMap);
    expect(result, equals(searchFilterModel));
  });

  test("should return a json containing the proper data", () {
    final result = searchFilterModel.toJson();
    final expected = {"name": "andriel test", "number": "123456"};
    expect(result, equals(expected));
  });
}
