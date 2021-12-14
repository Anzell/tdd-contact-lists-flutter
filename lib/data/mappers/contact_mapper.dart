import 'package:contactlistwithhive/data/models/contact_model.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';

class ContactMapper {
  static Contact modelToEntity(ContactModel model) {
    return Contact(
      id: model.id,
      name: model.name,
      number: model.number,
    );
  }

  static ContactModel entityToModel(Contact entity) {
    return ContactModel(
      id: entity.id,
      name: entity.name,
      number: entity.number,
    );
  }
}
