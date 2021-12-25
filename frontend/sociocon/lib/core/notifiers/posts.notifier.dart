import 'package:flutter/material.dart';
import 'package:sociocon/core/api/posts.api.dart';
import 'package:sociocon/core/models/post_model.dart';

class PostsNotifier extends ChangeNotifier {
  final PostsAPI _postsAPI = new PostsAPI();
  Future getPosts({
    required String userMail,
  }) async {
    try {
      final Map<String, dynamic> _posts = await _postsAPI.fetchMembersPosts(
        userMail: userMail,
      );
      print(_posts);
      if (_posts['received'] == true) {
        List<PostModel> _postsList = [];
        List _postsData = _posts['message'];
        for (var data in _postsData) {
          _postsList.add(
            PostModel.fromMap(
              map: data,
            ),
          );
        }
        print(_postsList);
      } else {
        print(_posts['message']);
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}
