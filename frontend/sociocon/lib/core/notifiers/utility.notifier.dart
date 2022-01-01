import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:sociocon/app/credentials/cloudinary.credentials.dart';
import 'package:sociocon/meta/utils/pick_image.utils.dart';

class UtilityNotifier extends ChangeNotifier {
  String? _userImage = "";

  String? get userImage => _userImage;

  Future uploadUserProfileImage({
    required String? userName,
  }) async {
    final _cloudinary = Cloudinary(
      CloudinaryCredentials.APIKey,
      CloudinaryCredentials.APISecret,
      CloudinaryCredentials.CloudName,
    );
    try {
      final _image = await ImageUtility.getImage();
      await _cloudinary
          .uploadFile(
        filePath: _image!.path,
        fileName: "$userName-profile",
        resourceType: CloudinaryResourceType.image,
        folder: "TheSocioCon",
      )
          .then((value) {
        _userImage = value.url;
        notifyListeners();
        return _userImage;
      });
    } catch (error) {
      print(error);
    }
  }
}
