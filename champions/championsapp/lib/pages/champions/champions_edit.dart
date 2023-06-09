import 'package:championsapp/models/champion.dart';
import 'package:championsapp/services/champion_service.dart';
import 'package:flutter/material.dart';

class ChampionsEdit extends StatefulWidget {
  const ChampionsEdit({Key? key, required this.champion}) : super(key: key);
  final Champion champion;

  @override
  State<ChampionsEdit> createState() => _ChampionsEditState();
}

class _ChampionsEditState extends State<ChampionsEdit> {
  final _formKey = GlobalKey<FormState>();
  final _naamController = TextEditingController();
  final _klasController = TextEditingController();

  @override
  void initState() {
    _naamController.text = widget.champion.naam;
    _klasController.text = widget.champion.klas;
    super.initState();
  }

  @override
  void dispose() {
    _naamController.dispose();
    _klasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Champions - Edit')),
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
                            const SnackBar(content: Text('Verbeter de fouten')),
                          );
                        }
                        var champion = Champion(
                            id: widget.champion.id,
                            naam: _naamController.text,
                            klas: _klasController.text);
                        champion = await ChampionService()
                            .put(widget.champion.id, champion);
                        if (context.mounted){
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Bewaren'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Annuleren'),
                    ),
                  ],
                )
              ],
            )));
  }
}
