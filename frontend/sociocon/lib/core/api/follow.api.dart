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

  Future getFollowingCount({
    required String userEmail,
  }) async {
    final Uri uri = Uri.parse(
      FOLLOW_URL + "/followingCount/$userEmail",
    );
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future getFollowersCount({
    required String userEmail,
  }) async {
    final Uri uri = Uri.parse(
      FOLLOW_URL + "/followersCount/$userEmail",
    );
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future getFollowersInfo({
    required String userEmail,
  }) async {
    final Uri uri = Uri.parse(
      FOLLOW_URL + "/follower/$userEmail",
    );
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future getFollowingInfo({
    required String userEmail,
  }) async {
    final Uri uri = Uri.parse(
      FOLLOW_URL + "/following/$userEmail",
    );
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

}
