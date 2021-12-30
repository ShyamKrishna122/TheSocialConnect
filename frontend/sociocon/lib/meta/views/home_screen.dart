import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/core/services/cache_service.dart';
import 'package:sociocon/meta/views/add_post_screen.dart';
import 'package:sociocon/meta/views/notification_screen.dart';
import 'package:sociocon/meta/views/profile_screen.dart';
import 'package:sociocon/meta/views/search_friend_screen.dart';
import 'package:sociocon/meta/widget/post_body_widget.dart';
import 'package:sociocon/meta/widget/story_body_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final CacheService _cacheService = new CacheService();
  @override
  void initState() {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    _cacheService.readCache(key: "jwtdata").then((token) async {
      await userNotifier.decodeUserData(
        context: context,
        token: token!,
        option: 1,
      );
    });
    super.initState();
  }

  List<Widget> screens = [
    PostBodyWidget(),
    SearchFriendScreen(),
    AddPostScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context, listen: false).userInfo;
    return Scaffold(
      appBar: _selectedIndex != 4
          ? AppBar(
              title: Text("SocioCon"),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.messenger,
                  ),
                  onPressed: () {},
                ),
              ],
            )
          : AppBar(
              title: Text(
                userInfoModel.userModel!.userName!,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.add,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.menu,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: screens[_selectedIndex],
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       StoryBodyWigdet(),
      //       Divider(
      //         color: Colors.black,
      //         thickness: 1,
      //       ),
      //       PostBodyWidget(),
      //       MaterialButton(
      //         color: Colors.red,
      //         onPressed: () async {
      //           await _cacheService.deleteCache(
      //             context: context,
      //             key: 'jwtdata',
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: 'add'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            label: 'fav',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(),
            label: 'me',
          ),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
