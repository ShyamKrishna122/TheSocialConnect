class PostModel {
  int postId;
  String personId;
  String personName;
  String personDp;
  String title;
  String description;
  List<Map<String, String>> mediaUrls;
  DateTime postTime;
  bool imageType = false;
  int type;

  PostModel({
    required this.postId,
    required this.personId,
    required this.personName,
    required this.title,
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
      title: map["postTitle"],
      description: map["postDescription"],
      personDp: map["userDp"],
      mediaUrls: map["postMedia"],
      postTime: map["postTime"],
      imageType: map["imageType"],
      type: map["type"],
    );
  }
}
