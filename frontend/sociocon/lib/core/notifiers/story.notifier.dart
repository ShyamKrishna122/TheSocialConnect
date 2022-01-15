import 'package:flutter/material.dart';
import 'package:sociocon/core/api/story.api.dart';
import 'package:sociocon/core/models/story_model.dart';

class StoriesNotifier extends ChangeNotifier {
  final StoriesAPI _storiesAPI = new StoriesAPI();
  Future<List<StoryModel>> getStories({
    required String userMail,
  }) async {
    try {
      final Map<String, dynamic> _stories =
          await _storiesAPI.fetchMembersStories(
        userMail: userMail,
      );
      if (_stories['received'] == true) {
        List<StoryModel> _storyList = [];
        Map<String, Map<String, dynamic>> p1 = {};
        List<dynamic> _storiesData = _stories['data'];
        for (var data in _storiesData) {
          DateTime storyTime = DateTime.parse(data['storyTime']);
          DateTime storyEndTime = storyTime.add(Duration(days: 1));
          DateTime now = DateTime.now();
          if (!now.isAfter(storyEndTime)) {
            if (p1.containsKey(data['userId'])) {
              var p2 = p1[data['userId']];
              p2!['storyMedia'].add({
                'mediaId': data['storyMediaId'],
                'mediaType': data['storyMediaType'],
                'mediaUrl': data['storyMediaUrl'],
                'storyTime': DateTime.parse(data['storyTime']),
              });
            } else {
              p1[data['userId']] = {
                'storyId': data['storyId'],
                'storyTime': data['storyTime'],
                'storyMedia': [
                  {
                    'mediaId': data['storyMediaId'],
                    'mediaType': data['storyMediaType'],
                    'mediaUrl': data['storyMediaUrl'],
                    'storyTime': DateTime.parse(data['storyTime']),
                  },
                ],
                'userId': data['userId'],
                'userEmail': data['userEmail'],
                'userName': data['userName'],
                'userDp': data['userDp'],
              };
            }
          }
        }
        for (var data in p1.values) {
          StoryModel storyModel = StoryModel.fromMap(map: data);
          _storyList.add(storyModel);
        }
        return _storyList;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<StoryModel> getStoriesByUser({
    required String userEmail,
  }) async {
    try {
      final Map<String, dynamic> _stories =
          await _storiesAPI.fetchStoriesByUser(
        userEmail: userEmail,
      );
      if (_stories['received'] == true) {
        StoryModel _myStory;
        Map<String, Map<String, dynamic>> p1 = {};
        List<dynamic> _storiesData = _stories['data'];
        for (var data in _storiesData) {
          DateTime storyTime = DateTime.parse(data['storyTime']);
          DateTime storyEndTime = storyTime.add(Duration(days: 1));
          DateTime now = DateTime.now();
          if (!now.isAfter(storyEndTime)) {
            if (p1.containsKey(data['userId'])) {
              var p2 = p1[data['userId']];
              p2!['storyMedia'].add({
                'mediaId': data['storyMediaId'],
                'mediaType': data['storyMediaType'],
                'mediaUrl': data['storyMediaUrl'],
                'storyTime': DateTime.parse(data['storyTime']),
              });
            } else {
              p1[data['userId']] = {
                'storyId': data['storyId'],
                'storyMedia': [
                  {
                    'mediaId': data['storyMediaId'],
                    'mediaType': data['storyMediaType'],
                    'mediaUrl': data['storyMediaUrl'],
                    'storyTime': DateTime.parse(data['storyTime']),
                  },
                ],
                'userId': data['userId'],
                'userEmail': data['userEmail'],
                'userName': data['userName'],
                'userDp': data['userDp'],
              };
            }
          }
        }
        StoryModel storyModel = StoryModel.fromMap(map: p1.values.first);
        _myStory = storyModel;
        return _myStory;
      } else {
        return StoryModel(
          storyId: -1,
          personId: '',
          personEmail: '',
          personName: '',
          personDp: '',
          mediaUrls: [],
        );
      }
    } catch (error) {
      print(error);
      return StoryModel(
        storyId: -1,
        personId: '',
        personEmail: '',
        personName: '',
        personDp: '',
        mediaUrls: [],
      );
    }
  }
}
