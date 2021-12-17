import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/presentation/contacts/contact_form.dart';
import 'package:contactlistwithhive/presentation/contacts/controller/contact_controller_bloc.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  final List<Contact> contacts;
  final Function() onUpdateContact;
  final ContactControllerBloc controller;

  const ContactsList({
    required this.contacts,
    required this.controller,
    required this.onUpdateContact,
  });

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    if (widget.contacts.isEmpty) {
      return const Text("Nenhum contato");
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.contacts.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text(widget.contacts[index].name),
          subtitle: Text(widget.contacts[index].number),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ContactForm(
                updateContact: widget.onUpdateContact,
                contact: widget.contacts[index],
              ),
            ));
          },
          trailing: GestureDetector(
            child: const Icon(
              Icons.remove,
              color: Colors.red,
            ),
            onTap: () => _confirmDeleteContact(widget.contacts[index].id!),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDeleteContact(String id) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Excluir contato"),
        content: const Text("Deseja realmente excluir este contato?"),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Não")),
          TextButton(
            child: const Text("Sim"),
            onPressed: () {
              _dispatchDeleteContact(id);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  void _dispatchDeleteContact(String id) {
    widget.controller.add(RemoveContactBlocEvent(id: id));
  }
}
