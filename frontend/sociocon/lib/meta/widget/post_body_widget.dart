import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/post_model.dart';
import 'package:sociocon/core/notifiers/posts.notifier.dart';
import 'package:sociocon/meta/widget/posts_widget.dart';

class PostBodyWidget extends StatelessWidget {
  const PostBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: Provider.of<PostsNotifier>(context, listen: false).getPosts(
        userMail: 'sankee@gmail.com',
      ),
      builder: (context, snapshot) {
        return Container();
      },
    );
  }
}
