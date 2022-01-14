import 'package:http/http.dart' as http;
import 'package:sociocon/app/routes/api_routes.dart';

class StoryViewAPI {
  final client = http.Client();
  final headers = {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": '*',
  };
  Future addView({
    required int storyMediaId,
    required String userEmail,
  }) async {
    final storyViewURL = STORY_VIEW_URL + "/add/$storyMediaId/$userEmail";
    final Uri uri = Uri.parse(storyViewURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future isStoryViewed({
    required int storyMediaId,
    required String userEmail,
  }) async {
    final storyViewURL = STORY_VIEW_URL + "/isViewed/$storyMediaId/$userEmail";
    final Uri uri = Uri.parse(storyViewURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }

  Future getStoryViewCount({
    required int storyMediaId,
  }) async {
    final storyViewURL = STORY_VIEW_URL + "/$storyMediaId";
    final Uri uri = Uri.parse(storyViewURL);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final dynamic body = response.body;
    return body;
  }
}
