import 'package:dude/components/custom_text.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:dude/utils/assets_constants.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              AppColors.primaryColor,
            ],
          ),
        ),
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetConstants.logo,
              width: 90,
              height: 90,
              opacity: const AlwaysStoppedAnimation(.5),
            ),
            const SizedBox(height: 10),
            const CustomText(
              'ChatMe',
              fontSize: 40,
              color: AppColors.kWhite,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 16),
            CustomText(
              'Chat with anyone from anywhere',
              fontSize: 15,
              color: AppColors.kWhite.withOpacity(.5),
              // fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
