import 'package:flutter/material.dart';
import 'package:sociocon/core/services/cache_service.dart';
import 'package:sociocon/meta/views/home_screen.dart';
import 'package:sociocon/meta/views/login_screen.dart';

class DeciderScreen extends StatelessWidget {
  const DeciderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CacheService _cacheService = new CacheService();
    return FutureBuilder(
      future: _cacheService.readCache(key: "jwtdata"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
