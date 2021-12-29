import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sociocon/app/routes/app.routes.dart';
import 'package:sociocon/core/api/user.api.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/services/cache_service.dart';

class UserNotifier extends ChangeNotifier {
  final UserAPI _userAPI = new UserAPI();
  final CacheService _cacheService = new CacheService();

  Future createProfile({
    required BuildContext context,
    required UserModel userModel,
    required String name,
    required String bio,
    required String dp,
  }) async {
    try {
      var userProfileData = await _userAPI.createProfile(
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
          key: "userProfile",
          value: [
            userModel.userEmailId as String,
            userModel.userName as String,
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
}
