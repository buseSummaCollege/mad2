import 'package:championsapp/models/hobby.dart';
import 'package:flutter/material.dart';

class HobbiesDetails extends StatelessWidget {
  const HobbiesDetails({Key? key, required this.hobby}) : super(key: key);
  final Hobby hobby;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hobbies - Details')),
      body: Column(
        children: [
          Text('Hobby: ${hobby.naam}'),
          const SizedBox(height: 10),
          const Divider(thickness: 3),
          hobby.champions == null || hobby.champions!.isEmpty
              ? const Text('Geen beoefenaars voor deze hobby')
              : Expanded(
                  child: ListView.separated(
                    itemCount: hobby.champions!.length,
                    itemBuilder: (context, index) {
                      return Text(hobby.champions![index].naam);
                    },
                    separatorBuilder: (context, index) {
                      if (index.isEven) {
                        return const Divider(color: Colors.green);
                      } else {
                        return const Divider(color: Colors.red);
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
