import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

// class PostMediaAPI {
//   final client = http.Client();
//   final headers = {
//     "Content-type": "application/json",
//     "Accept": "application/json",
//     "Access-Control-Allow-Origin": '*',
//   };

//   Future addPostMedia({required int postId}) async {
//     final postMediaURL = POST_MEDIA_URL + "/add/$postId";
//     final Uri uri = Uri.parse(postMediaURL);
//     final http.Response response = await client.get(
//       uri,
//       headers: headers,
//     );
//     final dynamic body = response.body;
//     final Map<String, dynamic> parsedPosts = await jsonDecode(body);
//     return parsedPosts;
//   }
// }
