import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sociocon/core/api/post_like.api.dart';
import 'package:sociocon/core/models/user_model.dart';

class PostLikeNotifier extends ChangeNotifier {
  final PostLikeAPI _postsAPI = new PostLikeAPI();
  Future addLike({
    required int postId,
    required String userEmail,
  }) async {
    try {
      final data = await _postsAPI.addLike(
        postId: postId,
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isLiked = parsedData['liked'];
      if (isLiked) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
    }
  }

  Future removeLike({
    required int postId,
    required String userEmail,
  }) async {
    try {
      final data = await _postsAPI.removeLike(
        postId: postId,
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isUnLiked = parsedData['unliked'];
      if (isUnLiked) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
    }
  }

  Future isPostLiked({
    required int postId,
    required String userEmail,
  }) async {
    try {
      final data = await _postsAPI.isPostLiked(
        postId: postId,
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isUnLiked = parsedData['isliked'];
      final info = parsedData['message'];
      if (isUnLiked && info == 'yes') {
        return true;
      } else if (isUnLiked == false && info == 'no') {
        return false;
      }
    } catch (error) {
      print("hii");
      print(error);
    }
  }

  Future getLikesCount({
    required int postId,
  }) async {
    try {
      final data = await _postsAPI.getLikesCount(
        postId: postId,
      );
      final parsedData = await jsonDecode(data);
      final isReceived = parsedData['received'];
      final likeData = parsedData['data'];
      if (isReceived) {
        return likeData;
      } else {
        print(likeData);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List<UserInfoModel>> getPersonList({
    required int postId,
  }) async {
    try {
      final data = await _postsAPI.getPersonList(
        postId: postId,
      );
      final parsedData = await jsonDecode(data);
      final isReceived = parsedData['received'];
      if (isReceived) {
        List<UserInfoModel> _usersList = [];
        List<dynamic> _commentData = parsedData['data'];
        for (var data in _commentData) {
          UserInfoModel userInfoModel = UserInfoModel(
            userModel: UserModel(
              userId: data['user']['id'],
              userEmailId: data['user']['userEmail'],
              userName: data['user']['userName'],
            ),
            userFullName: data['user']['info']['name'],
            userBio: data['user']['info']['userBio'],
            userDp: data['user']['info']['userDp'],
          );
          _usersList.add(userInfoModel);
        }
        return _usersList;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
