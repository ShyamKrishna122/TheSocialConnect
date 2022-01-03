import 'package:flutter/material.dart';
import 'package:sociocon/core/models/user_model.dart';

class FriendProfileScreen extends StatelessWidget {
  final UserInfoModel friendInfoModel;
  const FriendProfileScreen({
    Key? key,
    required this.friendInfoModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          friendInfoModel.userModel.userName,
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
                      backgroundImage: friendInfoModel.userDp.isNotEmpty
                          ? NetworkImage(friendInfoModel.userDp)
                          : null,
                      child: friendInfoModel.userDp.isNotEmpty
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
                    friendInfoModel.userFullName!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    friendInfoModel.userBio!,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
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
