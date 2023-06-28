import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:personeels_app/services/platform_services.dart';

class AuthenticationServices {
  // Chrome, Edge, Windows, IOS
  static final String _baseApi = PlatformServices.isAndroid
      ? 'http://10.0.2.2:8000/api'
      : 'http://127.0.0.1:8000/api';

  static String _bearerToken = '';
  static int _userId = 0;

  static String getBearerToken() {
    return _bearerToken;
  }

  static void setBearerToken(String bearerToken) {
    _bearerToken = bearerToken;
  }

  // api/register/
  static Future<bool> register(
      String email, String password, String name) async {
    final response = await http.post(
      Uri.parse('$_baseApi/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password
      }),
    );

    return response.statusCode == 200;
  }

  // api/login/
  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseApi/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final result = jsonDecode(response.body);
      _bearerToken = result['access_token'];
      _userId = result['user']['id'];
      print(_userId);
    }

    return response.statusCode == 200;
  }

  // api/logout/
  static Future<bool> logout() async {
    final response = await http.post(
      Uri.parse('$_baseApi/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_bearerToken'
      },
    );

    return response.statusCode == 200;
  }
}
