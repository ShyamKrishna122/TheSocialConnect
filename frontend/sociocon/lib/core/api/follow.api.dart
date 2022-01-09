import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class FollowAPI {
  final client = http.Client();
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": '*',
  };

  Future addFollowing({
    required String userEmail,
    required String followingId,
  }) async {
    final Uri uri = Uri.parse(FOLLOW_URL + "/add/$userEmail/$followingId");
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future removeFollowing({
    required String userEmail,
    required String followingId,
  }) async {
    final Uri uri = Uri.parse(FOLLOW_URL + "/remove/$userEmail/$followingId");
    final http.Response response = await client.delete(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future isFollowing({
    required String userEmail,
    required String followingId,
  }) async {
    final Uri uri =
        Uri.parse(FOLLOW_URL + "/isFollowing/$userEmail/$followingId");
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }
}
