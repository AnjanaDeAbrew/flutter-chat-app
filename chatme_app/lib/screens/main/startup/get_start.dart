import 'package:dude/components/custom_button.dart';
import 'package:dude/components/custom_text.dart';
import 'package:dude/screens/auth/login.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:dude/utils/assets_constants.dart';
import 'package:dude/utils/util_functions.dart';
import 'package:flutter/material.dart';

class GetStartPage extends StatefulWidget {
  const GetStartPage({super.key});

  @override
  State<GetStartPage> createState() => _GetStartPageState();
}

class _GetStartPageState extends State<GetStartPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
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
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(200),
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(200),
                  ),
                  image: const DecorationImage(
                      image: AssetImage(AssetConstants.welcomeImage),
                      fit: BoxFit.cover,
                      opacity: 0.4)),
            ),
            const SizedBox(height: 50),
            const CustomText(
              'Send Free Messages',
              fontSize: 20,
              color: AppColors.kWhite,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 20),
            CustomText(
              'Spice up your text messages with these multiple options and stckers \nwith positive messages , positive affirmations \nand more ',
              fontSize: 12,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: AppColors.kWhite.withOpacity(.6),
            ),
            const SizedBox(height: 100),
            CustomButton(
              text: 'Start Login',
              textColor: AppColors.kBlack,
              width: 120,
              height: 40,
              fontSize: 14,
              onTap: () {
                UtilFunctions.navigateTo(context, const Login());
              },
              color: AppColors.kWhite,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
