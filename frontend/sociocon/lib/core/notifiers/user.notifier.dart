import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sociocon/app/routes/app.routes.dart';
import 'package:sociocon/core/api/user.api.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/services/cache_service.dart';

class UserNotifier extends ChangeNotifier {
  final UserAPI _userAPI = new UserAPI();
  final CacheService _cacheService = new CacheService();

  UserInfoModel _userInfo = UserInfoModel();

  UserInfoModel get userInfo => _userInfo;

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
            userModel.userId as String,
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

  Future decodeUserData({
    required BuildContext context,
    required String token,
  }) async {
    try {
      _userAPI.decodeUserData(token: token).then((value) async {
        final Map<String, dynamic> parsedData = await jsonDecode(value);
        var userData = parsedData['data'];
        if (userData != null) {
          List<String>? userProfileData = await _cacheService.readProfileCache(
            key: "userProfile",
          );
          if (userProfileData == null) {
            _userInfo = UserInfoModel(
              userModel: UserModel(
                userId: userData['userData']['id'],
                userEmailId: userData['userData']['userEmail'],
                userName: userData['userData']['userName'],
                userPassword: userData['userData']['userPassword'],
              ),
            );
          } else {
            _userInfo = UserInfoModel(
              userModel: UserModel(
                userId: userData['userData']['id'],
                userEmailId: userData['userData']['userEmail'],
                userName: userData['userData']['userName'],
                userPassword: userData['userData']['userPassword'],
              ),
              userFullName: userProfileData[4],
              userBio: userProfileData[5],
              userDp: userProfileData[6],
            );
          }
        } else {
          Navigator.of(context).pushReplacementNamed(LoginRoute);
        }
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
  }
}
