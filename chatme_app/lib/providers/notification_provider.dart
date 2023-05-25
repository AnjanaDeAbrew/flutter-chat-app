import 'package:dude/controllers/notification_controller.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/providers/chat_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class NotficationProvider extends ChangeNotifier {
  final NotificationController _notificationController =
      NotificationController();

  //-initialize notifications and get the device token
  Future<void> initNotification(BuildContext context) async {
    // Get the token each time the application loads
    await FirebaseMessaging.instance.getToken().then(
      (value) {
        Logger().wtf(value);
        startSaveToken(context, value!);
      },
    );
  }

  //-save notification token in db
  Future<void> startSaveToken(BuildContext context, String token) async {
    try {
      //-first get user uid from user model
      String uid =
          Provider.of<AuthProvider>(context, listen: false).userModel!.uid;

      //-then starting saving
      await _notificationController
          .saveNotificationoken(uid, token)
          .then((value) {
        //--updating the token foeld with device token
        Provider.of<AuthProvider>(context, listen: false).setDeviceToken(token);
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //-------handle foreground notifications
  void foreGroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().w('Got a message whilst in the foreground!');
      Logger().w('Message data: ${message.data}');

      if (message.notification != null) {
        Logger().wtf(
            'Message also contained a notification: ${message.notification!.toMap()}');
      }
    });
  }

  void onClickedOpenedApp(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Logger().w('/////////////---clicked notification open the app');
      Logger().w('Message data: ${message.data}');

      if (message.notification != null) {
        Provider.of<ChatProvider>(context, listen: false)
            .setNotificationData(context, message.data['conId']);
      }
    });
  }
}
