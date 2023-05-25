import 'package:dude/components/custom_text.dart';
import 'package:dude/models/objects.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/providers/chat_provider.dart';
import 'package:dude/screens/main/chat/chat.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:dude/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationCard extends StatefulWidget {
  const ConversationCard({
    super.key,
    required this.model,
  });

  final ConversationModel model;

  @override
  State<ConversationCard> createState() => _ConversationCardState();
}

class _ConversationCardState extends State<ConversationCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      //----set conversation model before going to the chat screen
      Provider.of<ChatProvider>(context, listen: false)
          .setConversation(widget.model);

      //------then go to the chat screen
      UtilFunctions.navigateTo(context, Chat(convId: widget.model.id));
    }, child: Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.model.usersArray
                  .firstWhere((e) => e.uid != value.userModel!.uid)
                  .img),
              radius: 26,
            ),
            title: CustomText(
              widget.model.usersArray
                  .firstWhere((e) => e.uid != value.userModel!.uid)
                  .name,
              textOverflow: TextOverflow.ellipsis,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            subtitle: widget.model.messageType == 'image'
                ? const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      CustomText(
                        'Photo',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                        color: AppColors.ashBorder,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      const Icon(
                        Icons.done_all,
                        size: 18,
                        color: AppColors.ashBorder,
                      ),
                      const SizedBox(width: 5),
                      CustomText(
                        widget.model.lastMessage,
                        textOverflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.left,
                        color: AppColors.ashBorder,
                      ),
                    ],
                  ),
            trailing: CustomText(widget.model.lastMessageTime.substring(11, 16),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.kAsh),
          ),
        );
      },
    )

        // ),
        );
  }
}
