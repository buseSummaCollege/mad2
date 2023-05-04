import 'package:flutter/material.dart';

class SindsTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const SindsTextFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Datum sinds',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vul datum sinds in';
        }
        if (value.length != 10) {
          return 'Vul een geldige datum in JJJJ-MM-DD';
        }
        try {
          var parsedDate = DateTime.parse(value);
        }
        // on FormatException catch (formatError) {
        on FormatException {
          return 'Vul een geldige datum in JJJJ-MM-DD';
        }
        return null;
      },
    );
  }
}
