import 'package:sociocon/meta/views/create_profile.dart';
import 'package:sociocon/meta/views/decider_screen.dart';
import 'package:sociocon/meta/views/edit_profile_screen.dart';
import 'package:sociocon/meta/views/home_screen.dart';
import 'package:sociocon/meta/views/login_screen.dart';
import 'package:sociocon/meta/views/signUp_screen.dart';

final String HomeRoute = '/home';
final String LoginRoute = '/login';
final String SignUpRoute = '/signUp';
final String CreateProfileRoute = '/create';
final String DeciderRoute = '/decider';
final String EditProfileRoute = '/edit';

final routes = {
  HomeRoute: (context) => HomeScreen(),
  LoginRoute: (context) => LoginScreen(),
  SignUpRoute: (context) => SignUpScreen(),
  CreateProfileRoute: (context) => CreateProfileScreen(),
  DeciderRoute: (context) => DeciderScreen(),
  EditProfileRoute: (context) => EditProfileScreen(),
};
