import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';

class SearchFriendScreen extends StatelessWidget {
  const SearchFriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<UserInfoModel> friendsList =
        Provider.of<UserNotifier>(context).friendsList;
    return ListView.builder(
      itemCount: friendsList.length,
      itemBuilder: (context, index) {
        final friend = friendsList[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: friend.userDp.isNotEmpty
                ? NetworkImage(
                    friend.userDp,
                  )
                : null,
            child: friend.userDp.isNotEmpty
                ? null
                : Icon(
                    Icons.person,
                  ),
          ),
          title: Text(
            friend.userModel.userName,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FriendProfileScreen(
                  friendInfoModel: friend,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
