import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:personeels_app/models/werknemer.dart';
import 'package:personeels_app/services/authentication_services.dart';
import 'package:personeels_app/services/platform_services.dart';

class WerknemersServices {
// Chrome, Edge, Windows, IOS
  static final String _baseApi = PlatformServices.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://127.0.0.1:8000/api';

  static Future<List<Werknemer>> getAll() async {
    // print('Start Werknemers GetAll Bearer ${AuthenticationServices.getBearerToken()}');

    final response = await http.get(
      Uri.parse('$_baseApi/werknemers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
    );

    if (response.statusCode != 200) {
      Exception('Fout bij ophalen werknemers ${response.statusCode}');
    }

    List<Werknemer> werknemers = [];
    final json = jsonDecode(response.body);
    // print('Json  Werknemers GetAll $json');

    for (int i = 0; i < json['data'].length; i++) {
      werknemers.add(Werknemer(
          id: json['data'][i]['id'],
          naam: json['data'][i]['naam'],
          functieId: json['data'][i]['functie_id'],
          telefoon: json['data'][i]['telefoon'],
          email: json['data'][i]['email'],
          sinds: json['data'][i]['sinds']));
    }
    AuthenticationServices.setBearerToken(json['access_token']);
    // print('Eind  Werknemers GetAll Bearer ${AuthenticationServices.getBearerToken()}');
    return werknemers;
  }

  static Future<List<Werknemer>> getAllByFunctie({
    required int functieId,
  }) async {
    // print('Start Werknemers getAllByFunctie Bearer ${AuthenticationServices.getBearerToken()}');

    final response = await http.get(
      Uri.parse('$_baseApi/functies/$functieId/werknemers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
    );

    if (response.statusCode != 200) {
      Exception(
          'Fout bij ophalen werknemers bij functie ${response.statusCode}');
    }

    List<Werknemer> werknemers = [];
    final json = jsonDecode(response.body);
    // print('Json  Werknemers getAllByFunctie $json');

    for (int i = 0; i < json['data'].length; i++) {
      werknemers.add(Werknemer(
          id: json['data'][i]['id'],
          naam: json['data'][i]['naam'],
          functieId: json['data'][i]['functie_id'],
          telefoon: json['data'][i]['telefoon'],
          email: json['data'][i]['email'],
          sinds: json['data'][i]['sinds']));
    }
    AuthenticationServices.setBearerToken(json['access_token']);

    // print('Eind  Werknemers getAllByFunctie Bearer ${AuthenticationServices.getBearerToken()}');
    return werknemers;
  }

  static Future<Werknemer> create({
    required String naam,
    required int functieId,
    required String telefoon,
    required String email,
    required String sinds,
  }) async {
    // print('Start Werknemers create Bearer '
    //     '${AuthenticationServices.getBearerToken()}');

    final response = await http.post(
      Uri.parse('$_baseApi/werknemers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
      body: jsonEncode({
        "naam": naam,
        "functie_id": functieId,
        "telefoon": telefoon,
        "email": email,
        "sinds": sinds
      }),
    );

    // print(response.statusCode);
    if (response.statusCode != 201) {
      Exception('Fout bij verwijderen werknemers ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    // print('Json  Werknemers create $json');
    final werknemer = Werknemer(
        id: json['data']['id'],
        naam: json['data']['naam'],
        functieId: json['data']['functie_id'],
        telefoon: json['data']['telefoon'],
        email: json['data']['email'],
        sinds: json['data']['sinds']);
    AuthenticationServices.setBearerToken(json['access_token']);
    // print('Eind  Werknemers create Bearer '
    //     '${AuthenticationServices.getBearerToken()}');
    return werknemer;
  }

  static Future<Werknemer> update({
    required int werknemerId,
    required String naam,
    required int functieId,
    required String telefoon,
    required String email,
    required String sinds,
  }) async {
    // print('Start Werknemers update Bearer '
    //     '${AuthenticationServices.getBearerToken()}');

    final response = await http.patch(
      Uri.parse('$_baseApi/werknemers/$werknemerId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
      body: jsonEncode({
        'id' : werknemerId,
        "naam": naam,
        "functie_id": functieId,
        "telefoon": telefoon,
        "email": email,
        "sinds": sinds
      }),
    );

    // print(response.statusCode);
    if (response.statusCode != 200) {
      Exception('Fout bij verwijderen werknemers ${response.statusCode}');
    }

    final json = jsonDecode(response.body);

    // print('Json  Werknemers update $json');
    final werknemer = Werknemer(
        // id: json['data']['id'],    NB: id is in laravel geen fillable
        id: werknemerId,
        naam: json['data']['naam'],
        functieId: json['data']['functie_id'],
        telefoon: json['data']['telefoon'],
        email: json['data']['email'],
        sinds: json['data']['sinds']);

    AuthenticationServices.setBearerToken(json['access_token']);
    // print('Eind  Werknemers update Bearer '
    //     '${AuthenticationServices.getBearerToken()}');
    return werknemer;
  }

  static Future<void> delete({
    required int werknemerId,
  }) async {
    // print('Start Werknemers delete Bearer ${AuthenticationServices.getBearerToken()}');

    final response = await http.delete(
      Uri.parse('$_baseApi/werknemers/$werknemerId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationServices.getBearerToken()}'
      },
    );

    // print(response.statusCode);
    if (response.statusCode != 202) {
      Exception('Fout bij verwijderen werknemers ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    // print('Json  Werknemers Delete $json');

    AuthenticationServices.setBearerToken(json['access_token']);
    // print('Eind  Werknemers GetAll Bearer ${AuthenticationServices.getBearerToken()}');
  }
}
