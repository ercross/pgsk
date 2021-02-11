import 'package:flutter/material.dart';
import 'package:pgsk/views/screens/onboarding_screen/onboarding_page.dart';

class SecondarySplashScreen extends StatelessWidget {
  const SecondarySplashScreen();

  static const String routeName = "secondary_splash_screen";

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mQ = MediaQuery.of(context);

    final Widget _background = Positioned(
              left: 0,
              top: 0,
              width: mQ.size.width,
              height: mQ.size.height,
              child: Image.asset("assets/images/splash_screen_background.png",
                  fit: BoxFit.fill));

    final Widget _pgskIcon = Positioned(
            top: mQ.size.height * 0.15,
            right: mQ.size.width * 0.2,
            left: mQ.size.width * 0.2,
            child: Image.asset(
              "assets/images/launch_icon.png",
              fit: BoxFit.scaleDown,
            ),
          );

    final Widget _lowerText = Positioned(
            top: mQ.size.height * 0.7,
            right: mQ.size.width * 0.2,
            left: mQ.size.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome To PGSK",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Home To Antivirus and Internet Security Solutions",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )
              ],
            ),
          );

    final Widget _lowerLine = Positioned(
      bottom: mQ.size.height * 0.01,
      left: mQ.size.width * 0.3,
      right: mQ.size.width * 0.3,
      child: Divider(
        color: Colors.grey,
        height: 0,
        thickness: 2,
        ),
    );

    final Widget splashScreen = Scaffold(
      body: Stack(
        children: [
          _background,
          _pgskIcon,
          _lowerText,
          _lowerLine,
        ],
      ),
    );

    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 5)),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? splashScreen
                : OnboardingPage());
  }
}
