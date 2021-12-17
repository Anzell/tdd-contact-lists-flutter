import 'dart:async';

import 'package:flutter/material.dart';

class FilterSearch extends StatelessWidget {
  final Function(String value) updateFilter;

  FilterSearch({required this.updateFilter});

  String lastFilteredString = "";

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _registerTimerToDispatch();
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "Buscar...",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _registerTimerToDispatch() {
    Timer.periodic(const Duration(seconds: 2), (_) {
      if (lastFilteredString != controller.text) {
        updateFilter(controller.text);
        lastFilteredString = controller.text;
      }
    });
  }
}
