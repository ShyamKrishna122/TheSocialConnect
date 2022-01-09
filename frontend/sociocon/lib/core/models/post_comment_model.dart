import 'package:sociocon/core/models/user_model.dart';

class PostCommentModel {
  int commentId;
  DateTime commentTime;
  String commentText;
  UserInfoModel userInfoModel;

  PostCommentModel({
    required this.commentId,
    required this.commentTime,
    required this.commentText,
    required this.userInfoModel,
  });

  factory PostCommentModel.fromMap({required Map<String, dynamic> map}) {
    return PostCommentModel(
      commentId: map['commentId'],
      commentTime: DateTime.parse(map['commentTime']),
      commentText: map['commentText'],
      userInfoModel: UserInfoModel(
        userModel: UserModel(
          userId: map['user']['id'],
          userEmailId: map['user']['userEmail'],
          userName: map['user']['userName'],
        ),
        userFullName: map['user']['info']['name'],
        userDp: map['user']['info']['userDp'] == null
            ? ""
            : map['user']['info']['userDp'],
        userBio: map['user']['info']['userBio'],
      ),
    );
  }
}
