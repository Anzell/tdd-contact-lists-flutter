import 'package:contactlistwithhive/domain/entities/contact.dart';

class ContactModel extends Contact {
  const ContactModel({
    String? id,
    required String name,
    required String number,
  }) : super(
          name: name,
          number: number,
          id: id,
        );

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(name: json['name'].toString(), number: json['number'].toString(), id: json['id'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "number": number,
      "id": id,
    };
  }
}
