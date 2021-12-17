part of "contact_controller_bloc.dart";

abstract class ContactControllerBlocEvent extends Equatable {
  const ContactControllerBlocEvent();
}

class AddContactBlocEvent extends ContactControllerBlocEvent {
  final String name;
  final String number;

  const AddContactBlocEvent({
    required this.name,
    required this.number,
  });

  @override
  List<Object> get props => [name, number];
}

class RemoveContactBlocEvent extends ContactControllerBlocEvent {
  final String id;

  const RemoveContactBlocEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateContactBlocEvent extends ContactControllerBlocEvent {
  final String name;
  final String number;
  final String id;

  const UpdateContactBlocEvent({
    required this.name,
    required this.number,
    required this.id,
  });

  @override
  List<Object> get props => [name, number];
}

class GetAllContactsBlocEvent extends ContactControllerBlocEvent {
  @override
  List<Object> get props => [];
}

class GetContactByFilterBlocEvent extends ContactControllerBlocEvent {
  final String filter;

  const GetContactByFilterBlocEvent({required this.filter});

  @override
  List<Object> get props => [filter];
}
