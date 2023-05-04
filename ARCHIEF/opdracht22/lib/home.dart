import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Verkrijg toegang'),
            bottom: const TabBar (
              tabs: [
                Tab( icon: Icon(Icons.login),),
                Tab( icon: Icon(Icons.app_registration),)
              ],
            ),
          ),
          body: const TabBarView(
              children: [
                loginPage(),
                registrationPage(),
              ]
          ),
        ),
      ),
    );
  }
}


class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}


class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Login'),);
  }
}


class registrationPage extends StatefulWidget {
  const registrationPage({Key? key}) : super(key: key);

  @override
  State<registrationPage> createState() => _registrationPageState();
}

class _registrationPageState extends State<registrationPage> {
  @override
  Widget build(BuildContext context) {
    return Container( child: Text('Registrtatie'),);
  }
}

// @override
// Widget build(BuildContext context) {
//   Widget _userId() {
//     return TextFormField(
//       validator: (value) {
//         if (value == null || value.isEmpty){
//           return ('vul userId in');
//         }
//       },
//     );
//   }
//   Widget _passWord() {
//     return TextFormField(
//       validator: (value) {
//         if (value == null || value.isEmpty){
//           return ('vul wachtwoord in');
//         }
//       },
//     );
//   }
//
//   Widget _userName() {
//     return TextFormField(
//       validator: (value) {
//         if (value == null || value.isEmpty){
//           return ('vul naam in');
//         }
//       },
//     );
//   }
//
//   Widget _commando(){
//     return Container(
//       margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//
//             },
//             child: Text('Login'),
//           )
//         ],
//       ),
//     );
//
//   }
//
//   return MaterialApp(
//     title: 'Wat is er',
//     theme: ThemeData.dark(useMaterial3: true),
//     home: Form (
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             children: [
//               _userId(),
//               _passWord(),
//               _userName(),
//             ],
//           ),
//           _commando()
//         ],
//       ),
//     ),
//   );
// }
