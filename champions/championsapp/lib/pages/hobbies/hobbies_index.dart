import 'package:championsapp/models/hobby.dart';
import 'package:championsapp/pages/hobbies/hobbies_create.dart';
import 'package:championsapp/pages/hobbies/hobbies_details.dart';
import 'package:championsapp/pages/hobbies/hobbies_edit.dart';
import 'package:championsapp/services/hobby_service.dart';
import 'package:flutter/material.dart';

class HobbiesIndex extends StatefulWidget {
  const HobbiesIndex({Key? key}) : super(key: key);

  @override
  State<HobbiesIndex> createState() => _HobbiesIndexState();
}

class _HobbiesIndexState extends State<HobbiesIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _hobbiesCreate(context),
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(title: Text('Hobbies - Index')),
      body: FutureBuilder<List<Hobby>>(
        future: HobbyService().getAllWithChampions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return _hobbiesIndex(snapshot.data!);
        },
      ),
    );
  }

  Widget _hobbiesCreate(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HobbiesCreate(),
        ));
        setState(() {});
      },
      child: Icon(Icons.add),
    );
    ;
  }

  Widget _hobbiesIndex(List<Hobby> hobbies) {
    return ListView.builder(
      itemCount: hobbies.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(5),
          color: Colors.brown.shade100,
          margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _hobbyDetails(context, hobbies[index]),
                  SizedBox(width: 10),
                  Expanded(child: Text(hobbies[index].naam)),
                  _hobbyEdit(context, hobbies[index]),
                  _hobbyDelete(context, hobbies[index].id),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _hobbyDetails(BuildContext context, Hobby hobby) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HobbiesDetails(hobby: hobby),
        ));
      },
      child: Icon(Icons.access_time),
    );
  }

  Widget _hobbyEdit(BuildContext context, Hobby hobby) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HobbiesEdit(hobby: hobby),
        ));
        setState(() {});
      },
      child: Icon(Icons.edit, color: Colors.green),
    );
  }

  Widget _hobbyDelete(BuildContext context, int id) {
    return GestureDetector(
      onTap: () async {
        bool gelukt = await HobbyService().delete(id);
        if (gelukt) {
          // refresh scherm
          setState(() {});
        } else {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Hobbies - Delete'),
                  content: const Text('Verwijderen is mislukt'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Ok'))
                  ],
                );
              },
            );
          }
        }
      },
      child: const Icon(
        Icons.delete_outline,
        color: Colors.red,
      ),
    );
  }
}
