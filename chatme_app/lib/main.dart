import 'package:dude/providers/auth_provider.dart';
import 'package:dude/providers/chat_provider.dart';
import 'package:dude/providers/notification_provider.dart';
import 'package:dude/screens/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //---initializing FCMpermission
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
      ChangeNotifierProvider(create: (context) => NotficationProvider()),
    ],
    child: const MyApp(),
  ));
}

//----background notification handler when the device in on terminated state
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor mycolor = const MaterialColor(0xFFA2A2A2, <int, Color>{
      50: Color.fromRGBO(0, 0, 0, 0),
      100: Color.fromRGBO(0, 0, 0, 0),
      200: Color.fromRGBO(0, 0, 0, 0),
      300: Color.fromRGBO(0, 0, 0, 0),
      500: Color.fromRGBO(0, 0, 0, 0),
      600: Color.fromRGBO(0, 0, 0, 0),
      700: Color.fromRGBO(0, 0, 0, 0),
      400: Color.fromRGBO(0, 0, 0, 0),
      800: Color.fromRGBO(0, 0, 0, 0),
      900: Color.fromRGBO(0, 0, 0, 0),
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          iconTheme: IconThemeData(color: mycolor),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: mycolor)
              .copyWith(background: Colors.black)),
      home: const Splash(),
      // darkTheme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData.dark(),
      builder: (context, child) => ResponsiveWrapper.builder(child,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
    );
  }
}
