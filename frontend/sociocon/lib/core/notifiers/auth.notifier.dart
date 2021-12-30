import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sociocon/app/routes/app.routes.dart';
import 'package:sociocon/core/api/auth.api.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/services/cache_service.dart';
import 'package:sociocon/meta/views/create_profile.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationAPI _authenticationAPI = new AuthenticationAPI();
  final CacheService _cacheService = new CacheService();
  UserModel _user = UserModel(
    userId: "",
    userEmailId: "",
    userPassword: "",
    userName: "",
  );

  UserModel get user => _user;
  Future createAccount({
    required BuildContext context,
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      var userData = await _authenticationAPI.createAccount(
          userName: userName, userEmail: userEmail, userPassword: userPassword);
      final Map<String, dynamic> parsedUserData = await jsonDecode(userData);
      bool isAuthenticated = parsedUserData["authentication"];
      dynamic authData = parsedUserData["message"];
      if (isAuthenticated == false) {
        switch (authData) {
          case "Invalid Email":
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black87,
                content: Text(
                  "Invalid Email",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
            break;
          case "UserName already exists.Try another one":
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black87,
                content: Text(
                  "UserName already exists.Try another one",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
            break;
          case "Email already exists.Try another one":
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black87,
                content: Text(
                  "Email already exists.Try another one",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black87,
                content: Text(
                  "An error occured",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
        }
      } else if (isAuthenticated) {
        await _cacheService
            .writeCache(
              key: "jwtdata",
              value: authData,
            )
            .whenComplete(
              () => Navigator.of(context).pushReplacementNamed(
                CreateProfileRoute,
              ),
            );
      }
    } catch (error) {
      print(error);
    }
  }

  Future loginUser({
    required BuildContext context,
    required String userEmail,
    required String userPassword,
  }) async {
    try {
      var userData = await _authenticationAPI.loginUser(
        userEmail: userEmail,
        userPassword: userPassword,
      );
      final Map<String, dynamic> parsedUserData = await jsonDecode(userData);
      bool isAuthenticated = parsedUserData["authentication"];
      dynamic authData = parsedUserData["message"];
      if (isAuthenticated) {
        await _cacheService.writeCache(
          key: "jwtdata",
          value: authData,
        );
        final List<String>? data = await _cacheService.readProfileCache(
          key: "userProfile",
        );
        if (data != null) {
          Navigator.of(context).pushReplacementNamed(HomeRoute);
        } else {
          Navigator.of(context).pushReplacementNamed(
            CreateProfileRoute,
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black87,
            content: Text(
              "Check your credentials",
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
