import 'package:flutter/material.dart';
import 'package:personeels_app/components/email_text_form_field.dart';
import 'package:personeels_app/components/naam_text_form_field.dart';
import 'package:personeels_app/components/sinds_text_form_field.dart';
import 'package:personeels_app/models/functie.dart';
import 'package:personeels_app/models/werknemer.dart';
import 'package:personeels_app/services/functies_services.dart';
import 'package:personeels_app/services/werknemers_services.dart';

class WerknemersUpdatePage extends StatefulWidget {
  final Werknemer werknemer;

  const WerknemersUpdatePage({
    Key? key,
    required this.werknemer,
  }) : super(key: key);

  @override
  State<WerknemersUpdatePage> createState() => _WerknemersUpdatePageState();
}

class _WerknemersUpdatePageState extends State<WerknemersUpdatePage> {
  Functie? _selectedFunctie;

  final _formKey = GlobalKey<FormState>();

  final _naamController = TextEditingController();
  final _telefoonController = TextEditingController();
  final _emailController = TextEditingController();
  final _sindsController = TextEditingController();

  void _refreshIndex(Functie selectedFunctie) {
    setState(() {
      // Werk combobox selected item bij
      _selectedFunctie = selectedFunctie;
    });
  }

  @override
  void initState() {
    _naamController.text = widget.werknemer.naam;
    _telefoonController.text = widget.werknemer.telefoon ?? 'Geen';
    _emailController.text = widget.werknemer.email;
    _sindsController.text = widget.werknemer.sinds ?? 'Al heel lang';
    super.initState();
  }

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
        title: const Text('Werknemers - Wijzigen}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Functie;  Combobox met functies
                Row(children: [_cmbFuncties()]),

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
                      child: const Text('Bewaren'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await WerknemersServices.update(
                              werknemerId: widget.werknemer.id,
                              naam: _naamController.text,
                              functieId: _selectedFunctie!.id,
                              telefoon: _telefoonController.text,
                              email: _emailController.text,
                              sinds: _sindsController.text);
                          // Check of de context nog beschikbaar is
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

  FutureBuilder<List<Functie>> _cmbFuncties() {
    return FutureBuilder<List<Functie>>(
      future: FunctieServices.getAll(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<Functie> functies = snapshot.data!;

        // zoek de functie van de medewerker en zet deze in _selectedFunctie
        // NB: Als er al een functie geselecteerd was, moet de waarde
        //     ongewijzigd blijven, omdat de gebruiker anders geen andere
        //     functie kan kiezen.
        _selectedFunctie ??= functies
              .firstWhere((element) => element.id == widget.werknemer.functieId);

        return DropdownButton<Functie>(
          value: _selectedFunctie,
          icon: const Icon(Icons.arrow_downward),
          underline: Container(height: 2, color: Colors.blue),
          onChanged: (Functie? value) {
            // This is called when the user selects an item.
            _refreshIndex(value!);
          },
          items: functies.map<DropdownMenuItem<Functie>>((Functie value) {
            return DropdownMenuItem<Functie>(
              value: value,
              child: Text(value.naam),
            );
          }).toList(),
        );
      },
    );
  }
}
