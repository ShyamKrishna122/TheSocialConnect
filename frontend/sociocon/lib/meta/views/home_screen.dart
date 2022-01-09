import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/app/routes/app.routes.dart';
import 'package:sociocon/core/notifiers/page.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/core/services/cache_service.dart';
import 'package:sociocon/meta/views/add_post_screen.dart';
import 'package:sociocon/meta/views/notification_screen.dart';
import 'package:sociocon/meta/views/profile_screen.dart';
import 'package:sociocon/meta/views/search_friend_screen.dart';
import 'package:sociocon/meta/views/post_body_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CacheService _cacheService = new CacheService();
  bool _isLoading = false;
  TextEditingController _searchQuery = TextEditingController();
  String token1 = "";
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration.zero, () async {
      final userNotifier = Provider.of<UserNotifier>(context, listen: false);
      await _cacheService.readCache(key: "jwtdata").then((token) async {
        token1 = token!;
        await userNotifier.decodeUserData(
          context: context,
          token: token,
          option: 1,
        );
      });
    });
    setState(() {
      _isLoading = false;
    });
    super.initState();
  }

  List<Widget> screens = [
    PostBodyScreen(),
    SearchFriendScreen(),
    AddPostScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userInfoModel = Provider.of<UserNotifier>(context).userInfo;
    final userNotifier = Provider.of<UserNotifier>(context);
    final pageNotifier = Provider.of<PageNotifier>(context);
    return _isLoading == false && userInfoModel.userModel.userEmailId.isNotEmpty
        ? Scaffold(
            appBar: pageNotifier.selctedIndex != 4 &&
                    pageNotifier.selctedIndex != 1 &&
                    pageNotifier.selctedIndex != 2
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
                : pageNotifier.selctedIndex == 1
                    ? PreferredSize(
                        preferredSize: const Size.fromHeight(
                          60,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 30,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                20,
                              ),
                            ),
                          ),
                          child: TextField(
                            controller: _searchQuery,
                            textInputAction: TextInputAction.search,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: "Search",
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            onChanged: (value) async {
                              if (value.isNotEmpty) {
                                if (userNotifier.lastSearch != value) {
                                  {
                                    userNotifier.clearSearchResults();
                                  }
                                  await userNotifier.getSearchResults(
                                    context: context,
                                    searchQuery: _searchQuery.text,
                                    userName: userInfoModel.userModel.userName,
                                    token: token1,
                                  );
                                }
                              } else {
                                userNotifier.clearSearchResults();
                                userNotifier.clearLastSearch();
                              }
                            },
                          ),
                        ),
                      )
                    : pageNotifier.selctedIndex == 2
                        ? AppBar(
                            leading: CloseButton(),
                            title: Text(
                              "New Post",
                            ),
                            actions: [
                              IconButton(
                                icon: Icon(
                                  Icons.check,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        : AppBar(
                            title: Text(
                              userInfoModel.userModel.userName,
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
            body: screens[pageNotifier.selctedIndex],
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
                  icon: CircleAvatar(
                    backgroundImage: userInfoModel.userDp.isNotEmpty
                        ? NetworkImage(userInfoModel.userDp)
                        : null,
                    child: userInfoModel.userDp.isNotEmpty
                        ? null
                        : Icon(
                            Icons.person,
                          ),
                  ),
                  label: 'me',
                ),
              ],
              currentIndex: pageNotifier.selctedIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (value) {
                pageNotifier.setSelectedIndex(
                  value: value,
                );
              },
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
