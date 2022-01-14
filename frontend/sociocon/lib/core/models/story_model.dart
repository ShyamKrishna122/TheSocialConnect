class StoryModel {
  final int storyId;
  final DateTime storyTime;
  final String personId;
  final String personEmail;
  final String personName;
  final String personDp;
  final List<Map<String, dynamic>> mediaUrls;

  StoryModel({
    required this.storyId,
    required this.storyTime,
    required this.personId,
    required this.personEmail,
    required this.personName,
    required this.personDp,
    required this.mediaUrls,
  });

  factory StoryModel.fromMap({required Map<String, dynamic> map}) {
    return StoryModel(
      storyId: map["storyId"],
      personId: map["userId"],
      personEmail: map["userEmail"],
      personName: map["userName"],
      personDp: map["userDp"],
      mediaUrls: map["storyMedia"],
      storyTime: DateTime.parse(map["storyTime"]),
    );
  }
}
