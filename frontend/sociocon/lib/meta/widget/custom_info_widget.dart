import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/follow.notifier.dart';
import 'package:sociocon/core/notifiers/posts.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';

class CustomInfoWidget extends StatelessWidget {
  const CustomInfoWidget({
    Key? key,
    required this.option,
    required this.userEmail,
  }) : super(key: key);

  final int option;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    final postNotifier = Provider.of<PostsNotifier>(context, listen: false);
    final followNotifier = Provider.of<FollowNotifier>(context, listen: false);
    return FutureBuilder(
      future: option == 1
          ? postNotifier.getPostsCount(
              userEmail: userEmail,
            )
          : option == 2
              ? followNotifier.getFollowersCount(
                  userEmail: userEmail,
                )
              : followNotifier.getFollowingCount(
                  userEmail: userEmail,
                ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 0,
            width: 0,
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(snapshot.data.toString()),
            Text(
              option == 1
                  ? "Posts"
                  : option == 2
                      ? "Followers"
                      : "Following",
            ),
          ],
        );
      },
    );
  }
}
