import 'package:flutter/material.dart';

import '../../../controllers/providers/authentication_tab_index.dart';
import '../../widgets/oval_shaped_text_input.dart';

class SignUpTab extends StatefulWidget {
  final double viewportHeight;
  final double viewportWidth;
  final AuthenticationTabIndex tabIndexProvider;

  SignUpTab({
    @required this.viewportHeight, 
    @required this.viewportWidth, 
    @required this.tabIndexProvider});

  @override
  _SignUpTabState createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {

  Widget _buildForm() =>  Form(
              child: Container(
                height: widget.viewportHeight * 0.6,
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.only(top: 10),
                child: ListView(                  
                  children: [
                    OvalShapedTextField(
                      leading: Icons.person,
                      inputFieldFor: "FULL NAME",
                      labelText: "FirstName LastName",
                      trailing: Icon(Icons.check_circle, color: Theme.of(context).accentColor)
                    ),
                    OvalShapedTextField(
                      leading: Icons.phone_iphone,
                      inputFieldFor: "PHONE NUMBER",
                      labelText: "+44 00000000000",
                      trailing: Icon(Icons.check_circle, color: Theme.of(context).accentColor)
                    ),
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
                ),
              ));

  Widget _buildPageLowerPartContent() {
    return Column(
      children: [
        _buildFlatNavButton(),
        _buildSignUpButton(),
        _buildAgreementWarning()
      ],
    );
  }

  Widget _buildAgreementWarning() =>
    Column(
      children: [
        Text("By signing up, you agree with our", textAlign: TextAlign.center, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w400)),
        FlatButton(
          child: Text("Terms & Conditions", style: Theme.of(context).textTheme.button.copyWith(decoration: TextDecoration.underline),),
          onPressed: () {
            //TODO: navigate to Terms and Conditions page
          },
        )
      ],
    );

  Widget _buildSignInButton() =>
    FlatButton(
      child: Text("Sign In", 
        style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).accentColor)),
      onPressed: () => widget.tabIndexProvider.changeIndex(1),
    );

  Widget _buildFlatNavButton() {
    return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 15),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Already have an account?", style: Theme.of(context).textTheme.caption),
                     _buildSignInButton()
                   ],
                 ),
               );
  }

  Widget _buildSignUpButton() => Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColorLight,
            Theme.of(context).primaryColor
          ]
        )
      ),
      child: Center(
        child: FlatButton(
          child: Text("SIGN UP"),
          onPressed: (){},
      ))
    );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: widget.viewportHeight,
        width: widget.viewportWidth * 0.8,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Expanded(child: _buildForm()),
            SizedBox(height: 10),
            _buildPageLowerPartContent()
          ]
        ) 
      )  
    );
  }
}