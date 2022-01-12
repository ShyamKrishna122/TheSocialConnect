import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/follow.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({
    Key? key,
    required this.userEmail,
  }) : super(key: key);

  final String userEmail;

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    final followNotifier = Provider.of<FollowNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Followers',
        ),
      ),
      body: FutureBuilder<List<UserInfoModel>>(
        future: followNotifier.getFollowersInfo(
          userEmail: widget.userEmail,
        ),
        builder: (context, AsyncSnapshot<List<UserInfoModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.length > 0
              ? ListView(
                  children: snapshot.data!.map(
                    (info) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FriendProfileScreen(
                                friendInfoModel: info,
                              ),
                            ),
                          );
                        },
                        leading: GestureDetector(
                          child: CircleAvatar(
                            child: info.userDp.toString().isEmpty
                                ? Icon(
                                    Icons.person,
                                  )
                                : null,
                            backgroundImage: info.userDp.toString().isNotEmpty
                                ? NetworkImage(
                                    info.userDp,
                                  )
                                : null,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        title: Text(
                          info.userModel.userName,
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        subtitle: Text(
                          info.userBio!,
                          style: TextStyle(
                            // color:
                            //     ThemeService.getValue() ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              : Center(
                  child: Text(
                    'No Followers!!',
                  ),
                );
        },
      ),
    );
  }
}
