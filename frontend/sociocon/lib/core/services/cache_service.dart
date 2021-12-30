import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sociocon/app/routes/app.routes.dart';

class CacheService {
  Future<String?> readCache({
    required String key,
  }) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? cachedData = await sharedPreferences.getString(key);
    return cachedData;
  }

  Future<List<String>?> readProfileCache({
    required String key,
  }) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    List<String>? cachedData = await sharedPreferences.getStringList(key);
    return cachedData;
  }

  Future writeCache({required String key, required String value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  Future writeProfileCache(
      {required String key, required List<String> value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setStringList(key, value);
  }

  Future deleteCache({
    required BuildContext context,
    required String key1,
    required String key2,
  }) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove(key1);
    await sharedPreferences.remove(key2).whenComplete(() {
      Navigator.of(context).pushReplacementNamed(LoginRoute);
    });
  }
}
