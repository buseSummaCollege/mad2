import 'package:championsapp/models/champion.dart';
import 'package:championsapp/models/hobby.dart';
import 'package:championsapp/services/champion_service.dart';
import 'package:championsapp/services/hobby_service.dart';
import 'package:flutter/material.dart';

class ChampionsHobbiesPage extends StatefulWidget {
  const ChampionsHobbiesPage({Key? key, required this.champion}) : super(key: key);

  final Champion champion;

  @override
  State<ChampionsHobbiesPage> createState() => _ChampionsHobbiesPageState();
}

class _ChampionsHobbiesPageState extends State<ChampionsHobbiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Champion Hobbies')),
      body: Column(
        children: [
          // Champion Data
          Text('${widget.champion.naam} (${widget.champion.klas})'),

          // Hobbies
          Expanded(
            child: FutureBuilder<List<Hobby>>(
              future: HobbyService().getAll(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.hasData == false) {
                  return const CircularProgressIndicator();
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // print(widget.champion.hobbies!.contains(snapshot.data![index]));
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(snapshot.data![index].naam),
                        Checkbox(
                          value: widget.champion.hobbies!
                              .contains(snapshot.data![index]),
                          onChanged: (value) {
                            if (value == true) {
                              // 'Toevoegen van hobby;
                              ChampionService().addHobbyToChampion(
                                  widget.champion.id, snapshot.data![index].id);
                              widget.champion.hobbies!
                                  .add(snapshot.data![index]);
                            } else {
                              ChampionService().deleteHobbyFromChampion(
                                  widget.champion.id, snapshot.data![index].id);
                              Hobby hobby = widget.champion.hobbies!.firstWhere(
                                  (element) =>
                                      element.id == snapshot.data![index].id);
                              if (hobby != null) {
                                widget.champion.hobbies!.remove(hobby);
                              }
                            }
                            setState(() {});
                          },
                        )
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
