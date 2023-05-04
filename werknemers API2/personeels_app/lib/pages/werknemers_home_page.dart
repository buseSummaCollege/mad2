import 'package:flutter/material.dart';

class WerknemersHomePage extends StatelessWidget {
  const WerknemersHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'lib/assets/employees.jpg',
          ),
          fit: BoxFit.fill
        ),
      ),
    );
  }
}
