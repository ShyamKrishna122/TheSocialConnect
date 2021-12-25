import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/app/providers.dart';
import 'package:sociocon/app/routes/app.routes.dart';

void main() {
  runApp(Core());
}

class Core extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: remoteProviders,
      child: Lava(),
    );
  }
}

class Lava extends StatelessWidget {
  const Lava({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeRoute,
      routes: routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}
