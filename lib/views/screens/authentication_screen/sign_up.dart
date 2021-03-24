import 'package:flutter/material.dart';
import '../../../core/utils/validators.dart';

import '../../../views/screens/home_screen/homepage.dart';
import '../../widgets/gradient_colored_long_action_button.dart';
import '../../widgets/oval_shaped_text_input.dart';

class SignUpTab extends StatefulWidget {
  final double viewportHeight;
  final double viewportWidth;
  final PageController pageController;

  SignUpTab({
    @required this.viewportHeight,
    @required this.viewportWidth,
    @required this.pageController,
  });

  @override
  _SignUpTabState createState() => _SignUpTabState();
}

class _SignUpTabState extends State<SignUpTab> {
  final _formKey = GlobalKey<FormState>();
  String fullName;
  String phoneNumber;
  String email;
  String password;

  Widget _buildForm() => Form(
      key: _formKey,
      child: Container(
        height: widget.viewportHeight * 0.6,
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              OvalShapedTextField(
                leading: Icons.person,
                inputFieldFor: "FULL NAME",
                labelText: "FirstName LastName",
                valueHolder: fullName,
                isPasswordField: false,
                textInputType: TextInputType.name,
              ),
              OvalShapedTextField(
                leading: Icons.phone_iphone,
                inputFieldFor: "PHONE NUMBER",
                labelText: "+44 00000000000",
                valueHolder: phoneNumber,
                isPasswordField: false,
                textInputType: TextInputType.phone,
              ),
              OvalShapedTextField(
                leading: Icons.email,
                inputFieldFor: "E-MAIL",
                labelText: "your_email@something.com",
                valueHolder: email,
                isPasswordField: false,
                textInputType: TextInputType.emailAddress,
              ),
              OvalShapedTextField(
                leading: Icons.lock,
                inputFieldFor: "PASSWORD",
                labelText: "*********",
                isPasswordField: true,
                textInputType: TextInputType.text,
                valueHolder: password,
              )
            ],
          ),
        ),
      ));

  Widget _buildPageLowerPartContent() {
    return Column(
      children: [
        _buildFlatNavButton(),
        GradientColoredLongActionButton(
          text: "SIGN UP",
          onPressed: _onSignUpPressed,
        ),
        _buildAgreementWarning()
      ],
    );
  }

  void _onSignUpPressed() {
    ///Normally, the validate should be invoked before saving.
    ///But since save() triggers saving each TextFormField input into the respective OvalShapedTextInput.valueHolder,
    ///then save must be invoked so validation won't be done on null strings
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) return;
    print(
        "After saving and validating sign up form state. Full Name: $fullName\nEmail: $email\nPhone Number: $phoneNumber\nPassword: $password");
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  Widget _buildAgreementWarning() => Column(
        children: [
          Text("By signing up, you agree with our",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontWeight: FontWeight.w400)),
          TextButton(
            child: Text(
              "Terms & Conditions",
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(decoration: TextDecoration.underline, fontSize: 11),
            ),
            onPressed: () {
              //TODO: navigate to Terms and Conditions page
            },
          )
        ],
      );

  Widget _buildSignInButton() => TextButton(
        child: Text("Sign In",
            style: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).accentColor)),
        onPressed: () => widget.pageController.jumpToPage(0),
      );

  Widget _buildFlatNavButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account?",
              style: Theme.of(context).textTheme.caption),
          _buildSignInButton()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: widget.viewportHeight,
            width: widget.viewportWidth * 0.8,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(bottom: 5),
            child: Column(children: [
              Expanded(child: _buildForm()),
              SizedBox(height: 10),
              _buildPageLowerPartContent()
            ])));
  }
}
