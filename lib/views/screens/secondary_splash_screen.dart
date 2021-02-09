import 'package:flutter/material.dart';
import 'package:pgsk/views/screens/onboarding_screen/onboarding_page.dart';

class SecondarySplashScreen extends StatelessWidget {
  const SecondarySplashScreen();

  static const String routeName = "secondary_splash_screen";

  @override
  Widget build(BuildContext context) {

    final MediaQueryData mQ = MediaQuery.of(context);

    final Widget splashScreen = Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          top: 0,
          width: mQ.size.width,
          height: mQ.size.height,
          child: Image.asset("assets/images/splash_screen_background.png", fit: BoxFit.fill)),
        Positioned(
          top: mQ.size.height * 0.15,
          right: mQ.size.width * 0.2,
          left: mQ.size.width * 0.2,
          child: Image.asset("assets/images/launch_icon.png", fit: BoxFit.scaleDown,),),
        Positioned(
          top: mQ.size.height * 0.7,
          right: mQ.size.width * 0.3,
          left: mQ.size.width * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("PGSK", 
                textAlign: TextAlign.center, 
                style: Theme.of(context).textTheme.headline5,),
              Text("Home To Antivirus and Internet Security Solutions", 
                textAlign: TextAlign.center, 
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],),
        )
      ],),
    );

    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 5)),
      builder: (context, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting 
          ? splashScreen 
          : OnboardingPage()
      );
  }
}