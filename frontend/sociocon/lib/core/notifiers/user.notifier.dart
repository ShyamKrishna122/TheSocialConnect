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

  Future setUserInfo({
    required String name,
    required String userDp,
    required String userBio,
  }) async {
    _userInfo.userFullName = name;
    _userInfo.userDp = userDp;
    _userInfo.userBio = userBio;
    await _cacheService.writeProfileCache(
      key: _userInfo.userModel!.userId!,
      value: [
        _userInfo.userModel!.userId as String,
        _userInfo.userModel!.userEmailId as String,
        _userInfo.userModel!.userName as String,
        _userInfo.userModel!.userPassword as String,
        name,
        userBio,
        userDp,
      ],
    );
    notifyListeners();
  }

  Future decodeUserData({
    required BuildContext context,
    required String token,
    required int option,
  }) async {
    try {
      _userAPI.decodeUserData(token: token).then((value) async {
        final Map<String, dynamic> parsedData = await jsonDecode(value);
        var userData = parsedData['data'];
        if (userData != null) {
          List<String>? userProfileData = await _cacheService.readProfileCache(
            key: userData['userData']['id'],
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
            if (option != 0)
              Navigator.of(context).pushReplacementNamed(CreateProfileRoute);
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
