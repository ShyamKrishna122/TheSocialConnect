import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/follow.notifier.dart';
import 'package:sociocon/core/notifiers/user.info.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({
    Key? key,
    required this.userEmail,
  }) : super(key: key);
  final String userEmail;

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
    final followNotifier = Provider.of<FollowNotifier>(context, listen: false);
    final userInfoModel =
        Provider.of<UserNotifier>(context, listen: false).userInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Following',
        ),
      ),
      body: FutureBuilder<List<UserInfoModel>>(
        future: followNotifier.getFollowingInfo(
          userEmail: userInfoModel.userModel.userEmailId,
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
                        trailing: FutureBuilder(
                          future: followNotifier.isFollowing(
                            userEmail: userInfoModel.userModel.userEmailId,
                            followingId: info.userModel.userId,
                          ),
                          builder: (context, snapshot) {
                            final isFollowing = snapshot.data;
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                height: 0,
                                width: 0,
                              );
                            }
                            return MaterialButton(
                              color: Colors.blue,
                              child: Text(
                                isFollowing == true ? "Following" : "Follow",
                              ),
                              onPressed: () async {
                                if (isFollowing == true) {
                                  await followNotifier.removeFollowing(
                                    userEmail:
                                        userInfoModel.userModel.userEmailId,
                                    followingId: info.userModel.userId,
                                  );
                                } else {
                                  await followNotifier.addFollowing(
                                    userEmail:
                                        userInfoModel.userModel.userEmailId,
                                    followingId: info.userModel.userId,
                                  );
                                }
                                setState(() {});
                              },
                            );
                          },
                        ),
                      );
                    },
                  ).toList(),
                )
              : Center(
                  child: Text(
                    'No likes',
                  ),
                );
        },
      ),
    );
  }
}
