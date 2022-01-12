import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/post_model.dart';
import 'package:sociocon/core/notifiers/posts.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/widget/post_widget.dart';

class PostBodyWidget extends StatelessWidget {
  const PostBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserNotifier>(context, listen: false).userInfo;
    final size = MediaQuery.of(context).size;
    return FutureBuilder<List<PostModel>>(
      future: Provider.of<PostsNotifier>(context, listen: false).getPosts(
        userMail: userInfo.userModel.userEmailId,
      ),
      builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<PostModel>? posts = [];
        if (snapshot.hasData) {
          posts = snapshot.data;
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return posts!.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final PostModel post = posts![index];
                  return PostWidget(
                    post: post,
                  );
                },
              )
            : Center(
                child: Text(
                  "No posts",
                ),
              );
      },
    );
  }
}
