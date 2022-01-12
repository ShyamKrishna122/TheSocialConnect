import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/app/routes/app.routes.dart';
import 'package:sociocon/core/models/post_model.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/follow.notifier.dart';
import 'package:sociocon/core/notifiers/posts.notifier.dart';
import 'package:sociocon/core/notifiers/user.info.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/views/followers_screen.dart';
import 'package:sociocon/meta/views/following_screen.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';
import 'package:sociocon/meta/widget/build_image_widget.dart';
import 'package:sociocon/meta/widget/custom_info_widget.dart';
import 'package:sociocon/meta/widget/description_text.dart';
import 'package:sociocon/meta/widget/my_post_list.dart';
import 'package:sociocon/meta/widget/post_comment_widget.dart';
import 'package:sociocon/meta/widget/post_like_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context).userInfo;
    final postNotifier = Provider.of<PostsNotifier>(context, listen: false);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: userInfoModel.userDp.isNotEmpty
                              ? NetworkImage(userInfoModel.userDp)
                              : null,
                          child: userInfoModel.userDp.isNotEmpty
                              ? null
                              : Icon(Icons.person),
                        ),
                      ),
                      CustomInfoWidget(
                        option: 1,
                        userEmail: userInfoModel.userModel.userEmailId,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FollowersScreen(
                                userEmail: userInfoModel.userModel.userEmailId,
                              ),
                            ),
                          );
                        },
                        child: CustomInfoWidget(
                          option: 2,
                          userEmail: userInfoModel.userModel.userEmailId,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FollowingScreen(
                                userEmail: userInfoModel.userModel.userEmailId,
                              ),
                            ),
                          );
                        },
                        child: CustomInfoWidget(
                          option: 3,
                          userEmail: userInfoModel.userModel.userEmailId,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userInfoModel.userFullName!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        userInfoModel.userBio!,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      EditProfileRoute,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    height: 30,
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Text(
                      "Edit Profile",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.photo,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.video_camera_back,
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              children: [
                FutureBuilder<List<PostModel>>(
                  future: postNotifier.getMyPosts(
                    userMail: userInfoModel.userModel.userEmailId,
                    userInfoModel: userInfoModel,
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
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: posts!.length,
                      itemBuilder: (context, index) {
                        final PostModel post = posts![index];
                        return Container(
                          margin: const EdgeInsets.only(
                            top: 5,
                            left: 5,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MyPostList(
                                    postId: post.postId,
                                    posts: posts!,
                                  ),
                                ),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: post.mediaUrls[0]["mediaUrl"],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Container(
                  child: Text(
                    "HII",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
