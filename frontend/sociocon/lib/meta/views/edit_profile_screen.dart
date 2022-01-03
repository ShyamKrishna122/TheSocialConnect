import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/core/models/user_model.dart';
import 'package:sociocon/core/notifiers/user.info.notifier.dart';
import 'package:sociocon/core/notifiers/user.notifier.dart';
import 'package:sociocon/core/notifiers/utility.notifier.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final UserInfoModel userInfoModel =
          Provider.of<UserNotifier>(context, listen: false).userInfo;
      nameController = TextEditingController(
        text: userInfoModel.userFullName!,
      );
      bioController = TextEditingController(
        text: userInfoModel.userBio,
      );
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserInfoModel userInfoModel =
        Provider.of<UserNotifier>(context, listen: false).userInfo;
    final utilityNotifier =
        Provider.of<UtilityNotifier>(context, listen: false);
    final _userImage =
        Provider.of<UtilityNotifier>(context, listen: true).userImage;
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
            ),
            onPressed: () async {
              if (nameController.text.isNotEmpty ||
                  bioController.text.isNotEmpty) {
                if (nameController.text != userInfoModel.userFullName ||
                    bioController.text != userInfoModel.userBio ||
                    _userImage != userInfoModel.userDp) {
                  await Provider.of<UserInfoNotifier>(context, listen: false)
                      .updateProfile(
                    context: context,
                    userEmail: userInfoModel.userModel.userEmailId,
                    name: nameController.text.trim(),
                    userDp: _userImage!,
                    userBio: bioController.text.trim(),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage:
                    _userImage!.isNotEmpty ? NetworkImage(_userImage) : null,
                child: _userImage.isNotEmpty ? null : Icon(Icons.person),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
                  await utilityNotifier.uploadUserProfileImage(
                    userName: userInfoModel.userModel.userName,
                  );
                },
                child: Text(
                  "Change Profile Photo",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text(
                  "Name",
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextField(
              controller: bioController,
              decoration: InputDecoration(
                label: Text(
                  "Bio",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
