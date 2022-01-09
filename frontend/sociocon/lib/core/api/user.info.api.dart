import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class UserInfoAPI {
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

  Future updateProfile({
    required String userEmail,
    required String name,
    required String userDp,
    required String userBio,
  }) async {
    final Uri uri = Uri.parse(USER_INFO_URL + "/update/$userEmail");
    final http.Response response = await client.put(uri,
        headers: headers,
        body: jsonEncode({
          "name": name,
          "userDp": userDp,
          "userBio": userBio,
        }));
    final dynamic body = response.body;
    return body;
  }

  Future getUserProfile({
    required String userEmail,
  }) async {
    final Uri uri = Uri.parse(USER_INFO_URL + "/$userEmail");
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }
}
