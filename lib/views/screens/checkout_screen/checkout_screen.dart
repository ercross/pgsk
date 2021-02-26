import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/checkout_progress.dart';
import '../home_screen/homepage.dart';
import 'choose_payment_tab.dart';
import 'confirmation_tab.dart';
import 'personal_info_tab.dart';

class CheckoutPage extends StatelessWidget {

  static const String routeName = "/checkout";
  static BuildContext ctx;
  int progress;

  CheckoutPage();


  Widget _buildProgressNode ({@required bool isActive, @required double circleDimension}) {
    return Container(
      height: circleDimension,
      width: circleDimension,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(ctx).accentColor),
        color: isActive ? Theme.of(ctx).accentColor : Colors.white,
      ),
    );
  }

  Widget _buildNodeLabel({@required bool isActive, @required String label}) {
    return Text(label, style: Theme.of(ctx).textTheme.subtitle2.copyWith(
      fontSize: 13,
      color: isActive ? Theme.of(ctx).accentColor : Colors.grey));
  }

  Widget _buildNodeLabels () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildNodeLabel(isActive: progress == 0, label: "Personal Info"),
        _buildNodeLabel(isActive: progress == 1, label: "Payment"),
        _buildNodeLabel(isActive: progress == 2, label: "Confirmation")
      ],
    );
  }

  Widget _buildProgressIndicator({
    @required double top, 
    @required double pageWidth, 
    @required double allowedHeight
    }) {

    final double circleDimension = 12;

    final Widget line  = Container(
      width: pageWidth,
      height: 1,
      color: Theme.of(ctx).accentColor
    );

    return SizedBox(
      width: pageWidth,
      height: allowedHeight,
      child: Stack(
        
        children: [
          Positioned(
            top: top + circleDimension/2,
            child: line
          ),
          Positioned(
            top: top,
            left: 0,
            child: _buildProgressNode(circleDimension: circleDimension, isActive: progress == 0),
          ),
          Positioned(
            top: top,
            left: pageWidth / 2,
            child: _buildProgressNode(circleDimension: circleDimension, isActive: progress == 1)
          ),
          Positioned(
            top: top,
            right: 0,
            child: _buildProgressNode(circleDimension: circleDimension, isActive: progress == 2)
          )
        ],
      ),
    );
  }

  Widget _buildAppBar(BoxConstraints constraints){
    return SizedBox(
                width: constraints.maxWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: constraints.maxWidth * 0.05),
                    Icon(Icons.arrow_back_ios, size: 26),
                    Expanded(
                      child: Center(
                        child: Text("Checkout", style: Theme.of(ctx).textTheme.headline4.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w700, fontSize: 19)),
                      )
                    )
                  ],
                )
              );
  }

  @override
  Widget build(BuildContext context) {
    final CheckoutProgress checkoutTab = Provider.of<CheckoutProgress>(context);
    progress = checkoutTab.value;

    ctx = context;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (_, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: constraints.maxHeight * 0.07),
              _buildAppBar(constraints),
              _buildProgressIndicator(
                top: constraints.maxHeight * 0.03, 
                pageWidth: constraints.maxWidth * 0.73, 
                allowedHeight: constraints.maxHeight * 0.05),
                SizedBox(height: 10),
              _buildNodeLabels(),
              Expanded(
                child: IndexedStack(
                  index: progress,
                  children: [
                    PersonalInfoTab(
                      allowedHeight: constraints.maxHeight * 0.83,
                      allowedWidth: constraints.maxWidth * HomePage.screenWidthMultiplier,
                    ),
                    ChoosePaymentTab(
                      allowedHeight: constraints.maxHeight * 0.83,
                      allowedWidth: constraints.maxWidth * HomePage.screenWidthMultiplier,
                    ),
                    ConfirmationTab(
                      chosenPaymentOption: ChosenPaymentOption.paymentOption,
                      allowedHeight: constraints.maxHeight * 0.83,
                      allowedWidth: constraints.maxWidth * HomePage.screenWidthMultiplier,
                    )
                  ],
              ),
              )
            ],
          );
        },
      )
    );
  }
}