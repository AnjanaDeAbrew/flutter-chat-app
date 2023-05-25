import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dude/components/custom_text.dart';
import 'package:dude/controllers/chat_controller.dart';
import 'package:dude/models/objects.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/screens/main/chat/widgets/chat_bubble.dart';
import 'package:dude/screens/main/chat/widgets/chat_header.dart';
import 'package:dude/screens/main/chat/widgets/message_typing_widget.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({
    super.key,
    required this.convId,
  });

  final String convId;
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<MessageModel> _messages = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    ScrollController scrollController = ScrollController();

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage(
          //           AssetConstants.chatBg,
          //         ),
          //         fit: BoxFit.cover,
          //         opacity: 0.3)),
          child: Column(
            children: [
              const ChatHeader(),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: ChatController().getMessages(widget.convId),
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
                    return Container();
                  }

                  _messages.clear();

                  for (var e in snapshot.data!.docs) {
                    Map<String, dynamic> data =
                        e.data() as Map<String, dynamic>;
                    var model = MessageModel.fromJson(data);

                    _messages.add(model);
                  }
                  return Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          shrinkWrap: true,
                          // reverse: true,
                          itemBuilder: (context, index) {
                            //--------------group messages by date and time
                            bool isSameDate = true;
                            final String dateString =
                                _messages[index].messageTime;
                            final DateTime date = DateTime.parse(dateString);

                            if (index == 0) {
                              isSameDate = false;
                            } else {
                              final String prevDateString =
                                  _messages[index - 1].messageTime;
                              final DateTime prevDate =
                                  DateTime.parse(prevDateString);
                              isSameDate = date.isSameDate(prevDate);
                            }
                            if (index == 0 || !(isSameDate)) {
                              return Column(children: [
                                DateChip(
                                  date: date,
                                ),
                                Consumer<AuthProvider>(
                                    builder: (context, value, child) {
                                  return ChatBubble(
                                    isSender: _messages[index].senderId ==
                                        value.userModel!.uid,
                                    model: _messages[index],
                                  );
                                })
                              ]);
                            } else {
                              return Consumer<AuthProvider>(
                                  builder: (context, value, child) {
                                return ChatBubble(
                                  isSender: _messages[index].senderId ==
                                      value.userModel!.uid,
                                  model: _messages[index],
                                );
                              });
                            }
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: _messages.length));
                },
              ),
              MessageTypingWidget(scrollController: scrollController),
              const SizedBox(height: 5)
            ],
          ),
        ),
      ),
    );
  }
}

String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
