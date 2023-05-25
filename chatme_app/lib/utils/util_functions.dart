import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:timeago/timeago.dart' as timeago;

class UtilFunctions {
  //---------navoigator function
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static String getTimeAgo(String date) => timeago.format(DateTime.parse(date));

  //--select an image
  static Future<File?> pickImageFromGallery() async {
    try {
      File image = File("");
      // Pick an image
      final XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

//--------check if the user has picked the file or not
      if (pickedFile != null) {
        //------assigning the picked xFile object to the file object
        image = File(pickedFile.path);
        return image;
      } else {
        Logger().e("No image selected");
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  //--select product image
  static Future<File?> pickImageFromCamera() async {
    try {
      File image = File("");
      // Pick an image
      final XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        //------assigning the picked xFile object to the file object
        image = File(pickedFile.path);
        return image;
      } else {
        Logger().e("No image selected");
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }

//--------check if the user has picked the file or not
  }
}
