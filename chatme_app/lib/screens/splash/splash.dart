import 'package:animate_do/animate_do.dart';
import 'package:dude/providers/auth_provider.dart';
import 'package:dude/utils/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      // UtilFunctions.navigateTo(context, const Login());
      Provider.of<AuthProvider>(context, listen: false).initializeUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bounce(
              child: Image.asset(
                AssetConstants.logo,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 12),
            ElasticIn(
              child: const Text(
                "ChatMe",
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff838383),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
