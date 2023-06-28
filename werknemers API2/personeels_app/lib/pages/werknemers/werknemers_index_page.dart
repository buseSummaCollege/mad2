import 'package:flutter/material.dart';
import 'package:personeels_app/models/functie.dart';
import 'package:personeels_app/models/werknemer.dart';
import 'package:personeels_app/pages/werknemers/werknemers_create_page.dart';
import 'package:personeels_app/pages/werknemers/werknemers_update_page.dart';
import 'package:personeels_app/services/functies_services.dart';
import 'package:personeels_app/services/werknemers_services.dart';

class WerknemersIndexPage extends StatefulWidget {
  const WerknemersIndexPage({Key? key, required this.setSignedIn})
      : super(key: key);

  final void Function(bool signedIn) setSignedIn;

  @override
  State<WerknemersIndexPage> createState() => _WerknemersIndexPageState();
}

class _WerknemersIndexPageState extends State<WerknemersIndexPage> {
  Future<List<Werknemer>>? _werknemers;
  Functie? _selectedFunctie;

  void _refreshIndex(Functie selectedFunctie) {
    setState(() {
      // Werk combobox selected item bij
      _selectedFunctie = selectedFunctie;
      // Werk list werknemersbij
      _werknemers =
          WerknemersServices.getAllByFunctie(functieId: _selectedFunctie!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(children: [
        DrawerHeader(
          child: Column(
            children: const [
              Icon(
                Icons.person,
                size: 40,
              ),
              Text('Werknemers App'),
            ],
          ),
        ),
        GestureDetector(
          child: Text('Over...'),
          onTap: () {
            showAboutDialog(
                context: context,
                applicationName: 'PersoneelsApp',
                applicationIcon: FlutterLogo(),
                applicationVersion: '1.0.0',
                children: [
                  Text('Over de PersoneelsApp'),
                ]);
          },
        )
      ])),
      appBar: AppBar(
        title: const Text('Werknemers Index'),
        actions: [_logout()],
      ),
      floatingActionButton: _btnCreateWerknemer(),
      body: Column(
        children: [
          // Combobox met functies
          _cmbFuncties(),
          // Lijst met werknemers
          const SizedBox(height: 20),
          Expanded(child: _lstWerknemers()),
        ],
      ),
    );
  }

  IconButton _logout() {
    return IconButton(
      onPressed: () {
        widget.setSignedIn(false);
      },
      icon: const Icon(Icons.logout),
    );
  }

  FloatingActionButton _btnCreateWerknemer() {
    return FloatingActionButton(
      onPressed: () async {
        Functie selectedFunctie = _selectedFunctie!;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WerknemersCreatePage(functie: selectedFunctie),
        ));
        _refreshIndex(selectedFunctie);
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }

  _btnUpdateWerknemer({required Werknemer werknemer}) {
    return IconButton(
      onPressed: () async {
        Functie selectedFunctie = _selectedFunctie!;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WerknemersUpdatePage(werknemer: werknemer),
        ));
        _refreshIndex(selectedFunctie);
      },
      icon: const Icon(
        Icons.edit,
        color: Colors.red,
      ),
    );
  }

  _btnDeleteWerknemer({required Werknemer werknemer}) {
    return IconButton(
      onPressed: ()  async {
         await WerknemersServices.delete(werknemerId: werknemer.id);
        _refreshIndex(_selectedFunctie!);
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
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

        return DropdownButton<Functie>(
          value: _selectedFunctie ?? functies.first,
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

  Widget _lstWerknemers() {
    return _werknemers == null
        ? const Center(child: CircularProgressIndicator())
        : FutureBuilder(
      future: _werknemers,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData == false) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data![index].naam),
              subtitle: Text(snapshot.data![index].email),
              leading:
              _btnUpdateWerknemer(werknemer: snapshot.data![index]),
              trailing:
              _btnDeleteWerknemer(werknemer: snapshot.data![index]),
            );
          },
        );
      },
          );
  }
}
