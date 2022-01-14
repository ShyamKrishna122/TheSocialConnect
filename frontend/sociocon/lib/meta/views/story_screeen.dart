import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/story_model.dart';
import 'package:sociocon/core/notifiers/story_view.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/meta/widget/animated_bar.dart';
import 'package:sociocon/meta/widget/story_info.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({
    Key? key,
    required this.story,
    required this.seenStories,
  }) : super(key: key);

  final StoryModel story;
  final int seenStories;

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late PageController pageController;
  late AnimationController _animController;
  int _currentIndex = 0;
  late int _seenStories;

  @override
  void initState() {
    pageController = PageController();
    _animController = AnimationController(vsync: this);
    setState(() => _seenStories = widget.seenStories);
    if (_seenStories != 0 && _seenStories != widget.story.mediaUrls.length) {
      pageController = PageController(initialPage: _seenStories);
      setState(() => _currentIndex = _seenStories);
      _loadStory(animateToPage: false);
    } else {
      _loadStory(animateToPage: false);
    }
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.story.mediaUrls.length) {
            _currentIndex++;
            _loadStory();
          } else {
            Navigator.of(context).pop(_currentIndex);
          }
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final storyViewNotifier =
        Provider.of<StoryViewNotifier>(context, listen: false);
    final userInfo = Provider.of<UserNotifier>(context, listen: false).userInfo;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragEnd: (endDetails) {
          double? velocity = endDetails.primaryVelocity;

          if (velocity! >= 0) {
            Navigator.of(context).pop(_currentIndex);
          }
        },
        onTapDown: (detailes) => _onTapDown(detailes),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.story.mediaUrls.length,
              itemBuilder: (context, index) {
                final story = widget.story.mediaUrls[index];

                storyViewNotifier.setStoryViews(
                    storyMediaId: story['mediaId'],
                    userEmail: userInfo.userModel.userEmailId);

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: story['mediaUrl'],
                      fit: BoxFit.fitHeight,
                      fadeInDuration: Duration(milliseconds: 500),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 20,
                      left: 10,
                      child: Row(
                        children: [
                          Icon(
                            Icons.visibility_sharp,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FutureBuilder(
                            future: storyViewNotifier.getStoryViewCount(
                                storyMediaId: story['mediaId']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                  height: 0,
                                  width: 0,
                                );
                              }
                              return Text(
                                snapshot.data.toString(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              top: 30.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                children: [
                  Row(
                    children: [
                      ...widget.story.mediaUrls
                          .asMap()
                          .map((i, e) {
                            return MapEntry(
                                i,
                                AnimatedBar(
                                  animationController: _animController,
                                  position: i,
                                  currentIndex: _currentIndex,
                                ));
                          })
                          .values
                          .toList(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 1.5, vertical: 10.0),
                    child: StoryInfo(
                      height: size.height - 100,
                      story: widget.story,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final Size screenSize = MediaQuery.of(context).size;
    final double dx = details.globalPosition.dx;

    if (dx < screenSize.width / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex--;
          _loadStory();
        }
      });
    } else if (dx > 2 * screenSize.width / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.story.mediaUrls.length) {
          _currentIndex++;
          _loadStory();
        } else {
          Navigator.of(context).pop(_currentIndex);
        }
      });
    } else {}
  }

  void _loadStory({bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();
    _animController.duration = Duration(seconds: 10);
    _animController.forward();

    if (animateToPage) {
      pageController.animateToPage(_currentIndex,
          duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
    }
  }
}
