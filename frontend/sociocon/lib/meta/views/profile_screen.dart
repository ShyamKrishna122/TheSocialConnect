import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/app/routes/app.routes.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context).userInfo;
    return SingleChildScrollView(
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
                    backgroundImage: userInfoModel.userDp!.isNotEmpty
                        ? NetworkImage(userInfoModel.userDp!)
                        : null,
                    child: userInfoModel.userDp!.isNotEmpty
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
                  userInfoModel.userFullName!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  userInfoModel.userBio!,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                EditProfileRoute,
              );
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
                "Edit Profile",
              ),
            ),
          ),
        ],
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
