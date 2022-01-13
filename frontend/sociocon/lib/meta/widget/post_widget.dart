import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/post_model.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/posts.notifier.dart';
import 'package:sociocon/core/notifiers/user.info.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';
import 'package:sociocon/meta/widget/build_image_widget.dart';
import 'package:sociocon/meta/widget/description_text.dart';
import 'package:sociocon/meta/widget/post_comment_widget.dart';
import 'package:sociocon/meta/widget/post_like_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userInfo = Provider.of<UserNotifier>(context, listen: false).userInfo;
    final postNotifier = Provider.of<PostsNotifier>(context, listen: false);
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    radius: 20.0,
                    child: widget.post.personDp.isEmpty
                        ? Icon(
                            Icons.person,
                          )
                        : null,
                    backgroundImage: widget.post.personDp.isNotEmpty
                        ? NetworkImage(
                            widget.post.personDp,
                          )
                        : null,
                    backgroundColor: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            UserInfoModel userInfo =
                                await Provider.of<UserInfoNotifier>(context,
                                        listen: false)
                                    .getUserProfile(
                              context: context,
                              userEmail: widget.post.personEmail,
                            );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FriendProfileScreen(
                                  friendInfoModel: userInfo,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              widget.post.personName,
                              style: TextStyle(
                                // color: ThemeService.getValue()
                                //     ? Colors.greenAccent
                                //     : Colors.greenAccent[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "${showTimeAgo(widget.post.postTime).toString()}",
                          style: TextStyle(
                              // color: ThemeService.getValue()
                              //     ? Colors.white
                              //         .withOpacity(0.8)
                              //     : Colors.black87,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                if (widget.post.personId == userInfo.userModel.userId)
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                    ),
                    onPressed: () {
                      showOptionsDialog(
                        context,
                      );
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              height: widget.post.imageType == false ||
                      widget.post.mediaUrls.length > 1
                  ? size.height * 0.46
                  : widget.post.type == 2 &&
                          widget.post.imageType &&
                          widget.post.mediaUrls.length == 1
                      ? size.height * 0.25
                      : widget.post.type == 1 &&
                              widget.post.imageType &&
                              widget.post.mediaUrls.length == 1
                          ? size.height * 0.59
                          : size.height * 0.46,
              child: ListView.builder(
                physics: PageScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.post.mediaUrls.length,
                itemBuilder: (context, index) {
                  final media = widget.post.mediaUrls[index];
                  return media["mediaType"] == '0'
                      ? Container(
                          width: size.width,
                          child: AspectRatio(
                            aspectRatio: widget.post.imageType == false ||
                                    widget.post.mediaUrls.length > 1
                                ? 1 / 1
                                : widget.post.type == 2 &&
                                        widget.post.imageType &&
                                        widget.post.mediaUrls.length == 1
                                    ? 1.91 / 1
                                    : widget.post.type == 1 &&
                                            widget.post.imageType &&
                                            widget.post.mediaUrls.length == 1
                                        ? 4 / 5
                                        : 1 / 1,
                            child: BuildImage(
                              post: widget.post,
                              imageUrl: media["mediaUrl"],
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: widget.post.type == 2 &&
                      widget.post.imageType &&
                      widget.post.mediaUrls.length == 1
                  ? 3.0
                  : 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: PostLikeWidget(
                    postId: widget.post.postId,
                  ),
                ),
                if (widget.post.postId.toString().isNotEmpty)
                  PostCommentWidget(
                    postId: widget.post.postId,
                  ),
                // Spacer(),
                // IconButton(
                //   icon: Icon(Icons.more_vert),
                //   onPressed: () {},
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
            ),
            child: DescriptionText(
              post: widget.post,
              trimLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  showTimeAgo(DateTime postTime) {
    return timeago.format(postTime);
  }

  showOptionsDialog(BuildContext context) {
    final postNotifier = Provider.of<PostsNotifier>(context, listen: false);
    final userInfo = Provider.of<UserNotifier>(context, listen: false).userInfo;
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
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
                    "Settings",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  'Delete Post',
                ),
                onPressed: () async {
                  await postNotifier
                      .deleteMyPosts(
                    postId: widget.post.postId,
                    userEmail: userInfo.userModel.userEmailId,
                  )
                      .then(
                    (value) {
                      if (value == true) {
                        Navigator.of(context).pop();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
