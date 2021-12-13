import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should Equatable returning true for equal contact", () {
    final contact1 = Contact(id: "testId", name: "andriel", number: "123456");
    final contact2 = Contact(id: "testId", name: "andriel", number: "123456");
    expect(contact1, equals(contact2));
  });

  test("should Equatable returning false for diferent contact", () {
    final contact1 = Contact(id: "testId", name: "andriel", number: "123456");
    final contact2 = Contact(id: "anotherTestId", name: "andriel", number: "123456");
    expect(contact1, isNot(equals(contact2)));
  });
}
