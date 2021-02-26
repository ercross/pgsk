import 'package:flutter/material.dart';
import '../../../main.dart';
import '../home_screen/homepage.dart';
import '../../widgets/gradient_colored_long_action_button.dart';


///CheckoutSuccessPage is the page displayed after user has successfully completed payment 
///and an order has been successfully generated.
///Please note that CheckoutSuccessPage uses ModalRoute.settings.arguments to receive info about the order
///arguments should be encapsulated within a Map<String, dynamic>
class CheckoutSuccessPage extends StatelessWidget {
  static const String routeName = "checkout-success";
  static const String orderNumberKey = "OrderNumber";
  
  const CheckoutSuccessPage();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final String orderNumber = arguments[orderNumberKey];
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) => Center(
          child: SizedBox(
            width: constraints.maxWidth * HomePage.screenWidthMultiplier,
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.25),
                Icon(Icons.check_circle_outline_rounded, 
                  size: constraints.maxHeight * 0.2, 
                  color: Theme.of(context).accentColor),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Thank You", 
                    textAlign: TextAlign.center, 
                    style: PGSK.homepageTexts.copyWith(fontSize: 17, fontWeight: FontWeight.w700)
                  ),
                ),
                Text("Your order $orderNumber is completed", 
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
                ),
                Expanded(child: SizedBox()),
                GradientColoredLongActionButton(
                  
                  text: "CONTINUE SHOPPING", 
                  onPressed: () => Navigator.of(context).pushReplacementNamed(HomePage.routeName),
                ),
                SizedBox(height: constraints.maxHeight * 0.08),
              ],
            ),
          ),
        ),
      )
    );
  }
}