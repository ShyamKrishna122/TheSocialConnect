import 'package:flutter/material.dart';
import 'package:sociocon/core/models/post_model.dart';
import 'package:sociocon/meta/widget/post_widget.dart';

class MyPostList extends StatefulWidget {
  const MyPostList({
    Key? key,
    required this.postId,
    required this.posts,
  }) : super(key: key);

  final int postId;
  final List<PostModel> posts;

  @override
  _MyPostListState createState() => _MyPostListState();
}

class _MyPostListState extends State<MyPostList> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => scrollListener());
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    int index = widget.posts.indexWhere((post) => post.postId == widget.postId);
    scrollController.animateTo(
        index * MediaQuery.of(context).size.height * 0.60,
        duration: Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Feeds"),
        centerTitle: true,
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        children: [
          ...widget.posts.map((post) {
            return PostWidget(
              post: post,
            );
          }).toList(),
        ],
      ),
    );
  }
}
