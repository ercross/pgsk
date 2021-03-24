import 'package:flutter/material.dart';

class OnpageLoadingSpinner extends StatelessWidget {

  static const String routeName = "/onpageLoadingIndicator";

  const OnpageLoadingSpinner();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        )),
    );
  }
}