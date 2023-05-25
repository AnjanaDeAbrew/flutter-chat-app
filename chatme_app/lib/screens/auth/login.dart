import 'package:dude/components/custom_text.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/utils/app_colors.dart';
import 'package:dude/utils/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://img.freepik.com/free-vector/cerulean-blue-curve-frame-template-vector_53876-136095.jpg?w=740&t=st=1683974499~exp=1683975099~hmac=8ed235cebdc9b5846abaf3d1a534fde1f39897fafeabfccf3a803783ae40a214'),
                fit: BoxFit.cover)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset(
              AssetConstants.logo,
              width: 90,
              height: 90,
            ),
            const SizedBox(height: 15),
            const Text(
              "Let's Chat",
              style: TextStyle(
                  fontSize: 25,
                  color: AppColors.kBlack,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: size.height * 0.1),
            const CustomText("sign in with social networks",
                fontSize: 15,
                color: Color(0xff838383),
                fontWeight: FontWeight.w500),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.google,
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .googleAuth();
                  },
                  width: size.width * 0.7,
                ),
                // const SizedBox(height: 30),
                // SocialLoginButton(
                //   buttonType: SocialLoginButtonType.facebook,
                //   width: size.width * 0.7,
                //   backgroundColor: Colors.white,
                //   textColor: Colors.black,
                //   onPressed: () {},
                //   imageURL: AssetConstants.fb,
                // )
                // InkWell(
                //   onTap: () {
                //     // UtilFunctions.navigateTo(context, const MainScreen());
                //     Provider.of<AuthProvider>(context, listen: false)
                //         .googleAuth();
                //   },
                //   child: customSocialButton(
                //       size,
                //       'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png',
                //       AppColors.kred),
                // ),
                // const SizedBox(height: 10),
                // const CustomText("- or -",
                //     fontSize: 15,
                //     color: Color(0xff838383),
                //     fontWeight: FontWeight.w500),
                // const SizedBox(height: 10),
                // customSocialButton(
                //     size,
                //     'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/1024px-Facebook_Logo_%282019%29.png',
                //     AppColors.darkGreen)
              ],
            )
          ],
        ),
      )),
    );
  }

  // Container customSocialButton(Size size, String imgUrl, Color color) {
  //   return Container(
  //     width: size.width * 0.3,
  //     height: 50,
  //     padding: const EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       color: AppColors.kWhite,
  //       // border: Border.all(
  //       //   width: 1,
  //       //   color: color,
  //       // ),
  //     ),
  //     child: Image.network(imgUrl),
  //   );
  // }
}
