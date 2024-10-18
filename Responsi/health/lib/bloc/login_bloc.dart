import 'dart:convert';
import 'package:health/helpers/api.dart';
import 'package:health/helpers/api_url.dart';
import 'package:health/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};

    // Debugging: Cetak URL dan body
    print("URL: $apiUrl");
    print("Body: $body");

    var response = await Api().post(apiUrl, body);
    
    // Pastikan response status code
    print("Response status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return Login.fromJson(jsonObj);
    } else {
      throw Exception("Failed to load login data");
    }
  }
}

