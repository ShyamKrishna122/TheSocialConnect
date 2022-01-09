import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sociocon/core/api/follow.api.dart';

class FollowNotifier extends ChangeNotifier {
  final FollowAPI _followAPI = new FollowAPI();

  Future addFollowing({
    required String userEmail,
    required String followingId,
  }) async {
    try {
      var followData = await _followAPI.addFollowing(
        userEmail: userEmail,
        followingId: followingId,
      );
      final Map<String, dynamic> parsedUserData = await jsonDecode(followData);
      bool isAdded = parsedUserData["following"];
      dynamic data = parsedUserData["message"];
      if (isAdded) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
    }
  }

  Future removeFollowing({
    required String userEmail,
    required String followingId,
  }) async {
    try {
      var followData = await _followAPI.removeFollowing(
        userEmail: userEmail,
        followingId: followingId,
      );
      final Map<String, dynamic> parsedUserData = await jsonDecode(followData);
      bool isRemoved = parsedUserData["unFollowed"];
      dynamic data = parsedUserData["message"];
      if (isRemoved) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
    }
  }

  Future isFollowing({
    required String userEmail,
    required String followingId,
  }) async {
    try {
      var followData = await _followAPI.isFollowing(
        userEmail: userEmail,
        followingId: followingId,
      );
      final Map<String, dynamic> parsedUserData = await jsonDecode(followData);
      bool isFollowing = parsedUserData["following"];
      dynamic data = parsedUserData["message"];
      if (isFollowing) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
    }
  }

  Future getFollowingCount({
    required String userEmail,
  }) async {
    try {
      final data = await _followAPI.getFollowingCount(
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isReceived = parsedData['received'];
      final followingCount = parsedData['data'];
      if (isReceived) {
        return followingCount;
      } else {
        return 0;
      }
    } catch (error) {
      print(error);
    }
  }

  Future getFollowersCount({
    required String userEmail,
  }) async {
    try {
      final data = await _followAPI.getFollowersCount(
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isReceived = parsedData['received'];
      final followersCount = parsedData['data'];
      if (isReceived) {
        return followersCount;
      } else {
        return 0;
      }
    } catch (error) {
      print(error);
    }
  }
}
