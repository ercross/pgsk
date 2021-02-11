import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/authentication_tab_index.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class AuthenticationPage extends StatelessWidget {
  static const String routeName = "/authentication";

  const AuthenticationPage();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<AuthenticationTabIndex>(
             create:(_) => AuthenticationTabIndex(),
              child: AuthenticationTabs()
    );
}

class AuthenticationTabs extends StatelessWidget {

  const AuthenticationTabs();

  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height;
    final double pageWidth = MediaQuery.of(context).size.width;
    final double toolbarHeight = pageHeight * 0.3;

    ///tabViewHeight is the height of the container within which sign-in and sign-up pages are rendered
    final double tabViewHeight = pageHeight * 0.7;
    final double tabViewWidth = pageWidth;

    final AuthenticationTabIndex indexProvider = Provider.of<AuthenticationTabIndex>(context);

    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: toolbarHeight,
            elevation: 0,

            flexibleSpace: Image.asset("assets/images/splash_screen_background.png",
                  fit: BoxFit.fitWidth,
                  width: pageWidth,
                  height: pageHeight, ),
            backgroundColor: Colors.white60,
            bottom: TabBar(

              indicator: BoxDecoration(
              color: Colors.white24,
            ),
              tabs: [
                Tab(child: Text("Sign In") ,),
                Tab(child: Text("Sign Up"))
              ],
            )),
            body: 
               TabBarView(
                children: [
                  SignInTab(viewportHeight: tabViewHeight, viewportWidth: tabViewWidth, tabIndexProvider: indexProvider,),
                  SignUpTab(viewportHeight: tabViewHeight, viewportWidth: tabViewWidth, tabIndexProvider: indexProvider)
                ],),
            )
        
    );
  }
}