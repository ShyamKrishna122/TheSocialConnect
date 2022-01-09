import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/post_like.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';

class PostLikeWidget extends StatefulWidget {
  const PostLikeWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  final int postId;

  @override
  State<PostLikeWidget> createState() => _PostLikeWidgetState();
}

class _PostLikeWidgetState extends State<PostLikeWidget> {
  @override
  Widget build(BuildContext context) {
    final likeNotifier = Provider.of<PostLikeNotifier>(context, listen: false);
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context, listen: false).userInfo;
    return Container(
      width: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
            future: likeNotifier.isPostLiked(
              postId: widget.postId,
              userEmail: userInfoModel.userModel.userEmailId,
            ),
            builder: (context, snapshot) {
              final isLiked = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GestureDetector(
                onLongPress: () {
                  showLikesSheet(
                    widget.postId,
                  );
                },
                onTap: () async {
                  if (isLiked == true) {
                    await likeNotifier.removeLike(
                      postId: widget.postId,
                      userEmail: userInfoModel.userModel.userEmailId,
                    );
                  } else {
                    await likeNotifier.addLike(
                      postId: widget.postId,
                      userEmail: userInfoModel.userModel.userEmailId,
                    );
                  }
                  setState(() {});
                },
                child: Icon(
                  isLiked == true ? Icons.favorite : Icons.favorite_outline,
                  size: 22.0,
                  color: Colors.red,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FutureBuilder(
              future: likeNotifier.getLikesCount(
                postId: widget.postId,
              ),
              builder: (context, snapshot) {
                final likesCount = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 0,
                    width: 0,
                  );
                }
                return Text(
                  likesCount.toString(),
                  style: TextStyle(
                    // color: ThemeService.getValue()
                    //     ? Colors.white
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

  showLikesSheet(int postId) {
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
                    "Likes",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              LikeBodyWidget(
                postId: postId,
              ),
            ],
          ),
        );
      },
    );
  }
}

class LikeBodyWidget extends StatelessWidget {
  final int postId;

  const LikeBodyWidget({required this.postId});
  @override
  Widget build(BuildContext context) {
    final likeNotifier = Provider.of<PostLikeNotifier>(context, listen: false);
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context, listen: false).userInfo;
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<UserInfoModel>>(
        future: likeNotifier.getPersonList(
          postId: postId,
        ),
        builder: (context, AsyncSnapshot<List<UserInfoModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.length > 0
              ? ListView(
                  children: snapshot.data!.map(
                    (info) {
                      return ListTile(
                        leading: GestureDetector(
                          child: CircleAvatar(
                            child: info.userDp.toString().isEmpty
                                ? Icon(
                                    Icons.person,
                                  )
                                : null,
                            backgroundImage: info.userDp.toString().isNotEmpty
                                ? NetworkImage(
                                    info.userDp,
                                  )
                                : null,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                        title: GestureDetector(
                          onTap: () {
                            if (userInfoModel.userModel.userId ==
                                info.userModel.userId) {
                              print("hii");
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FriendProfileScreen(
                                    friendInfoModel: info,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            info.userModel.userName,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          info.userBio!,
                          style: TextStyle(
                            // color:
                            //     ThemeService.getValue() ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        // trailing:  ==
                        //         info["personId"]
                        //     ? null
                        //     : MaterialButton(
                        //         child: Text(
                        //           "Chat",
                        //           style: TextStyle(
                        //             color: ThemeService.getValue()
                        //                 ? Colors.white
                        //                 : Colors.black,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 14.0,
                        //           ),
                        //         ),
                        //         color: Colors.blue,
                        //         onPressed: () {},
                        //       ),
                      );
                    },
                  ).toList(),
                )
              : Center(
                  child: Text(
                    'No likes',
                  ),
                );
        },
      ),
    );
  }
}
