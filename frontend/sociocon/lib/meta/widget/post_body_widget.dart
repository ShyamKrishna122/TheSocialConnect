import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/post_model.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/posts.notifier.dart';
import 'package:sociocon/core/notifiers/user.info.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';
import 'package:sociocon/meta/widget/description_text.dart';
import 'package:sociocon/meta/widget/post_comment_widget.dart';
import 'package:sociocon/meta/widget/post_like_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'build_image_widget.dart';

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
                                  child: post.personDp.isEmpty
                                      ? Icon(
                                          Icons.person,
                                        )
                                      : null,
                                  backgroundImage: post.personDp.isNotEmpty
                                      ? NetworkImage(
                                          post.personDp,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          UserInfoModel userInfo =
                                              await Provider.of<
                                                          UserInfoNotifier>(
                                                      context,
                                                      listen: false)
                                                  .getUserProfile(
                                            context: context,
                                            userEmail: post.personEmail,
                                          );
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FriendProfileScreen(
                                                friendInfoModel: userInfo,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          child: Text(
                                            post.personName,
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
                                        "${showTimeAgo(post.postTime).toString()}",
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: post.imageType == false ||
                                    post.mediaUrls.length > 1
                                ? size.height * 0.46
                                : post.type == 2 &&
                                        post.imageType &&
                                        post.mediaUrls.length == 1
                                    ? size.height * 0.25
                                    : post.type == 1 &&
                                            post.imageType &&
                                            post.mediaUrls.length == 1
                                        ? size.height * 0.59
                                        : size.height * 0.46,
                            child: ListView.builder(
                              physics: PageScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: post.mediaUrls.length,
                              itemBuilder: (context, index) {
                                final media = post.mediaUrls[index];
                                return media["mediaType"] == '0'
                                    ? Container(
                                        width: size.width,
                                        child: AspectRatio(
                                          aspectRatio: post.imageType ==
                                                      false ||
                                                  post.mediaUrls.length > 1
                                              ? 1 / 1
                                              : post.type == 2 &&
                                                      post.imageType &&
                                                      post.mediaUrls.length == 1
                                                  ? 1.91 / 1
                                                  : post.type == 1 &&
                                                          post.imageType &&
                                                          post.mediaUrls
                                                                  .length ==
                                                              1
                                                      ? 4 / 5
                                                      : 1 / 1,
                                          child: BuildImage(
                                            post: post,
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
                            top: post.type == 2 &&
                                    post.imageType &&
                                    post.mediaUrls.length == 1
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
                                  postId: post.postId,
                                ),
                              ),
                              if (post.postId.toString().isNotEmpty)
                                PostCommentWidget(
                                  postId: post.postId,
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
                            post: post,
                            trimLines: 3,
                          ),
                        ),
                      ],
                    ),
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

  showTimeAgo(DateTime postTime) {
    return timeago.format(postTime);
  }
}
