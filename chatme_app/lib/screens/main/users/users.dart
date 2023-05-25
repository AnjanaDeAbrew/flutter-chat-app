import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dude/components/custom_text.dart';
import 'package:dude/controllers/chat_controller.dart';
import 'package:dude/models/objects.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/screens/main/conversations/widgets/header.dart';
import 'package:dude/screens/main/users/widgets/user_card.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final List<UserModel> _users = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Header(text: "Contacts"),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Consumer<AuthProvider>(
                  builder: (context, value, child) {
                    return StreamBuilder<QuerySnapshot>(
                      stream:
                          ChatController().getUsers(value.firebaseUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: CustomText(
                              "No Users. Error occured",
                              fontSize: 20,
                              color: AppColors.kAsh,
                            ),
                          );
                        }

                        //----------if the stream is still loading
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: CustomText("No Users",
                                  fontSize: 20, color: AppColors.kAsh));
                        }
                        Logger().wtf(snapshot.data!.docs.length);
                        _users.clear();

                        //-read the document list and ,apping them to user model and then add them to the list
                        for (var e in snapshot.data!.docs) {
                          Map<String, dynamic> data =
                              e.data() as Map<String, dynamic>;

                          var model = UserModel.fromJson(data);

                          _users.add(model);
                        }

                        return ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) => UsersCard(
                                  model: _users[index],
                                  index: index,
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 1),
                            itemCount: _users.length);
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
