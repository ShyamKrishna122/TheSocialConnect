class PostModel {
  int postId;
  String personId;
  String personName;
  String personDp;
  String description;
  List<Map<String, dynamic>> mediaUrls;
  DateTime postTime;
  bool imageType = false;
  int type;

  PostModel({
    required this.postId,
    required this.personId,
    required this.personName,
    required this.description,
    required this.personDp,
    required this.mediaUrls,
    required this.postTime,
    required this.imageType,
    required this.type,
  });

  factory PostModel.fromMap({required Map<String, dynamic> map}) {
    return PostModel(
      postId: map["postId"],
      personId: map["userId"],
      personName: map["userName"],
      description: map["postDescription"],
      personDp: map["userDp"],
      mediaUrls: map["postMedia"],
      postTime: DateTime.parse(map["postTime"]),
      imageType: map["postImageType"],
      type: map["postType"],
    );
  }
}
