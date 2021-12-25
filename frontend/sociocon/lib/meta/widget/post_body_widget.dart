import 'package:flutter/material.dart';
import 'package:sociocon/core/models/post_model.dart';
import 'package:sociocon/meta/widget/posts_widget.dart';

class PostBodyWidget extends StatelessWidget {
  const PostBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return PostsWidget();
      },
    );
  }
}
