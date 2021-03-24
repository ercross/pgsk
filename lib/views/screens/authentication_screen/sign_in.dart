import 'package:flutter/material.dart';
import '../../../core/utils/validators.dart';
import '../../widgets/gradient_colored_long_action_button.dart';
import '../../widgets/oval_shaped_text_input.dart';

import '../home_screen/homepage.dart';

class SignInTab extends StatefulWidget {
  final double viewportHeight;
  final double viewportWidth;
  final PageController pageController;

  SignInTab({
    @required this.viewportHeight,
    @required this.viewportWidth,
    @required this.pageController,
  });

  @override
  _SignInTabState createState() => _SignInTabState();
}

class _SignInTabState extends State<SignInTab> {
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;

  void _onSignInButtonPressed() async {
    ///Normally, the validate should be invoked before saving.
    ///But since save() triggers saving each TextFormField input into the respective OvalShapedTextInput.valueHolder,
    ///then save must be invoked so validation won't be done on null strings
    _formKey.currentState.save();
    print(
        "After saving but before validating sign in form state. Email: $email\nPassword: $password");
    if (!_formKey.currentState.validate()) return;
    print(
        "After saving and validating sign in form state. Email: $email\nPassword: $password");
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final Widget forgotPasswordButton = TextButton(
      child:
          Text("Forget Password", style: Theme.of(context).textTheme.caption),
      //TODO: replace with code to redirect to a forgot password page
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("please check your email for a reset link",
            style:
                Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14)),
        elevation: 16,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      )),
    );

    final Widget _signUpButton = TextButton(
      child: Text("Sign Up",
          style: Theme.of(context).textTheme.caption.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).accentColor,
              fontSize: 14)),
      onPressed: () => widget.pageController.jumpToPage(1),
    );

    ///flatNavButtons is the row showing forgot password and Signup flat buttons
    final Widget _flatNavButtons = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          forgotPasswordButton,
          Container(
            width: 2,
            height: 13,
            color: Theme.of(context).accentColor,
          ),
          _signUpButton
        ],
      ),
    );

    final Widget _form = Form(
        key: _formKey,
        child: Column(
          children: [
            OvalShapedTextField(
              leading: Icons.email,
              inputFieldFor: "E-MAIL",
              labelText: "your_email@something.com",
              isPasswordField: false,
              textInputType: TextInputType.emailAddress,
              valueHolder: email,
            ),
            SizedBox(height: 20),
            OvalShapedTextField(
              leading: Icons.lock,
              inputFieldFor: "PASSWORD",
              labelText: "*********",
              isPasswordField: true,
              textInputType: TextInputType.text,
              valueHolder: password,
            )
          ],
        ));

    final Widget _lowerButtons = Column(
      children: [
        GradientColoredLongActionButton(
          text: "SIGN IN",
          onPressed: _onSignInButtonPressed,
        ),
        _flatNavButtons
      ],
    );

    return Center(
      child: Container(
        height: widget.viewportHeight * 0.8,
        width: widget.viewportWidth * 0.8,
        padding: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: [_form, SizedBox(height: 20), _lowerButtons],
        ),
      ),
    );
  }
}
