import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class AuthenticationAPI {
  final client = http.Client();
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": '*',
  };
  //!creating new account
  Future createAccount({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    final Uri uri = Uri.parse(AUTH_URL + "/signUp");
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "userName": userName,
          "userEmail": userEmail,
          "userPassword": userPassword,
        }));
    final dynamic body = response.body;
    return body;
  }

  //!Login user
  Future loginUser({
    required String userEmail,
    required String userPassword,
  }) async {
    final Uri uri = Uri.parse(AUTH_URL + "/login");
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "userEmail": userEmail,
          "userPassword": userPassword,
        }));
    final dynamic body = response.body;
    return body;
  }
}
