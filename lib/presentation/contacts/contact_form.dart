import 'dart:async';

import 'package:contactlistwithhive/di/main_injector.dart';
import 'package:contactlistwithhive/domain/entities/contact.dart';
import 'package:contactlistwithhive/presentation/contacts/controller/contact_controller_bloc.dart';
import 'package:contactlistwithhive/presentation/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactForm extends StatefulWidget {
  final Function() updateContact;
  final Contact? contact;

  const ContactForm({this.contact, required this.updateContact});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late StreamSubscription stream;
  final ContactControllerBloc controller = getIt<ContactControllerBloc>();
  late final TextEditingController nameController;
  late final TextEditingController numberController;

  @override
  void initState() {
    super.initState();
    _initController();
    stream = controller.stream.listen((event) {
      if (event is Success) {
        widget.updateContact();
        Navigator.of(context).pop();
      }
    });
  }

  void _initController() {
    nameController = TextEditingController(text: widget.contact?.name ?? "");
    numberController = TextEditingController(text: widget.contact?.number ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitleAppBar()),
      ),
      body: BlocProvider(
        create: (_) => controller,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Nome",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: numberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Número",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<ContactControllerBloc, ContactControllerBlocState>(builder: (context, state) {
                List<Widget> returnWidgets = [
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: widget.contact == null ? _dispatchAddContact : _dispatchUpdateContact,
                      child: Text(_getButtonLabel()),
                    ),
                  )
                ];
                if (state is Loading) {
                  returnWidgets = [LoadingWidget()];
                }
                if (state is Error) {
                  returnWidgets.add(Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ));
                }
                return Column(children: returnWidgets);
              }),
            ],
          )),
        ),
      ),
    );
  }

  void _dispatchAddContact() {
    controller.add(AddContactBlocEvent(
      name: nameController.text,
      number: numberController.text,
    ));
  }

  void _dispatchUpdateContact() {
    controller.add(
      UpdateContactBlocEvent(
        name: nameController.text,
        number: numberController.text,
        id: widget.contact!.id!,
      ),
    );
  }

  String _getButtonLabel() {
    if (widget.contact == null) {
      return "Cadastrar";
    }
    return "Salvar";
  }

  String _getTitleAppBar() {
    if (widget.contact == null) {
      return "Adicionar novo contato";
    }
    return widget.contact!.name;
  }
}
