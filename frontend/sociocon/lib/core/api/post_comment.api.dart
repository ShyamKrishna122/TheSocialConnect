import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class PostCommentAPI {
  final client = http.Client();
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": '*',
  };
  Future addComment({
    required int postId,
    required String userEmail,
    required String commentText,
  }) async {
    final postCommentURL = COMMENT_URL + "/add/$postId";
    final Uri uri = Uri.parse(postCommentURL);
    final http.Response response = await client.post(
      uri,
      headers: headers,
      body: jsonEncode({
        'userEmail': userEmail,
        'commentText': commentText,
      }),
    );
    final dynamic body = response.body;
    return body;
  }

  Future getPostComments({
    required int postId,
  }) async {
    final postCommentURL = COMMENT_URL + "/$postId";
    final Uri uri = Uri.parse(postCommentURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future getPostCommentsCount({
    required int postId,
  }) async {
    final postCommentURL = COMMENT_URL + "/count/$postId";
    final Uri uri = Uri.parse(postCommentURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future deleteComment({
    required int postId,
    required String userEmail,
  }) async {
    final postCommentURL = COMMENT_URL + "/delete/$postId/$userEmail";
    final Uri uri = Uri.parse(postCommentURL);
    final http.Response response = await client.delete(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }
}
