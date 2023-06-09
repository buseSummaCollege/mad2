import 'package:championsapp/models/champion.dart';
import 'package:championsapp/services/champion_service.dart';
import 'package:flutter/material.dart';

class ChampionsCreate extends StatefulWidget {
  const ChampionsCreate({Key? key}) : super(key: key);

  @override
  State<ChampionsCreate> createState() => _ChampionsCreateState();
}

class _ChampionsCreateState extends State<ChampionsCreate> {
  final _formKey = GlobalKey<FormState>();
  final _naamController = TextEditingController();
  final _klasController = TextEditingController();

  @override
  void dispose() {
    _naamController.dispose();
    _klasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Champions - Create')),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                // Naam
                TextFormField(
                  controller: _naamController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Naam',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vul naam in';
                    }
                    return null;
                  },
                ),

                // Klass
                TextFormField(
                  controller: _klasController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Klas',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vul klas in';
                    }
                    return null;
                  },
                ),

                // Save / Cancel
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() == false) {
                          ScaffoldMessenger.of(context).showSnackBar(

                            const SnackBar(content: Text('Verbeter de fouten'),
                            ),
                          );
                        }
                        var champion = Champion(id: 0,
                            naam: _naamController.text,
                            klas: _klasController.text);
                        champion = await ChampionService().post(champion);
                        if (context.mounted){
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Bewaren'),),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Annuleren'),),
                  ],
                )
              ],

            )

        )
    );
  }
}
