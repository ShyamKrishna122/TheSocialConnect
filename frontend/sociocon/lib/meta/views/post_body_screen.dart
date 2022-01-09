import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/post_model.dart';
import 'package:sociocon/core/notifiers/posts.notifier.dart';
import 'package:sociocon/meta/widget/post_body_widget.dart';
import 'package:sociocon/meta/widget/posts_widget.dart';
import 'package:sociocon/meta/widget/story_body_widget.dart';

class PostBodyScreen extends StatelessWidget {
  const PostBodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StoryBodyWigdet(),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          PostBodyWidget(),
        ],
      ),
    );
  }
}
