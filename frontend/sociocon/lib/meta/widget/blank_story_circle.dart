import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/story_model.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';

class BlankStoryCircle extends StatelessWidget {
  final StoryModel story;
  BlankStoryCircle({
    required this.story,
  });
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserNotifier>(context, listen: false).userInfo;
    double size = 60;
    return Container(
      width: size + 10,
      margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                height: size,
                width: size,
                padding: const EdgeInsets.all(2),
                decoration: story.storyId != -1
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3.0, color: Colors.grey),
                      )
                    : null,
                child: GestureDetector(
                  onTap: () {},
                  child: ClipOval(
                    child: userInfo.userDp.isNotEmpty
                        ? Image.network(
                            userInfo.userDp,
                            height: 60.0,
                            width: 60.0,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                          ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //color: Colors.white,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.blue,
                      size: size == 60 ? 21 : 30,
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Text(
              "Your story",
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }
}
