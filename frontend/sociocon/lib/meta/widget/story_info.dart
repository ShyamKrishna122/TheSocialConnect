import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/story_model.dart';
import 'package:sociocon/core/notifiers/story_view.notifier.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoryInfo extends StatelessWidget {
  final StoryModel story;
  final double height;
  const StoryInfo({
    required this.story,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final storyViewNotifier =
        Provider.of<StoryViewNotifier>(context, listen: false);
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildUserInfo(storyViewNotifier),
        ],
      ),
    );
  }

  _buildUserInfo(StoryViewNotifier storyViewNotifier) {
    return Container(
      height: 70,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: story.personDp.isEmpty
                        ? null
                        : NetworkImage(story.personDp),
                    child: story.personDp.isEmpty
                        ? null
                        : Icon(
                            Icons.person,
                          ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            story.personName,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          //UserBadges(user: user, size: 20),
                        ],
                      ),
                      Text(
                        '${timeago.format(
                          story.storyTime,
                        )}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: null,
              )
            ],
          ),
        ],
      ),
    );
  }
}
