import 'package:flutter/material.dart';
import '../../core/utils/validators.dart';

class OvalShapedTextField extends StatefulWidget {
  final IconData leading;
  final TextInputType textInputType;
  final String inputFieldFor;
  final String labelText;

  ///valueHolder is modified to hold the value entered into this textFormField.
  ///Ensure the variable assigned as valueHolder is non-final
  String valueHolder;

  ///isPasswordField allows to use functionalities (obscure-text, reveal-text-button)
  ///perculiar to a password field on this TextFormField.
  ///In a password field, the trailing check_mark icon is replaced by a reveal/obscure text button
  final bool isPasswordField;

  ///OvalShapedTextField is simply a decorated TextFormField.
  ///The trailing widget is an Icon.check_mark widget
  ///and its color is changed on validation of the input
  OvalShapedTextField({
    @required this.valueHolder,
    @required this.isPasswordField,
    @required this.leading,
    @required this.textInputType,
    @required this.inputFieldFor,
    @required this.labelText,
  });

  @override
  OvalShapedTextFieldState createState() => OvalShapedTextFieldState();
}

class OvalShapedTextFieldState extends State<OvalShapedTextField> {
  Color _trailingIconColor = Colors.grey;
  bool obscurePassword = true;
  IconData visibility = Icons.visibility;

  void _changeVisibilityIcon() {
    if (visibility == Icons.visibility)
      visibility = Icons.visibility_off_rounded;

    if (visibility == Icons.visibility_off_rounded)
      visibility = Icons.visibility;
  }

  void _toggleObscurePassword() {
    if (obscurePassword)
      obscurePassword = false;
    else
      obscurePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.inputFieldFor,
                style: Theme.of(context).textTheme.caption,
              )),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    validator: widget.textInputType ==
                            TextInputType.emailAddress
                        ? (input) => Validators.validateEmail(input)
                        : widget.textInputType == TextInputType.phone
                            ? (input) => Validators.validatePhoneNumber(input)
                            : (input) => Validators.validateText(
                                input, widget.inputFieldFor),
                    onEditingComplete: () => {
                      setState(() =>
                          _trailingIconColor = Theme.of(context).accentColor)
                    },
                    onSaved: (value) =>
                        setState(() => widget.valueHolder = value),
                    enableSuggestions: true,
                    style: Theme.of(context).textTheme.subtitle1,
                    obscureText: obscurePassword && widget.isPasswordField,
                    keyboardType: widget.textInputType,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(widget.leading),
                      hintText: widget.labelText,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                widget.isPasswordField
                    ? IconButton(
                        splashRadius: 1,
                        icon: Icon(visibility),
                        onPressed: () => setState(() {
                          _changeVisibilityIcon();
                          _toggleObscurePassword();
                        }),
                      )
                    : Icon(Icons.check_circle, color: _trailingIconColor)
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30)),
          ),
        ],
      ),
    );
  }
}
