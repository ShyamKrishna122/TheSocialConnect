import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class UserAPI {
  final client = http.Client();
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": '*',
  };

  Future createProfile({
    required String? userEmail,
    required String name,
    required String bio,
    required String dp,
  }) async {
    final Uri uri = Uri.parse(USER_INFO_URL + "/add");
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "name": name,
          "userEmail": userEmail,
          "userDp": dp,
          "userBio": bio,
        }));
    final dynamic body = response.body;
    return body;
  }

  Future decodeUserData({
    required String token,
  }) async {
    final Uri uri = Uri.parse(AUTH_URL + "/verify");
    final http.Response response = await client.get(
      uri,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "Access-Control-Allow-Origin": '*',
        "Authorization": token,
      },
    );
    final body = response.body;
    return body;
  }
}
