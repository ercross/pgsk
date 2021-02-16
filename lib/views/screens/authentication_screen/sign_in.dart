import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:pgsk/views/widgets/gradient_colored_long_action_button.dart';
import '../../../controllers/providers/authentication_tab_index.dart';
import '../../widgets/oval_shaped_text_input.dart';

import '../home_screen/homepage.dart';
import '../../widgets/on_page_loading_spinner.dart';

class SignInTab extends StatefulWidget {
  final double viewportHeight;
  final double viewportWidth;
  final AuthenticationTabIndex tabIndexProvider;

  SignInTab({
    @required this.viewportHeight, 
    @required this.viewportWidth, 
    @required this.tabIndexProvider}) ;

  @override
  _SignInTabState createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {

  void _onSignInButtonPressed() async {
    final ConnectivityResult cR = await Connectivity().checkConnectivity();
    if(cR == ConnectivityResult.mobile || cR == ConnectivityResult.wifi) {
      //TODO: send packet and replace Future.delayed with actual network response data
      Future.delayed(Duration(seconds: 5), () => Navigator.of(context).pushNamed(OnpageLoadingSpinner.routeName));
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }
    else Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("No Internet Connection", 
        textAlign: TextAlign.center, 
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white)),
      backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.3),
    ));
  }

  @override
  Widget build(BuildContext context) {

    final Widget forgotPasswordButton = FlatButton(
      child: Text("Forget Password", style: Theme.of(context).textTheme.caption),
      //TODO: replace with code to redirect to a forgot password page
      onPressed: () => Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("please check your email for a reset link", style: Theme.of(context).textTheme.bodyText2),
        elevation: 16,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      )),
    );

    final Widget _signUpButton = FlatButton(
      child: Text("Sign Up", 
        style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).accentColor)),
      onPressed: () => widget.tabIndexProvider.changeIndex(1),
    );

    ///flatNavButtons is the row showing forgot password and Signup flat buttons
    final Widget _flatNavButtons = Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 15),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     forgotPasswordButton,
                     Container(width: 2, height: 13, color: Theme.of(context).accentColor,),
                     _signUpButton
                   ],
                 ),
               );

    final Widget _form = Form(
              child: Column(                  
                children: [
                  OvalShapedTextField(
                    leading: Icons.email,
                    inputFieldFor: "E-MAIL",
                    labelText: "your_email@something.com",
                    trailing: Icon(Icons.check_circle, color: Theme.of(context).accentColor)
                  ),
                  SizedBox(height: 20),
                  OvalShapedTextField(
                    leading: Icons.lock,
                    inputFieldFor: "PASSWORD",
                    labelText: "*********",
                    trailing: Icon(Icons.check_circle, color: Theme.of(context).accentColor))
                ],
              ));

    final Widget _lowerButtons = Column(
             children: [
               GradientColoredLongActionButton(
                 text: "SIGN IN",
                 onPressed: _onSignInButtonPressed,
               ),
               _flatNavButtons              
             ],);

    return Center(
      child: Container(
        height: widget.viewportHeight * 0.8,
        width: widget.viewportWidth * 0.8,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: [
            _form,
            SizedBox(height: 20),
            _lowerButtons
          ],
        ),
      ),
    );


  }
}