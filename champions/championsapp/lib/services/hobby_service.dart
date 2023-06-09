import 'dart:convert';
import 'package:championsapp/models/champion.dart';
import 'package:championsapp/models/hobby.dart';
import 'package:http/http.dart' as http;

class HobbyService {
  Future<List<Hobby>> getAll() async {
    final response =
        await http.get(Uri.parse('https://flutapi.summaict.nl/api/hobbies'));
    final List<dynamic> jsonHobbies = jsonDecode(response.body);

    List<Hobby> hobbies =
        jsonHobbies.map((jsonHobby) => Hobby.fromJson(jsonHobby)).toList();

    if (response.statusCode != 200) {
      throw Exception(
          'Fout bij het ophalen van alle hobbies (${response.statusCode}).');
    }

    return hobbies;
  }

  Future<List<Hobby>> getAllWithChampions() async {
    List<Hobby> hobbies = [];

    final response =
        await http.get(Uri.parse('https://flutapi.summaict.nl/api/hobbies'));
    if (response.statusCode != 200) {
      throw Exception(
          'Fout bij het ophalen van alle hobbies (${response.statusCode}).');
    }

    final List<dynamic> jsonHobbies = jsonDecode(response.body);

    for (int i = 0; i < jsonHobbies.length; i++) {
      Map<String, dynamic> jsonHobby = jsonHobbies[i];

      final hobby = Hobby(
        id: jsonHobby['id'],
        naam: jsonHobby['naam'],
        champions: [],
      );

      List<dynamic> jsonChampions = jsonHobby['champions'];
      for (int j = 0; j < jsonChampions.length; j++) {
        Map<String, dynamic> jsonChampion = jsonChampions[j];

        hobby.champions!.add(
          Champion(
            id: jsonChampion['id'],
            naam: jsonChampion['naam'],
            klas: jsonChampion['klas'],
          ),
        );
      }

      hobbies.add(hobby);
    }
    return hobbies;
  }

  Future<Hobby> post(Hobby hobby) async {
    final response =
        await http.post(Uri.parse('https://flutapi.summaict.nl/api/hobbies'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'naam': hobby.naam,
            }));

    if (response.statusCode != 201) {
      throw Exception('Het is niet gelukt om de hobby toe te voegen');
    }

    final result = jsonDecode(response.body);
    return Hobby(id: result['id'], naam: result['naam']);
  }

  Future<Hobby> put(int id, Hobby hobby) async {
    final response =
        await http.put(Uri.parse('https://flutapi.summaict.nl/api/hobbies/$id'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'id': hobby.id,
              'naam': hobby.naam,
            }));

    if (response.statusCode != 200) {
      throw Exception('Het is niet gelukt om de hobby te wijzigen');
    }

    final result = jsonDecode(response.body);
    return Hobby(id: result['id'], naam: result['naam']);
  }

  Future<bool> delete(int hobbyId) async {
    final response = await http
        .delete(Uri.parse('https://flutapi.summaict.nl/api/hobbies/$hobbyId'));

    return response.statusCode == 200;
  }
}
