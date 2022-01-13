import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class PostsAPI {
  final client = http.Client();
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": '*',
  };

  Future fetchMembersPosts({required String userMail}) async {
    final postsURL = POST_URL + "/$userMail";
    final Uri uri = Uri.parse(postsURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    final Map<String, dynamic> parsedPosts = await jsonDecode(body);
    return parsedPosts;
  }

  Future getPostsCount({
    required String userEmail,
  }) async {
    final postsURL = POST_URL + "/count/$userEmail";
    final Uri uri = Uri.parse(postsURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future getMyPosts({
    required String userEmail,
  }) async {
    final postsURL = POST_URL + "/myPosts/$userEmail";
    final Uri uri = Uri.parse(postsURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    final Map<String, dynamic> parsedPosts = await jsonDecode(body);
    return parsedPosts;
  }

  Future deleteMyPosts({
    required int postId,
    required String userEmail,
  }) async {
    final postsURL = POST_URL + "/delete/$postId/$userEmail";
    final Uri uri = Uri.parse(postsURL);
    final http.Response response = await client.delete(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }
}
