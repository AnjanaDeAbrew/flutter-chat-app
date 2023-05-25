import 'package:dude/components/custom_text.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/providers/notification_provider.dart';
import 'package:dude/screens/main/conversations/conversations.dart';
import 'package:dude/screens/main/profile/profile.dart';
import 'package:dude/screens/main/users/users.dart';
import 'package:dude/utils/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //---since using the observer anything that is observering must be initialize in init state function
    WidgetsBinding.instance.addObserver(this);

    //----get and update the dvice token
    Provider.of<NotficationProvider>(context, listen: false)
        .initNotification(context);

    //----handling foreground notifications
    Provider.of<NotficationProvider>(context, listen: false)
        .foreGroundHandler();

    //----handling when clicked on notifications to open the app from background notifications
    Provider.of<NotficationProvider>(context, listen: false)
        .onClickedOpenedApp(context);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        Provider.of<AuthProvider>(context, listen: false)
            .updateOnlineStates(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        Provider.of<AuthProvider>(context, listen: false)
            .updateOnlineStates(false);
        break;
    }

    Logger().w(state);
  }

  //------list to store bottom navigation screens
  final List<Widget> _screens = const [
    Conversations(),
    Users(),
    Profile(),
  ];

  //--------store the active index
  int activeIndex = 0;

  //-----ontap function
  void onItemTapped(int i) {
    setState(() {
      activeIndex = i;
    });
  }

  DateTime backPressedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _onBackButtonDoubleClicked(context),
        child: Scaffold(
          body: _screens[activeIndex],
          bottomNavigationBar: Container(
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              // boxShadow: [
              //   BoxShadow(
              //       offset: Offset(0, 1),
              //       color: Color.fromARGB(255, 229, 229, 229),
              //       blurRadius: 10),
              // ],
              // color: Colors.white
              // border: Border(
              //   top: BorderSide(width: 1.0, color: Colors.lightBlue.shade600),
              // ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                navigationIconAndText(
                    imgPath: AssetConstants.chatIcon,
                    index: 0,
                    text: "Chats",
                    width: 28),
                navigationIconAndText(
                    imgPath: AssetConstants.peopleIcon,
                    index: 1,
                    text: "Contacts",
                    width: 26),
                navigationIconAndText(
                    imgPath: AssetConstants.userIcon,
                    index: 2,
                    text: "Profile",
                    width: 19),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //--------custom container navigation bar item
  InkWell navigationIconAndText(
      {required int index,
      required String imgPath,
      required double width,
      required String text}) {
    return InkWell(
      onTap: () => onItemTapped(index),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            color: activeIndex == index
                ? const Color.fromARGB(255, 93, 57, 240)
                : const Color.fromARGB(255, 223, 223, 223),
            width: width,
          ),
          CustomText(
            text,
            fontSize: 12,
            color: activeIndex == index
                ? const Color.fromARGB(255, 93, 57, 240)
                : const Color.fromARGB(255, 223, 223, 223),
          )
        ],
      ),
    );
  }

  void toast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text,
          fontSize: 12,
        ),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.none,
        margin: const EdgeInsets.symmetric(horizontal: 100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<bool> _onBackButtonDoubleClicked(BuildContext context) async {
    final difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();
    if (difference >= const Duration(seconds: 2)) {
      toast(context, "Double tap to exit");
      return false;
    } else {
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
}
