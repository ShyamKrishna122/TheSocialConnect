import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sociocon/core/notifiers/auth.notifier.dart';
import 'package:sociocon/core/notifiers/follow.notifier.dart';
import 'package:sociocon/core/notifiers/page.notifier.dart';
import 'package:sociocon/core/notifiers/post_comment.notifier.dart';
import 'package:sociocon/core/notifiers/post_like.notifier.dart';
import 'package:sociocon/core/notifiers/posts.notifier.dart';
import 'package:sociocon/core/notifiers/story.notifier.dart';
import 'package:sociocon/core/notifiers/story_view.notifier.dart';
import 'package:sociocon/core/notifiers/user.info.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/core/notifiers/utility.notifier.dart';

List<SingleChildWidget> providers = [...remoteProviders];

//Independent Providers
List<SingleChildWidget> remoteProviders = [
  ChangeNotifierProvider(
    create: (context) => PostsNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => AuthenticationNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => UserNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => UserInfoNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => UtilityNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => FollowNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => PageNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => PostLikeNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => PostCommentNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => StoriesNotifier(),
  ),
  ChangeNotifierProvider(
    create: (context) => StoryViewNotifier(),
  ),
];
