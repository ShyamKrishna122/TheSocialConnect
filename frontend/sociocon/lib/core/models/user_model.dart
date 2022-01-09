class UserModel {
  String userId;
  String userEmailId;
  String? userPassword;
  String userName;

  UserModel({
    required this.userId,
    required this.userEmailId,
    this.userPassword,
    required this.userName,
  });
}

class UserInfoModel {
  UserModel userModel;
  String? userFullName;
  String userDp;
  String? userBio;

  UserInfoModel({
    required this.userModel,
    this.userFullName,
    this.userBio,
    required this.userDp,
  });

  factory UserInfoModel.fromMap({required Map<String, dynamic> map}) {
    return UserInfoModel(
      userDp: map['info']['userDp'] == null ? "" : map['info']['userDp'],
      userFullName: map['info']['name'],
      userBio: map['info']['userBio'],
      userModel: UserModel(
        userId: map['id'],
        userEmailId: map['userEmail'],
        userName: map['userName'],
      ),
    );
  }

  factory UserInfoModel.fromMapFollowerData({required Map<String, dynamic> map}) {
    return UserInfoModel(
      userDp: map['userDp'] == null ? "" : map['userDp'],
      userFullName: map['name'],
      userBio: map['userBio'],
      userModel: UserModel(
        userId: map['userId'],
        userEmailId: map['userEmail'],
        userName: map['userName'],
      ),
    );
  }
}
