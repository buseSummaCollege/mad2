import 'package:flutter/material.dart';

class NaamTextFormField extends StatelessWidget {
  final TextEditingController controller;

  const NaamTextFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'naam',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vul naam in';
        }
        return null;
      },
    );
  }
}
