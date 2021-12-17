import 'package:contactlistwithhive/presentation/contacts/controller/contact_controller_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ContactControllerBlocEvent event;

  group("test Equatable", () {
    test("should Equatable working in AddContactBlocEvent", () {
      event = AddContactBlocEvent(name: "test name", number: "123");
      expect(event, equals(AddContactBlocEvent(name: "test name", number: "123")));
    });

    test("should Equatable working in RemoveContactBlocEvent", () {
      event = RemoveContactBlocEvent(id: "testId");
      expect(event, equals(RemoveContactBlocEvent(id: "testId")));
    });
    test("should Equatable working in UpdateContactBlocEvent", () {
      event = UpdateContactBlocEvent(id: "testId", name: "name", number: "number");
      expect(event, equals(UpdateContactBlocEvent(id: "testId", name: "name", number: "number")));
    });

    test("should Equatable working in GetAllContactsBlocEvent", () {
      event = GetAllContactsBlocEvent();
      expect(event, equals(GetAllContactsBlocEvent()));
    });

    test("should Equatable working in GetContactsByFilterBlocEvent", () {
      event = GetContactByFilterBlocEvent(filter: "driel");
      expect(event, equals(GetContactByFilterBlocEvent(filter: "driel")));
    });
  });
}
