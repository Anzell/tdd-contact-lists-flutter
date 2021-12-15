import 'package:contactlistwithhive/domain/usecases/contact/add_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_all_contacts.dart';
import 'package:contactlistwithhive/domain/usecases/contact/get_contacts_by_filter.dart';
import 'package:contactlistwithhive/domain/usecases/contact/remove_contact.dart';
import 'package:contactlistwithhive/domain/usecases/contact/update_contact.dart';
import 'package:equatable/equatable.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_controller_bloc_events.dart';
part 'contact_controller_bloc_states.dart';

class ContactControllerBloc extends Bloc<ContactControllerBlocEvent, ContactControllerBlocState> {
  final AddContactUseCase addContactUseCase;
  final RemoveContactUseCase removeContactUseCase;
  final UpdateContactUseCase updateContactUseCase;
  final GetAllContactsUseCase getAllContactsUseCase;
  final GetContactsByFilterUseCase getContactsByFilterUseCase;

  ContactControllerBloc({
    required this.addContactUseCase,
    required this.getAllContactsUseCase,
    required this.getContactsByFilterUseCase,
    required this.removeContactUseCase,
    required this.updateContactUseCase,
  }) : super(Empty()) {
    on<ContactControllerBlocEvent>((event, emit) async {});
  }
}
