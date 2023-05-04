import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:personeels_app/models/functie.dart';
import 'package:personeels_app/services/platform_services.dart';

class FunctieServices {
// Chrome, Edge, Windows, IOS
  static final String _baseApi = PlatformServices.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://127.0.0.1:8000/api';

  // api/register/
  static Future<List<Functie>> getAll() async {
    // print('Start Functies getAll Bearer ${AuthenticationServices.getBearerToken()}');

    final response = await http.get(Uri.parse('$_baseApi/functies'));

    if (response.statusCode != 200) {
      Exception('Fout bij ophalen functies ${response.statusCode}');
    }

    List<Functie> functies = [];
    final json = jsonDecode(response.body);
    // print('Json  Functies getAll $json');

    for (int i = 0; i < json['data'].length; i++) {
      functies.add(
          Functie(id: json['data'][i]['id'], naam: json['data'][i]['naam']));
    }
    // print('Eind  Functies getAll Bearer ${AuthenticationServices.getBearerToken()}');
    return functies;
  }
}
