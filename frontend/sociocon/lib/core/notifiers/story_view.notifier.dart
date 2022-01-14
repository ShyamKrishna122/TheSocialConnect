import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sociocon/core/api/story_view.api.dart';
import 'package:sociocon/core/models/user_model.dart';

class StoryViewNotifier extends ChangeNotifier {
  final StoryViewAPI _viewsAPI = new StoryViewAPI();
  Future addView({
    required int storyMediaId,
    required String userEmail,
  }) async {
    try {
      final data = await _viewsAPI.addView(
        storyMediaId: storyMediaId,
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isViewed = parsedData['viewed'];
      if (isViewed) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
    }
  }

  Future isStoryViewed({
    required int storyMediaId,
    required String userEmail,
  }) async {
    try {
      final data = await _viewsAPI.isStoryViewed(
        storyMediaId: storyMediaId,
        userEmail: userEmail,
      );
      final parsedData = await jsonDecode(data);
      final isViewed = parsedData['isviewed'];
      final info = parsedData['message'];
      if (isViewed && info == 'yes') {
        return true;
      } else if (isViewed == false && info == 'no') {
        return false;
      }
    } catch (error) {
      print("hii");
      print(error);
    }
  }

  Future getStoryViewCount({
    required int storyMediaId,
  }) async {
    try {
      final data = await _viewsAPI.getStoryViewCount(
        storyMediaId: storyMediaId,
      );
      final parsedData = await jsonDecode(data);
      final isReceived = parsedData['received'];
      final viewData = parsedData['data'];
      if (isReceived) {
        return viewData;
      } else {
        print(viewData);
      }
    } catch (error) {
      print(error);
    }
  }

  Future setStoryViews({
    required String userEmail,
    required int storyMediaId,
  }) async {
    final isViewed = await isStoryViewed(
      storyMediaId: storyMediaId,
      userEmail: userEmail,
    );
    if (!isViewed) {
      final isAdded =
          await addView(storyMediaId: storyMediaId, userEmail: userEmail);
      if (isAdded) {
        print("view added");
      } else {
        print("not added");
      }
    } else {
      print("already viewed");
    }
  }
}
