import 'package:sociocon/meta/views/add_post_screen.dart';
import 'package:sociocon/meta/views/create_profile.dart';
import 'package:sociocon/meta/views/decider_screen.dart';
import 'package:sociocon/meta/views/edit_profile_screen.dart';
import 'package:sociocon/meta/views/followers_screen.dart';
import 'package:sociocon/meta/views/following_screen.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';
import 'package:sociocon/meta/views/home_screen.dart';
import 'package:sociocon/meta/views/login_screen.dart';
import 'package:sociocon/meta/views/notification_screen.dart';
import 'package:sociocon/meta/views/profile_screen.dart';
import 'package:sociocon/meta/views/search_friend_screen.dart';
import 'package:sociocon/meta/views/signUp_screen.dart';
import 'package:sociocon/meta/views/post_body_screen.dart';

final String HomeRoute = '/home';
final String LoginRoute = '/login';
final String SignUpRoute = '/signUp';
final String CreateProfileRoute = '/create';
final String DeciderRoute = '/decider';
final String EditProfileRoute = '/edit';
final String PostRoute = '/post';
final String SearchRoute = '/search';
final String AddRoute = '/add';
final String NotifyRoute = '/notify';
final String ProfileRoute = '/profile';
final String FollowersScreenRoute = '/followers';
final String FollowingScreenRoute = '/following';

final routes = {
  HomeRoute: (context) => HomeScreen(),
  LoginRoute: (context) => LoginScreen(),
  SignUpRoute: (context) => SignUpScreen(),
  CreateProfileRoute: (context) => CreateProfileScreen(),
  DeciderRoute: (context) => DeciderScreen(),
  EditProfileRoute: (context) => EditProfileScreen(),
  PostRoute: (context) => PostBodyScreen(),
  SearchRoute: (context) => SearchFriendScreen(),
  AddRoute: (context) => AddPostScreen(),
  NotifyRoute: (context) => NotificationScreen(),
  ProfileRoute: (context) => ProfileScreen(),
  FollowersScreenRoute: (context) => FollowersScreen(),
  FollowingScreenRoute: (context) => FollowingScreen(),
};
