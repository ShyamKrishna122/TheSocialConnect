import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/story_model.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/story_view.notifier.dart';
import 'package:sociocon/core/notifiers/user.info.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/views/friend_profile_screen.dart';
import 'package:sociocon/meta/views/story_screeen.dart';

class StoryCircle extends StatefulWidget {
  final StoryModel story;
  final int i;
  final int option;

  StoryCircle({
    required this.story,
    required this.i,
    required this.option,
  });
  @override
  _StoryCircleState createState() => _StoryCircleState();
}

class _StoryCircleState extends State<StoryCircle> {
  int _seenStories = 0;
  @override
  void initState() {
    super.initState();

    _checkForSeenStories();
  }

  void _checkForSeenStories() async {
    int seenStories = 0;
    final storyViewNotifier =
        Provider.of<StoryViewNotifier>(context, listen: false);
    final userInfo = Provider.of<UserNotifier>(context, listen: false).userInfo;

    for (var data in widget.story.mediaUrls) {
      final isViewed = await storyViewNotifier.isStoryViewed(
          storyMediaId: data['mediaId'],
          userEmail: userInfo.userModel.userEmailId);
      if (isViewed) {
        seenStories++;
      }
    }

    if (!mounted) return;
    setState(() {
      _seenStories = seenStories;
    });
  }

  void _updateSeenStories(index) {
    setState(() => _seenStories = index + 1);
  }

  @override
  Widget build(BuildContext context) {
    Color circleColor;

    if (_seenStories == widget.story.mediaUrls.length) {
      circleColor = Colors.grey;
    } else {
      circleColor = Colors.blue;
    }
    return widget.option == 1
        ? StoryImage(circleColor, context)
        : Container(
            width: 70,
            margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StoryImage(circleColor, context),
                Expanded(
                  child: Text(
                    widget.i == 0 ? "Your story" : widget.story.personName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            ),
          );
  }

  Container StoryImage(Color circleColor, BuildContext context) {
    return Container(
      margin: widget.option == 1 ? null : EdgeInsets.all(5.0),
      height: widget.option == 1 ? 40 : 60,
      width: widget.option == 1 ? 40 : 60,
      padding: widget.option == 1 ? null : const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            widget.option == 1 && _seenStories == widget.story.mediaUrls.length
                ? null
                : Border.all(
                    width: 3.0,
                    color: circleColor,
                  ),
      ),
      child: GestureDetector(
        onTap: () async {
          if (widget.option == 0) {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => StoryScreen(
                  story: widget.story,
                  seenStories: _seenStories,
                ),
              ),
            )
                .then((value) {
              _updateSeenStories(value);
            });
          } else if (_seenStories == widget.story.mediaUrls.length &&
              widget.option == 1) {
            UserInfoModel userInfo =
                await Provider.of<UserInfoNotifier>(context, listen: false)
                    .getUserProfile(
              context: context,
              userEmail: widget.story.personEmail,
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FriendProfileScreen(
                  friendInfoModel: userInfo,
                ),
              ),
            );
          }
        },
        child: ClipOval(
          child: widget.story.personDp.isNotEmpty
              ? Image.network(
                  widget.story.personDp,
                  height: widget.option == 1 ? 40 : 60,
                  width: widget.option == 1 ? 40 : 60,
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.person,
                ),
        ),
      ),
    );
  }
}
