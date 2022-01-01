import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageUtility {
  static Future<File?> getImage() async {
    final _image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (_image != null) {
      return File(_image.path);
    }
    return null;
  }
}
