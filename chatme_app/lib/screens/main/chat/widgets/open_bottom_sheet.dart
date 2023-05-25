import 'package:dude/components/custom_text.dart';
import 'package:dude/providers/chat_provider.dart';
import 'package:dude/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpenBottomSheet extends StatefulWidget {
  const OpenBottomSheet({super.key});

  @override
  State<OpenBottomSheet> createState() => _OpenBottomSheetState();
}

class _OpenBottomSheetState extends State<OpenBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.w(context),
      height: 250,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Card(
        margin: const EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: iconCreation(
                      Colors.blue,
                      Icons.insert_drive_file_rounded,
                      'Document',
                    ),
                  ),
                  const SizedBox(width: 45),
                  InkWell(
                    onTap: () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .getImageFromCamera(context);
                    },
                    child: iconCreation(
                      Colors.pink,
                      Icons.camera_alt,
                      'Camera',
                    ),
                  ),
                  const SizedBox(width: 45),
                  InkWell(
                    onTap: () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .getImageFromGallery(context);
                    },
                    child: iconCreation(
                      Colors.purple,
                      Icons.image,
                      'Gallery',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Colors.amber, Icons.headphones, 'Audio'),
                  const SizedBox(width: 40),
                  iconCreation(Colors.green, Icons.location_on, 'Location'),
                  const SizedBox(width: 40),
                  iconCreation(Colors.red, Icons.account_balance, 'Contact'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column iconCreation(Color color, IconData icon, String text) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
            size: 29,
          ),
        ),
        const SizedBox(height: 6),
        CustomText(
          text,
          fontSize: 12,
        )
      ],
    );
  }
}
