import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/post_comment_model.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/post_comment.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';
import 'package:sociocon/meta/views/search_friend_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCommentWidget extends StatefulWidget {
  const PostCommentWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final int postId;

  @override
  State<PostCommentWidget> createState() => _PostCommentWidgetState();
}

class _PostCommentWidgetState extends State<PostCommentWidget> {
  @override
  Widget build(BuildContext context) {
    final commentNotifier =
        Provider.of<PostCommentNotifier>(context, listen: false);
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context, listen: false).userInfo;
    return Container(
      width: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              showCommentSheet(
                context,
              );
            },
            child: Icon(
              Icons.comment,
              size: 22.0,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FutureBuilder(
              future:
                  commentNotifier.getPostCommentsCount(postId: widget.postId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 0,
                    width: 0,
                  );
                }
                return Text(
                  snapshot.data.toString(),
                  style: TextStyle(
                    // color: ThemeService.getValue()
                    //     ? Colors.white.withOpacity(0.8)
                    //     : Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  showCommentSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(ctx).size.height * 0.75,
            width: MediaQuery.of(ctx).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 150.0,
                  ),
                  child: Divider(
                    thickness: 4,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                CommentBodyWidget(
                  postId: widget.postId,
                ),
                FeedCommentInputWidget(
                  postId: widget.postId,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CommentBodyWidget extends StatefulWidget {
  final int postId;
  const CommentBodyWidget({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentBodyWidget> createState() => _CommentBodyWidgetState();
}

class _CommentBodyWidgetState extends State<CommentBodyWidget> {
  @override
  Widget build(BuildContext context) {
    final commentNotifier =
        Provider.of<PostCommentNotifier>(context, listen: false);
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context, listen: false).userInfo;
    return Expanded(
      child: FutureBuilder<List<PostCommentModel>>(
        future: commentNotifier.getPostComments(
          postId: widget.postId,
        ),
        builder: (context, AsyncSnapshot<List<PostCommentModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data!.length > 0
              ? ListView(
                  children: snapshot.data!.map((comment) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    radius: 15,
                                    child: comment.userInfoModel.userDp.isEmpty
                                        ? Icon(
                                            Icons.person,
                                          )
                                        : null,
                                    backgroundImage: NetworkImage(
                                      comment.userInfoModel.userDp,
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (userInfoModel.userModel.userId ==
                                        comment
                                            .userInfoModel.userModel.userId) {
                                      print("hii");
                                    } else {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FriendProfileScreen(
                                            friendInfoModel:
                                                comment.userInfoModel,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    comment.userInfoModel.userModel.userName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      //     : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_upward,
                                          // color: ThemeService.getValue()
                                          //     ? Colors.white
                                          //     : Colors.black,
                                          size: 16),
                                      onPressed: () {},
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        // color: ThemeService.getValue()
                                        //     ? Colors.white
                                        //     : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.reply,
                                          // color: ThemeService.getValue()
                                          //     ? Colors.white
                                          //     : Colors.black,
                                          size: 16),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 5.0,
                                ),
                                child: Text(
                                  "${showTimeAgo(comment.commentTime).toString()}",
                                  style: TextStyle(
                                      // color: ThemeService.getValue()
                                      //     ? Colors.white
                                      //         .withOpacity(0.8)
                                      //     : Colors.black87,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.blue,
                                    size: 12.0,
                                  ),
                                  onPressed: () {},
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: Text(
                                    comment.commentText,
                                    style: TextStyle(
                                      // color: ThemeService.getValue()
                                      //     ? Colors.white
                                      //     : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                if (userInfoModel.userModel.userId ==
                                    comment.userInfoModel.userModel.userId)
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      //delete comment.
                                      await commentNotifier.deleteComment(
                                        postId: widget.postId,
                                        userEmail:
                                            userInfoModel.userModel.userEmailId,
                                      );
                                      setState(() {});
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              : Center(
                  child: Text(
                    'No comments',
                  ),
                );
        },
      ),
    );
  }

  showTimeAgo(DateTime postTime) {
    return timeago.format(postTime);
  }
}

class FeedCommentInputWidget extends StatefulWidget {
  const FeedCommentInputWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final int postId;
  @override
  _FeedCommentInputWidgetState createState() => _FeedCommentInputWidgetState();
}

class _FeedCommentInputWidgetState extends State<FeedCommentInputWidget> {
  final TextEditingController commentController = TextEditingController();
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentNotifier =
        Provider.of<PostCommentNotifier>(context, listen: false);
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context, listen: false).userInfo;
    return Container(
      width: 400,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 300.0,
            child: TextField(
              controller: commentController,
              textCapitalization: TextCapitalization.sentences,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Add Comment...",
                hintStyle: TextStyle(
                  //color: ThemeService.getValue() ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextStyle(
                //color: ThemeService.getValue() ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.greenAccent,
            child: Icon(
              Icons.comment,
              color: Colors.white,
            ),
            onPressed: () async {
              if (commentController.text.isNotEmpty) {
                await commentNotifier
                    .addComment(
                      postId: widget.postId,
                      userEmail: userInfoModel.userModel.userEmailId,
                      commentText: commentController.text.trim(),
                    )
                    .whenComplete(
                      () => commentController.clear(),
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}
