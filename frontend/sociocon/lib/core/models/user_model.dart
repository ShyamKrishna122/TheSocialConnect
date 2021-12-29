class UserModel {
  String? userId;
  String? userEmailId;
  String? userPassword;
  String? userName;

  UserModel({
    this.userId,
    this.userEmailId,
    this.userPassword,
    this.userName,
  });

  factory UserModel.fromMap({required Map<String, dynamic> map}) {
    return UserModel(
      userId: map['id'],
      userEmailId: map['userEmail'],
      userPassword: map['userPassword'],
      userName: map['userName'],
    );
  }
}

class UserInfoModel {
  UserModel? userModel;
  String? userFullName;
  String? userDp;
  String? userBio;

  UserInfoModel({
    this.userModel,
    this.userFullName,
    this.userBio,
    this.userDp,
  });
}
