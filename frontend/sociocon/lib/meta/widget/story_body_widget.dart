import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/story_model.dart';
import 'package:sociocon/core/notifiers/story.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/widget/blank_story_circle.dart';
import 'package:sociocon/meta/widget/story_circle.dart';

class StoryBodyWigdet extends StatelessWidget {
  const StoryBodyWigdet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storyNotifier = Provider.of<StoriesNotifier>(context, listen: false);
    final userInfo = Provider.of<UserNotifier>(context, listen: false).userInfo;
    return FutureBuilder<List<StoryModel>>(
        future: storyNotifier.getStories(
          userMail: userInfo.userModel.userEmailId,
        ),
        builder: (context, AsyncSnapshot<List<StoryModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<StoryModel>? stories = [];
          if (snapshot.hasData) {
            StoryModel myStory = snapshot.data!.firstWhere(
              (element) => element.personId == userInfo.userModel.userId,
              orElse: () => StoryModel(
                storyId: -1,
                storyTime: DateTime.now(),
                personId: '',
                personEmail: '',
                personName: '',
                personDp: '',
                mediaUrls: [{}],
              ),
            );
            stories.insert(0, myStory);
            if (myStory.storyId != -1) {
              snapshot.data!.removeWhere(
                  (element) => element.personId == userInfo.userModel.userId);
            }
            for (var data in snapshot.data!.toList()) {
              stories.add(data);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (context, index) {
                final story = stories[index];
                if (index == 0 && story.storyId == -1)
                  return BlankStoryCircle(
                    story: story,
                  );
                return StoryCircle(
                  story: story,
                  i:index,
                );
              },
            ),
          );
        });
  }
}
