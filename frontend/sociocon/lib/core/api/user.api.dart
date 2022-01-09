import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class UserAPI {
  final client = http.Client();
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

  Future getSearchResults({
    required String searchQuery,
    required String userName,
    required String token,
  }) async {
    final Uri uri = Uri.parse(AUTH_URL + "/fetch/$searchQuery/$userName");
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
