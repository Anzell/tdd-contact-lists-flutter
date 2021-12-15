import 'package:contactlistwithhive/core/converters/contact.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ContactConverter contactConverter;

  setUp(() {
    contactConverter = ContactConverter();
  });

  test("should return a valid Right(Contact) if parameters are valid", () {
    final String name = "andriel";
    final String number = "123456";
    final result = contactConverter.valueStringToContact(name: name, number: number);
    expect(result, equals(Right(Contact(name: name, number: number))));
  });

  test("should return Left(InvalidNameFailure) if name is not provided", () {
    final String name = "";
    final String number = "123456";
    final result = contactConverter.valueStringToContact(name: name, number: number);
    expect(result, equals(Left(InvalidNameInputFailure())));
  });

  test("should return Left(InvalidNumberFailure) if number is not provided", () {
    final String name = "andriel";
    final String number = "";
    final result = contactConverter.valueStringToContact(name: name, number: number);
    expect(result, equals(Left(InvalidNumberInputFailure())));
  });
}
