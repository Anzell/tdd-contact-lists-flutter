part of "contact_controller_bloc.dart";

abstract class ContactControllerBlocState extends Equatable {
  const ContactControllerBlocState();

  @override
  List<Object> get props => [];
}

class Empty extends ContactControllerBlocState {}

class Loading extends ContactControllerBlocState {}

class Success extends ContactControllerBlocState {}

class Loaded extends ContactControllerBlocState {
  final List<Contact> contacts;

  const Loaded({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

class Error extends ContactControllerBlocState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
