import 'package:contactlistwithhive/domain/entities/contact.dart';
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
      appBar: AppBar(title: Text("Contatos")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactForm(updateContact: _updateContact)),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (_) => controller,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Seus contatos:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                BlocBuilder<ContactControllerBloc, ContactControllerBlocState>(builder: (context, state) {
                  switch (state.runtimeType) {
                    case Empty:
                      return Container(child: Text("Nenhum contato"));
                    case Loading:
                      return LoadingWidget();
                    case Success:
                      _dispatchGetAllContactsEvent();
                      return SizedBox();
                    case Loaded:
                      return ContactsList(contacts: (state as Loaded).contacts, controller: controller);
                    case Error:
                      print((state as Error).message);
                      return Text((state as Error).message);
                    default:
                      return Container(child: Text("Estado inválido da aplicação"));
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
