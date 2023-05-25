import 'package:dude/components/custom_button.dart';
import 'package:dude/components/custom_text.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:dude/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Drawer(
            width: 350,
            child: Material(
              child: ListView(
                children: [
                  if (value.firebaseUser != null)
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1528465424850-54d22f092f9d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y292ZXIlMjBwaG90b3xlbnwwfHwwfHw%3D&w=1000&q=80'),
                            fit: BoxFit.cover),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 20,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(value.firebaseUser!.photoURL!),
                          radius: 34,
                        ),
                      ),
                      accountName: CustomText(
                        value.firebaseUser!.displayName!,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      accountEmail: CustomText(
                        value.firebaseUser!.email!,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  // CustomContainer('Account',
                  //     icon: Icons.account_circle_rounded, widget: const Profile()),
                  // CustomContainer('Favourites',
                  //     icon: Icons.favorite_outlined, widget: const Favourite()),
                  // CustomContainer('Chat',
                  //     icon: Icons.chat, widget: const MainChatScreen()),
                  // CustomContainer('Bookings',
                  //     icon: Icons.book, widget: const MainBookingPage()),
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      text: "Logout",
                      onTap: () {
                        value.logOut();
                      },
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

//----------------custom container for one item of list view
  InkWell CustomContainer(
    String text, {
    required IconData icon,
    required Widget widget,
    // Future<void>? function,
  }) {
    return InkWell(
      onTap: () {
        // function;
        UtilFunctions.navigateTo(context, widget);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),

        // color: Colors.amber,
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: AppColors.ashBorder,
            ),
            const SizedBox(width: 20),
            CustomText(
              text,
              color: AppColors.kBlack,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.left,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: AppColors.ashBorder,
            ),
          ],
        ),
      ),
    );
  }
}
