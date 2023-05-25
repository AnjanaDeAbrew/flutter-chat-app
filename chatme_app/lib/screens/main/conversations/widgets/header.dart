import 'package:dude/components/custom_text.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // return Container(
    //   decoration: const BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.topRight,
    //       end: Alignment.bottomLeft,
    //       colors: [
    //         Colors.purpleAccent,
    //         AppColors.primaryColor,
    //       ],
    //     ),
    //     // borderRadius: BorderRadius.only(
    //     //   bottomLeft: Radius.circular(50),
    //     //   bottomRight: Radius.circular(50),
    //     // ),
    //   ),
    //   height: size.height * 0.09,
    //   width: size.width,
    //   child: Center(
    //     child: CustomText(
    //       text,
    //       fontSize: 20,
    //       fontWeight: FontWeight.w500,
    //       color: AppColors.kWhite,
    //     ),
    //   ),
    // );
    return CustomText(
      text,
      fontSize: 25,
      fontWeight: FontWeight.w600,
    );
  }
}
