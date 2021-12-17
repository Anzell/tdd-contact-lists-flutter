import 'package:contactlistwithhive/presentation/contacts/contact_form.dart';
import 'package:contactlistwithhive/presentation/contacts/controller/contact_controller_bloc.dart';
import 'package:contactlistwithhive/presentation/contacts/widgets/contacts_list.dart';
import 'package:contactlistwithhive/presentation/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/main_injector.dart';

class ContactsScreen extends StatefulWidget {
  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final ContactControllerBloc controller = getIt<ContactControllerBloc>();

  @override
  Widget build(BuildContext context) {
    _dispatchGetAllContactsEvent();
    return Scaffold(
      appBar: AppBar(title: const Text("Contatos")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactForm(updateContact: _updateContact)),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (_) => controller,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Seus contatos:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                BlocBuilder<ContactControllerBloc, ContactControllerBlocState>(builder: (context, state) {
                  switch (state.runtimeType) {
                    case Empty:
                      return const Text("Nenhum contato");
                    case Loading:
                      return LoadingWidget();
                    case Success:
                      _dispatchGetAllContactsEvent();
                      return const SizedBox();
                    case Loaded:
                      return ContactsList(
                        contacts: (state as Loaded).contacts,
                        controller: controller,
                        onUpdateContact: _updateContact,
                      );
                    case Error:
                      return Text((state as Error).message);
                    default:
                      return const Text("Estado inválido da aplicação");
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _dispatchGetAllContactsEvent() {
    controller.add(GetAllContactsBlocEvent());
  }

  void _updateContact() {
    controller.add(GetAllContactsBlocEvent());
  }
}
