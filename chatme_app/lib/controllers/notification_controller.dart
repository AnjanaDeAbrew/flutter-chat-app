import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class NotificationController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //-save user device token in the user data
  Future<void> saveNotificationoken(String uid, String token) async {
    await users
        .doc(uid)
        .update(
          {
            'token': token,
          },
        )
        .then((value) => Logger().i("Device token updated"))
        .catchError((error) => Logger().e("Failed to update token: $error"));
  }
}
