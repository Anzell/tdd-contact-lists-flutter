part of "contact_controller_bloc.dart";

abstract class ContactControllerBlocEvent extends Equatable {
  const ContactControllerBlocEvent();

  @override
  List<Object> get props => [];
}

class AddContactBlocEvent extends ContactControllerBlocEvent {
  final String name;
  final String number;

  AddContactBlocEvent({
    required this.name,
    required this.number,
  });

  @override
  List<Object> get props => [name, number];
}

class RemoveContactBlocEvent extends ContactControllerBlocEvent {
  final String id;

  RemoveContactBlocEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateContactBlocEvent extends ContactControllerBlocEvent {
  final String name;
  final String number;

  UpdateContactBlocEvent({
    required this.name,
    required this.number,
  });

  @override
  List<Object> get props => [name, number];
}

class GetAllContactsBlocEvent extends ContactControllerBlocEvent {}

class GetContactByFilterBlocEvent extends ContactControllerBlocEvent {
  final String filter;

  GetContactByFilterBlocEvent({required this.filter});

  @override
  List<Object> get props => [filter];
}
