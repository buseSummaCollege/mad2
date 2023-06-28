import 'package:flutter/material.dart';
import 'package:personeels_app/components/email_text_form_field.dart';
import 'package:personeels_app/components/naam_text_form_field.dart';
import 'package:personeels_app/components/sinds_text_form_field.dart';
import 'package:personeels_app/models/functie.dart';
import 'package:personeels_app/services/werknemers_services.dart';

class WerknemersCreatePage extends StatefulWidget {
  final Functie functie;

  const WerknemersCreatePage({Key? key, required this.functie})
      : super(key: key);

  @override
  State<WerknemersCreatePage> createState() => _WerknemersCreatePageState();
}

class _WerknemersCreatePageState extends State<WerknemersCreatePage> {
  final _formKey = GlobalKey<FormState>();

  final _naamController = TextEditingController();
  final _telefoonController = TextEditingController();
  final _emailController = TextEditingController();
  final _sindsController = TextEditingController();

  @override
  void dispose() {
    _naamController.dispose();
    _telefoonController.dispose();
    _emailController.dispose();
    _sindsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Werknemers - Toevoegen - ${widget.functie.naam}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Functie
                Row(children: [
                  Text(
                    widget.functie.naam,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ]),

                //naam
                const SizedBox(height: 20),
                NaamTextFormField(controller: _naamController),

                // email
                const SizedBox(height: 20),
                EmailTextFormField(controller: _emailController),

                // sinds
                const SizedBox(height: 20),
                SindsTextFormField(controller: _sindsController),

                // Buttons Save en Cancel
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child : const  Text('Toevoegen'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await WerknemersServices.create(
                              naam: _naamController.text,
                              functieId: widget.functie.id,
                              telefoon: _telefoonController.text,
                              email: _emailController.text,
                              sinds: _sindsController.text);
                          if (context.mounted){
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Toevoegen'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await WerknemersServices.create(
                              naam: _naamController.text,
                              functieId: widget.functie.id,
                              telefoon: _telefoonController.text,
                              email: _emailController.text,
                              sinds: _sindsController.text);
                          if (context.mounted){
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      child: const Text('Annuleer'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}