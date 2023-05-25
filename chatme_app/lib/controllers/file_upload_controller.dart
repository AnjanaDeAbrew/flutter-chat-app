import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class FileUploadController {
  //------upload picked image file to the firebase storage bucket in the given directory path.create folder to save images

  Future<String> uploadFile(File file, String folderPath) async {
    try {
//--------getting the firebase from the file path
      final String fileName = basename(file.path);

//--------defining the firebase storage destination
      final String destination = "$folderPath/$fileName";

//---creating the firebase storage reference with the destination file location
      final ref = FirebaseStorage.instance.ref(destination);

//---------uploading the file
      UploadTask task = ref.putFile(file);

//---------wait until the uploading task is completed
      final snapshot = await task.whenComplete(() {});

      //-------getting the downloaded url of the uploaded file
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Logger().e(e);
      return "";
    }
  }
}
