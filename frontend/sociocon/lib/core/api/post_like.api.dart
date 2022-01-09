import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class PostLikeAPI {
  final client = http.Client();
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": '*',
  };
  Future addLike({
    required int postId,
    required String userEmail,
  }) async {
    final postLikeURL = LIKE_URL + "/add/$postId/$userEmail";
    final Uri uri = Uri.parse(postLikeURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future removeLike({
    required int postId,
    required String userEmail,
  }) async {
    final postLikeURL = LIKE_URL + "/remove/$postId/$userEmail";
    final Uri uri = Uri.parse(postLikeURL);
    final http.Response response = await client.delete(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future isPostLiked({
    required int postId,
    required String userEmail,
  }) async {
    final postLikeURL = LIKE_URL + "/isLiked/$postId/$userEmail";
    final Uri uri = Uri.parse(postLikeURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future getLikesCount({
    required int postId,
  }) async {
    final postLikeURL = LIKE_URL + "/$postId";
    final Uri uri = Uri.parse(postLikeURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future getPersonList({
    required int postId,
  }) async {
    final postLikeURL = LIKE_URL + "/get/$postId";
    final Uri uri = Uri.parse(postLikeURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }
}
