import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/follow.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';

class FriendProfileScreen extends StatefulWidget {
  final UserInfoModel friendInfoModel;
  const FriendProfileScreen({
    Key? key,
    required this.friendInfoModel,
  }) : super(key: key);

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final followNotifier = Provider.of<FollowNotifier>(context, listen: false);
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context, listen: false).userInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.friendInfoModel.userModel.userName,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: widget.friendInfoModel.userDp.isNotEmpty
                          ? NetworkImage(widget.friendInfoModel.userDp)
                          : null,
                      child: widget.friendInfoModel.userDp.isNotEmpty
                          ? null
                          : Icon(Icons.person),
                    ),
                  ),
                  CustomInfoWidget(
                    "20",
                    "Posts",
                  ),
                  CustomInfoWidget(
                    "100",
                    "Followers",
                  ),
                  CustomInfoWidget(
                    "100",
                    "Following",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.friendInfoModel.userFullName!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.friendInfoModel.userBio!,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: followNotifier.isFollowing(
                userEmail: userInfoModel.userModel.userEmailId,
                followingId: widget.friendInfoModel.userModel.userId,
              ),
              builder: (context, snapshot) {
                final isFollowing = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GestureDetector(
                  onTap: () async {
                    if (isFollowing == true) {
                      await followNotifier.removeFollowing(
                        userEmail: userInfoModel.userModel.userEmailId,
                        followingId: widget.friendInfoModel.userModel.userId,
                      );
                    } else {
                      await followNotifier.addFollowing(
                        userEmail: userInfoModel.userModel.userEmailId,
                        followingId: widget.friendInfoModel.userModel.userId,
                      );
                    }
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    height: 30,
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Text(
                      isFollowing == true ? "UnFollow" : "Follow",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Column CustomInfoWidget(
    String info,
    String message,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(info),
        Text(message),
      ],
    );
  }
}
