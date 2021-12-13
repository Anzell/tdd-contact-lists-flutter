import 'package:contactlistwithhive/domain/entities/common/search_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should Equatable returning true for equal SearchFilter", () {
    final filter1 = SearchFilter(name: "andriel", number: "123456");
    final filter2 = SearchFilter(name: "andriel", number: "123456");
    expect(filter1, equals(filter2));
  });

  test("should Equatable returning false for diferent contact", () {
    final filter1 = SearchFilter(name: "andriel", number: "123456");
    final filter2 = SearchFilter(name: "another andriel", number: "123456");
    expect(filter1, isNot(equals(filter2)));
  });
}
