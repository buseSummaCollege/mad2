import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:opdracht22/home.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  // runApp(const homePage());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController berichtController = TextEditingController();
  String _message = '';

  late UserCredential _userCredential;
  late List<DataSnapshot> _berichten = [];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    berichtController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    String message = '';
    try {
      _userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      message = '';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        message = 'Ongeldig emailadres.';
      } else if (e.code == 'user-disabled') {
        message = 'Gebruiker heeft geen toegang.';
      } else {
        if (e.message != null) {
          message = e.message!;
        } else {
          _message = e.code;
        }
        print('xxx ${e.message}');
      }
    } catch (e) {
      message = e.toString();
      print('yyy');
    }
    print(message);
    setState(() {
      _message = message;
    });
  }

  Future<void> registreer() async {
    String message = '';
    try {
      _userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      message = '';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = e.code;
      }
    } catch (e) {
      message = e.toString();
    }
    setState(() {
      _message = message;
    });
  }

  Future<void> updateUser() async {
    await _userCredential.user?.updateDisplayName("Jane Q. User");
    await _userCredential.user
        ?.updatePhotoURL("https://example.com/jane-q-user/profile.jpg");
  }

  Future<void> storeIt() async {
    // maak een referentie naar de id van het element:
    // tabel : notities
    // notities van: uid
    // id van de notitie wordt met push() gegenereerd
    DatabaseReference tblRef = FirebaseDatabase.instance.ref('/notities'
        '/${_userCredential.user?.uid}');
    DatabaseReference itemRef = tblRef.push();
    await itemRef.set({
      "bericht": berichtController.text,
    });
  }

  void deleteIt(DataSnapshot ds){
    ds.ref.remove();
  }

  Future<void> updateIt(DataSnapshot ds) async {
    await ds.ref.update({
      "bericht": berichtController.text,
    });
  }

  void readIt() {
    final ref = FirebaseDatabase.instance
        .ref('/notities'
        '/${_userCredential.user?.uid}')
        .orderByChild('bericht');

    ref.onValue.listen((DatabaseEvent event) {
      List<DataSnapshot> berichten = [];
      for (final child in event.snapshot.children) {
        berichten.add(child);
      }
      setState(() {
        _berichten = berichten;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('geen gebruiker aangemeld');
      } else {
        print('gebruiker ${user.displayName} ${user.uid}');
      }
    });

    return MaterialApp(
      title: 'Firebase Workshop',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Workshop'),
        ),
        body: Column(
            children: [
              Expanded (
                flex: 2,
                // constraints: BoxConstraints(maxHeight: 300),
                child: ListView(
                  children: [
                    Text(_message),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.pinkAccent))),
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          labelText: 'password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.pinkAccent))),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: const Text('Login')),
                    ElevatedButton(
                        onPressed: () {
                          registreer();
                        },
                        child: const Text('Registreer')),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Text('Log uit')),
                    TextFormField(
                      controller: berichtController,
                      decoration: const InputDecoration(
                          labelText: 'Bericht',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.pinkAccent))),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          storeIt();
                        },
                        child: const Text('Store Some Data')),
                    ElevatedButton(
                        onPressed: () {
                          readIt();
                        },
                        child: const Text('Read Some Data')),

                  ],
                ),
              ),
              Expanded (
                flex: 1,
                child: ListView.builder(
                  itemCount: _berichten.length,
                  itemBuilder: (context, index) {
                    DataSnapshot ds = _berichten[index];
                    print(ds.key);
                    print((ds.value as Map<dynamic, dynamic>)['bericht']);
                    return
                      GestureDetector(
                        onDoubleTap: () {
                          deleteIt(ds);
                        },
                        onLongPressDown:(details) {
                          updateIt(ds);
                        },
                        child: Text("${ds.key} "
                            "${(ds.value as Map<dynamic, dynamic>)['bericht']} "
                        ),
                      );
                  },
                ),
              ),
            ]
        ),
      ),);
  }
}

