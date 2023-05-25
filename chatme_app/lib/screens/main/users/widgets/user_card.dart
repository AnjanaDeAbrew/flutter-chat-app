import 'package:badges/badges.dart' as badges;
import 'package:dude/components/custom_text.dart';
import 'package:dude/models/objects.dart';
import 'package:dude/providers/chat_provider.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:dude/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class UsersCard extends StatelessWidget {
  const UsersCard({
    super.key,
    required this.model,
    required this.index,
  });

  final UserModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      height: 85,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (model.isOnline)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: 45, end: 3),
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: Colors.green,
                      padding: EdgeInsets.all(7),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primaryColor,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(model.img),
                          radius: 26,
                        ),
                      ),
                    ),
                  ),
                if (!model.isOnline)
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.img),
                    radius: 26,
                  ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190,
                          child: CustomText(
                            model.name,
                            textOverflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      model.isOnline
                          ? "online"
                          : UtilFunctions.getTimeAgo(model.lastSeen),
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.left,
                      color: AppColors.kAsh,
                    )
                  ],
                ),
              ],
            ),
            Consumer<ChatProvider>(builder: (context, value, child) {
              return ElevatedButton(
                onPressed: () {
                  value.startCreateConversation(context, model, index);
                },
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: value.loadingIndex == index
                        ? Colors.white
                        : AppColors.primaryColor),
                child: value.loadingIndex == index
                    ? const SpinKitWave(
                        color: AppColors.primaryColor,
                        size: 10,
                      )
                    : const CustomText(
                        "chat",
                        fontSize: 15,
                        color: AppColors.kWhite,
                      ),
              );
            }),
          ]),
    );
  }
}
