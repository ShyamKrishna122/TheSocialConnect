import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sociocon/core/api/posts.api.dart';
import 'package:sociocon/core/models/post_model.dart';
import 'package:sociocon/core/models/user_model.dart';

class PostsNotifier extends ChangeNotifier {
  final PostsAPI _postsAPI = new PostsAPI();
  Future<List<PostModel>> getPosts({
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
              'userEmail': data['userEmail'],
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
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future getPostsCount({
    required String userEmail,
  }) async {
    try {
      final data = await _postsAPI.getPostsCount(
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isReceived = parsedData['received'];
      final postCount = parsedData['data'];
      if (isReceived) {
        return postCount;
      } else {
        return 0;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List<PostModel>> getMyPosts({
    required String userMail,
    required UserInfoModel userInfoModel,
  }) async {
    try {
      final Map<String, dynamic> _posts = await _postsAPI.getMyPosts(
        userEmail: userMail,
      );
      if (_posts['received'] == true) {
        List<PostModel> _postsList = [];
        Map<int, Map<String, dynamic>> p1 = {};
        List<dynamic> _postsData = _posts['data'];
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
              'userEmail': userInfoModel.userModel.userEmailId,
              'userName': userInfoModel.userModel.userName,
              'userDp': userInfoModel.userDp,
            };
          }
        }
        for (var data in p1.values) {
          PostModel postModel = PostModel.fromMap(map: data);
          _postsList.add(postModel);
        }
        return _postsList;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future deleteMyPosts({
    required int postId,
    required String userEmail,
  }) async {
    try {
      final data = await _postsAPI.deleteMyPosts(
        postId: postId,
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isDeleted = parsedData['deleted'];
      print(isDeleted);
      final deleteData = parsedData['message'];
      if (isDeleted) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
    }
  }
}
