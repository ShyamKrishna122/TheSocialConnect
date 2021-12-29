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
      if (_posts['received'] == true) {
        List<PostModel> _postsList = [];
        Map<int, Map<String, dynamic>> p1 = {};
        List<dynamic> _postsData = _posts['message'];
        for (var data in _postsData) {
          if (p1.containsKey(data['postId'])) {
            var p2 = p1[data['postId']];
            p2!['postMedia'].add({
              'mediaType': data['postMediaType'],
              'mediaUrl': data['postMediaUrl'],
            });
          } else {
            p1[data['postId']] = {
              'postId': data['postId'],
              'postDescription': data['postDescription'],
              'postTime': data['postTime'],
              'postMedia': [
                {
                  'mediaType': data['postMediaType'],
                  'mediaUrl': data['postMediaUrl'],
                },
              ],
              'postType': data['postType'],
              'postImageType': data['postImageType'],
              'userId': data['userId'],
              'userName': data['userName'],
              'userDp': data['userDp'],
            };
          }
        }
        for (var data in p1.values) {
          PostModel postModel = PostModel.fromMap(map: data);
          _postsList.add(postModel);
        }
        return _postsList;
      } else {
        return  _posts['message'];
      }
    } catch (error) {
      return  error;
    }
  }
}
