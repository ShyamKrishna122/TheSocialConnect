import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/app/routes/app.routes.dart';
import 'package:sociocon/core/api/user.info.api.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/core/services/cache_service.dart';

class UserInfoNotifier extends ChangeNotifier {
  final UserInfoAPI _userInfoAPI = new UserInfoAPI();
  final CacheService _cacheService = new CacheService();

  Future createProfile({
    required BuildContext context,
    required UserModel userModel,
    required String name,
    required String bio,
    required String dp,
  }) async {
    try {
      var userProfileData = await _userInfoAPI.createProfile(
        userEmail: userModel.userEmailId,
        name: name,
        bio: bio,
        dp: dp,
      );
      final Map<String, dynamic> parsedUserProfileData =
          await jsonDecode(userProfileData);
      bool isAdded = parsedUserProfileData["added"];
      dynamic profileData = parsedUserProfileData["message"];
      if (isAdded) {
        await _cacheService.writeProfileCache(
          key: userModel.userId,
          value: [
            userModel.userId,
            userModel.userEmailId,
            userModel.userName,
            userModel.userPassword as String,
            name,
            bio,
            dp,
          ],
        ).whenComplete(
          () => Navigator.of(context).pushReplacementNamed(
            HomeRoute,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black87,
            content: Text(
              profileData,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future updateProfile({
    required BuildContext context,
    required String userEmail,
    required String name,
    required String userDp,
    required String userBio,
  }) async {
    try {
      var userProfileData = await _userInfoAPI.updateProfile(
        userEmail: userEmail,
        name: name,
        userBio: userBio,
        userDp: userDp,
      );
      final Map<String, dynamic> parsedUserProfileData =
          await jsonDecode(userProfileData);
      bool isUpdated = parsedUserProfileData["updated"];
      dynamic profileData = parsedUserProfileData["data"];
      if (isUpdated) {
        await Provider.of<UserNotifier>(context, listen: false)
            .setUserInfo(
              name: name,
              userDp: userDp,
              userBio: userBio,
            )
            .whenComplete(
              () => Navigator.of(context).pop(),
            );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black87,
            content: Text(
              profileData,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future getUserProfile({
    required BuildContext context,
    required String userEmail,
  }) async {
    try {
      var userProfileData = await _userInfoAPI.getUserProfile(
        userEmail: userEmail,
      );
      final Map<String, dynamic> parsedUserProfileData =
          await jsonDecode(userProfileData);
      bool isReceived = parsedUserProfileData["received"];
      dynamic profileData = parsedUserProfileData["data"];
      if (isReceived) {
        Map<String, dynamic> data = {
          'id': profileData['user']['id'],
          'userEmail': profileData['user']['userEmail'],
          'userName': profileData['user']['userName'],
          'userPassword': profileData['user']['userPassword'],
          'info': {
            'userDp': profileData['userDp'],
            'name': profileData['name'],
            'userBio': profileData['userBio'],
          }
        };
        UserInfoModel userInfoModel = UserInfoModel.fromMap(
          map: data,
        );
        return userInfoModel;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
    }
  }
}
