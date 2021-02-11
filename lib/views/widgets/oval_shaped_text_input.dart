import 'package:flutter/material.dart';

class OvalShapedTextField extends StatefulWidget {
  final IconData leading;
  final Widget trailing;
  final String inputFieldFor;
  final String labelText;

  OvalShapedTextField({
    @required this.leading, 
    @required this.trailing,
    @required this.inputFieldFor,
    @required this.labelText,
  });

  @override
  OvalShapedTextFieldState createState() => OvalShapedTextFieldState();
}

class OvalShapedTextFieldState extends State<OvalShapedTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.inputFieldFor, style: Theme.of(context).textTheme.caption,)),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(decoration: InputDecoration(
                      border: InputBorder.none,
                      
                      icon: Icon(widget.leading),
                      labelText: widget.labelText),),
                  ),
                  SizedBox(width: 10),
                  widget.trailing
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30)
              ),
            ),
          ],
        ),
    );
  }
}