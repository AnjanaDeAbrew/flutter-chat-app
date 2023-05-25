import 'package:dude/providers/chat_provider.dart';
import 'package:dude/screens/main/chat/widgets/custom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageTypingWidget extends StatefulWidget {
  MessageTypingWidget({
    super.key,
    required this.scrollController,
  });
  ScrollController scrollController;
  @override
  State<MessageTypingWidget> createState() => _MessageTypingWidgetState();
}

class _MessageTypingWidgetState extends State<MessageTypingWidget> {
  @override
  Widget build(BuildContext context) {
    // String path = Provider.of<ChatProvider>(context, listen: false).imagePath;

    return CustomMessageBar(
      onSend: (String msg) {
        // Logger().w(msg);

        if (msg.trim().isNotEmpty) {
          Provider.of<ChatProvider>(context, listen: false)
              .startSendMessage(context, msg, 'text');
        }
        widget.scrollController.animateTo(
            widget.scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut);
      },

      // replyingTo: ,
      messageBarColor: Colors.transparent,
      sendButtonColor: const Color.fromARGB(255, 89, 45, 202),
    );
  }
}
