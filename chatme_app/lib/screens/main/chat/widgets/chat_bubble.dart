import 'package:dude/components/custom_text.dart';
import 'package:dude/models/objects.dart';
import 'package:dude/providers/chat_provider.dart';
import 'package:dude/screens/main/chat/widgets/custom_bubble.dart';
import 'package:dude/screens/main/chat/widgets/custom_image_bubble.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:dude/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    this.isSender = true,
    required this.model,
  });

  final bool isSender;

  final MessageModel model;

  @override
  Widget build(BuildContext context) {
    var uuid = const Uuid();

    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        model.messageType == 'image'
            ? InkWell(
                onLongPress: () {
                  openDialog(context);
                },
                child: CustomBubbleNormalImage(
                  id: uuid.v4(),
                  time: model.messageTime.substring(11, 16),
                  image: BlurHash(
                    hash: "L5H2EC=PM+yV0g-mq.wG9c010J}I",
                    image: model.message,
                  ),
                  isSender: isSender,
                  tail: true,
                  delivered: isSender ? true : false,
                  color: isSender
                      // ? const Color.fromARGB(255, 239, 232, 249)
                      ? const Color(0xff9159E6)
                      : const Color(0xffE5E5EA),
                ),
              )
            : InkWell(
                highlightColor: Colors.blue.withOpacity(.2),
                onLongPress: () {
                  openDialog(context);
                },
                child: CustomBubbleSpecialOne(
                  text: model.message,
                  time: model.messageTime.substring(11, 16),
                  tail: true,
                  isSender: isSender,
                  delivered: true,
                  textStyle: isSender
                      ? const TextStyle(fontSize: 16, color: AppColors.kWhite)
                      : const TextStyle(fontSize: 16, color: AppColors.kBlack),
                ),
              ),
      ],
    );
  }

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const CustomText(
            "Delete Message",
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          content: SizedBox(
            width: 500,
            height: 100,
            child: Column(
              children: [
                const CustomText(
                  "Are you sure you want to delete this message?",
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => UtilFunctions.goBack(context),
                      child: const CustomText(
                        'Cancel',
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .deleteMessage(model.messageId);
                        UtilFunctions.goBack(context);
                      },
                      child: const CustomText(
                        "Delete",
                        color: AppColors.kred,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
