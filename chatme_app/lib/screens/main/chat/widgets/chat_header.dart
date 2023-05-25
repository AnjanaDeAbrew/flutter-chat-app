import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dude/components/custom_text.dart';
import 'package:dude/controllers/chat_controller.dart';
import 'package:dude/models/objects.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/providers/chat_provider.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:dude/utils/assets_constants.dart';
import 'package:dude/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer2<ChatProvider, AuthProvider>(
      builder: (context, value, auth, child) {
        var temp = value.conversationModel.usersArray
            .firstWhere((e) => e.uid != auth.userModel!.uid);
        return StreamBuilder<DocumentSnapshot>(
            stream: ChatController().getPeerUserOnlineStatus(temp.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: CustomText(
                    "No messages, error occured",
                    fontSize: 20,
                    color: AppColors.ashBorder,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              UserModel model = UserModel.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>);

              value.setPeerUser(model);
              return AppBar(
                toolbarHeight: 70,
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(model.img),
                      radius: 20,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.45,
                          child: CustomText(
                            model.name,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            // color: AppColors.kBlack,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        CustomText(
                          model.isOnline
                              ? "online"
                              : "last seen ${UtilFunctions.getTimeAgo(model.lastSeen)}",
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kAsh,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        AssetConstants.camIcon,
                        width: 28,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        AssetConstants.phoneIcon,
                        width: 20,
                      ))
                ],
              );
            });
      },
    );
  }
}
