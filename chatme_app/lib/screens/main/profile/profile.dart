import 'package:dude/components/custom_button.dart';
import 'package:dude/components/custom_text.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/screens/main/conversations/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: size.width,
            child: Consumer<AuthProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Header(text: "Profile"),
                    ),
                    const SizedBox(height: 40),
                    CircleAvatar(
                      radius: 68,
                      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                      child: CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(value.firebaseUser!.photoURL!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomText(value.firebaseUser!.displayName!,
                        fontSize: 16, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    CustomText(value.firebaseUser!.email!),
                    SizedBox(height: size.height * 0.4),
                    CustomButton(
                      text: "Logout",
                      color: const Color.fromARGB(255, 218, 87, 87),
                      onTap: () {
                        value.logOut();
                      },
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
