import 'package:contactlistwithhive/core/errors/failures.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:dartz/dartz.dart';

class ContactConverter {
  Either<Failure, Contact> valueStringToContact({required String name, required String number, String? id}) {
    final numberFormatted = number.replaceAll(" ", "").replaceAll("(", "").replaceAll(")", "").replaceAll("-", "");
    if (name == "") {
      return left(InvalidNameInputFailure());
    }
    if (number == "" || int.tryParse(numberFormatted) == null) {
      return left(InvalidNumberInputFailure());
    }
    return right(Contact(name: name, number: numberFormatted, id: id));
  }
}

class InvalidNameInputFailure extends Failure {}

class InvalidNumberInputFailure extends Failure {}
