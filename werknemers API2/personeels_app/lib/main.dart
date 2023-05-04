import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personeels_app/pages/login_page.dart';
import 'package:personeels_app/pages/main_page.dart';

void main() {
  runApp(const PersoneelsApp());
}

class PersoneelsApp extends StatefulWidget {
  const PersoneelsApp({Key? key}) : super(key: key);

  @override
  State<PersoneelsApp> createState() => _PersoneelsAppState();
}

class _PersoneelsAppState extends State<PersoneelsApp> {
  bool _signedIn = false;

  void setSignedIn(bool signedIn) {
    setState(() {
      _signedIn = signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _signedIn
          ? MainPage(setSignedIn: setSignedIn)
          : LoginPage(setSignedIn: setSignedIn),
    );
  }
}
