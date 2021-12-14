import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:hive/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 1)
class ContactModel extends Contact {
  @override
  @HiveField(0)
  final String name;

  @override
  @HiveField(1)
  final String number;

  @override
  @HiveField(2)
  final String? id;

  @override
  const ContactModel({
    this.id,
    required this.name,
    required this.number,
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
