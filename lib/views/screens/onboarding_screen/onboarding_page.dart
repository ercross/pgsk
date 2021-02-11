import 'package:flutter/material.dart';

import '../authentication_screen/authentication_page.dart';

class OnboardingPage extends StatefulWidget {
  static const String routeName = "/onboarding";

  const OnboardingPage();

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  //initialized to zero due to arrays being zero based
  int _currentImage = 0;

  ///buildOnboardingImage builds the stacked card on the onboarding page
  ///imageName must include the file extension i.e. .png, .jpg etc.
  Widget _buildOnboardingImage({String imageName, String heading}) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    const String _subheading =
        "We protect your privacy and keep you safe online with premium security";
    return Positioned(
        top: screenHeight * 0.1,
        height: screenHeight * 0.8, //this height has an effect on image height
        left: screenWidth * 0.1,
        width: screenWidth * 0.8,
        child: Stack(
      children: [
        Image.asset("assets/images/$imageName", 
          fit: BoxFit.fill, 
          width: screenWidth * 0.8,
          height: screenHeight * 0.73, //the actual image size
        ),
        Positioned(
          top: screenHeight * 0.48,
          left: screenWidth * 0.04,
          width: screenWidth * 0.7,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    heading,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top:13),
                  child: Text(_subheading,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: Colors.black, fontSize: 12)),
                )
              ]),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mQ = MediaQuery.of(context);
    final double screenHeight = mQ.size.height;
    final double screenWidth = mQ.size.width;
    final Color _activeButtonColor = Theme.of(context).primaryColor;
    final Color _inactiveButtonColor = Colors.grey;

    final Widget _background = Positioned(
        left: 0,
        top: 0,
        height: screenHeight,
        width: screenWidth,
        child: Image.asset(
          "assets/images/onboarding_background.png",
          fit: BoxFit.cover,
        ));

    final Widget _buttonBar = Positioned(
        top: screenHeight * 0.03,
        left: screenWidth * 0.25,
        right: screenWidth * 0.25,
        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageNumberIndicator(
                _currentImage == 0 ? _activeButtonColor : _inactiveButtonColor),
            _buildImageNumberIndicator(
                _currentImage == 1 ? _activeButtonColor : _inactiveButtonColor),
            _buildImageNumberIndicator(
                _currentImage == 2 ? _activeButtonColor : _inactiveButtonColor),
            _buildImageNumberIndicator(
                _currentImage == 3 ? _activeButtonColor : _inactiveButtonColor),
          ],
        ));

    final Widget _onboardingImages = IndexedStack(
          index: _currentImage,
          children: [
            _buildOnboardingImage(
              imageName: "onboarding_mobile_solutions.png",
              heading: "MOBILE\nSOLUTIONS",
            ),
            _buildOnboardingImage(
              imageName: "onboarding_it_communication_solution.png",
              heading: "IT COMMUNICATION\nSOLUTIONS"),
            _buildOnboardingImage(
              imageName: "onboarding_business_solution.png",
              heading: "BUSINESS\nSOLUTIONS"),
            _buildOnboardingImage(
              imageName: "onboarding_family_solution.png",
              heading: "FAMILY\nSOLUTIONS")
          ],
    );

    final Widget _lowerLine = Positioned(
      bottom: screenHeight * 0.01,
      left: screenWidth * 0.3,
      right: screenWidth * 0.3,
      child: Divider(
        color: Colors.grey,
        height: 0,
        thickness: 2,
      ),
    );

    final Widget _navButtons = Positioned(
      top: screenHeight * 0.87,
      left: screenWidth * 0.01,
      right: screenWidth * 0.01,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed(AuthenticationPage.routeName),
          child: Text("Skip", style: Theme.of(context).textTheme.bodyText2),),
        Expanded(child: Container()),
        ButtonBar(
          children: [
            _buildNavButton(
              isActive: _currentImage != 0, 
              icon: Icons.arrow_back, 
              onPressed: (){
                setState((){
                  if (_currentImage != 0) _currentImage--;
                });
              },),
            _buildNavButton(
              isActive: _currentImage != 3, 
              icon: Icons.arrow_forward, 
              onPressed: (){
                setState((){
                  if (_currentImage != 3) _currentImage++;
                  else _currentImage = 0;
                });
              },)
          ],
        )
      ],
    ));
    
    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            _background,
            _buttonBar,
            _onboardingImages,
            _navButtons,
            _lowerLine
      ],
    ));
  }

  Widget _buildImageNumberIndicator(Color iconColor) => Container(
     height: 8,
     width: 8,
    margin: EdgeInsets.only(left:3, right: 3, top: MediaQuery.of(context).size.height * 0.03),
    padding: EdgeInsets.all(3),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: iconColor,
    ),
  );

  Widget _buildNavButton({
    @required bool isActive, 
    @required IconData icon, 
    @required Function onPressed}) => Container(
    
    child: FlatButton(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      autofocus: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      minWidth: 10, //disable this to increase button width
      child: Icon(icon, color: Colors.white),
      onPressed: onPressed
    ),
    decoration: BoxDecoration(
      color: isActive ? null : Color(0xFF585C63),
      borderRadius: BorderRadius.circular(8),
      gradient: isActive 
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColorLight,
                        Theme.of(context).primaryColor,
                      ]
                    ) 
                  : null,
    ),
  );
}