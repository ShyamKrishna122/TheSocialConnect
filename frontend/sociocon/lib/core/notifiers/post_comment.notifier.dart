import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sociocon/core/api/post_comment.api.dart';
import 'package:sociocon/core/models/post_comment_model.dart';

class PostCommentNotifier extends ChangeNotifier {
  final PostCommentAPI _postCommentAPI = new PostCommentAPI();
  Future addComment({
    required int postId,
    required String userEmail,
    required String commentText,
  }) async {
    try {
      final data = await _postCommentAPI.addComment(
        postId: postId,
        userEmail: userEmail,
        commentText: commentText,
      );
      final parsedData = await jsonDecode(data);
      final isAdded = parsedData['added'];
      final commentData = parsedData['message'];
      if (isAdded) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List<PostCommentModel>> getPostComments({
    required int postId,
  }) async {
    try {
      final data = await _postCommentAPI.getPostComments(
        postId: postId,
      );
      final parsedData = await jsonDecode(data);
      final isReceived = parsedData['received'];
      if (isReceived) {
        List<PostCommentModel> _postCommentList = [];
        List<dynamic> _commentData = parsedData['data'];
        for (var data in _commentData) {
          PostCommentModel postCommentModel = PostCommentModel.fromMap(
            map: data,
          );
          _postCommentList.add(postCommentModel);
        }
        return _postCommentList;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future getPostCommentsCount({
    required int postId,
  }) async {
    try {
      final data = await _postCommentAPI.getPostCommentsCount(
        postId: postId,
      );
      final parsedData = await jsonDecode(data);
      final isReceived = parsedData['received'];
      final commentData = parsedData['data'];
      if (isReceived) {
        return commentData;
      } else {
        print(commentData);
      }
    } catch (error) {
      print(error);
    }
  }

  Future deleteComment({
    required int postId,
    required String userEmail,
  }) async {
    try {
      final data = await _postCommentAPI.deleteComment(
        postId: postId,
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isDeleted = parsedData['deleted'];
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
