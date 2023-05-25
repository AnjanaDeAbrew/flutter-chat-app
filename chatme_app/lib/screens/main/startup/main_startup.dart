import 'package:dude/screens/main/startup/get_start.dart';
import 'package:dude/screens/main/startup/welcome.dart';
import 'package:flutter/material.dart';

class StartUp extends StatefulWidget {
  const StartUp({super.key});

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  final PageController _pageController = PageController(initialPage: 0);

  int _activePage = 0;

  final screens = [
    const WelcomePage(),
    const GetStartPage(),
  ];
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _activePage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return screens[index];
                },
                itemCount: 2,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 100,
              child: Container(
                // color: Colors.black45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      screens.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                _pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor: _activePage == index
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                            ),
                          )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
