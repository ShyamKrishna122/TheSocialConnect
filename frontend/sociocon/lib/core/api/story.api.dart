import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class StoriesAPI {
  final client = http.Client();
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": '*',
  };

  Future fetchMembersStories({required String userMail}) async {
    final storiesURL = STORY_URL + "/fetch/$userMail";
    final Uri uri = Uri.parse(storiesURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    final Map<String, dynamic> parsedPosts = await jsonDecode(body);
    return parsedPosts;
  }

  Future fetchStoriesByUser({required String userEmail}) async {
    final storiesURL = STORY_URL + "/storyByUser/$userEmail";
    final Uri uri = Uri.parse(storiesURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    final Map<String, dynamic> parsedPosts = await jsonDecode(body);
    return parsedPosts;
  }
}
