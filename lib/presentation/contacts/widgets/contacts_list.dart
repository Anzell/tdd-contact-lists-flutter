import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/presentation/contacts/controller/contact_controller_bloc.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  final List<Contact> contacts;
  final ContactControllerBloc controller;

  ContactsList({required this.contacts, required this.controller});

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    if (widget.contacts.length == 0) {
      return Text("Nenhum contato");
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.contacts.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          title: Text(widget.contacts[index].name),
          subtitle: Text(widget.contacts[index].number),
        ),
      ),
    );
  }
}
