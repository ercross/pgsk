import 'package:flutter/material.dart';
import 'package:pgsk/controllers/providers/checkout_progress.dart';
import 'package:pgsk/views/screens/checkout_screen/payment_details_tab.dart';
import 'package:pgsk/views/widgets/gradient_colored_long_action_button.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';

class ChoosePaymentTab extends StatefulWidget {
  final double allowedHeight;
  final double allowedWidth;

  ChoosePaymentTab ({
    @required this.allowedHeight, 
    @required this.allowedWidth
  });

  @override
  _ChoosePaymentTabState createState() => _ChoosePaymentTabState();
}

class _ChoosePaymentTabState extends State<ChoosePaymentTab> {

  List<PaymentOption> _fetchPaymentOptions() {
    const String urlPrefix = "assets/images/";
    return <PaymentOption>[
      PaymentOption(imageUrl: urlPrefix + "mastercard_logo.png", name: "MasterCard"),
      PaymentOption(imageUrl: urlPrefix + "visa_card_logo.png", name: "Visa"),
      PaymentOption(imageUrl: urlPrefix + "stripe_logo.png", name: "Stripe"),
      PaymentOption(imageUrl: urlPrefix + "paypal_logo.png", name: "PayPal")
    ];
  }

  Widget  _middleContent;
  int currentPage = 0;
  
  ///middleContent can't be initialized with instance members fetchPaymentOptions and buildChoosePaymentOption
  ///So I used this builder method to do that.
  ///buildMiddleContent must be invoked before invoking middleContent
  void _buildMiddleContent() {
    if (currentPage == 0) setState(() => _middleContent = _buildChoosePaymentOption(
        _PaymentOptionsRadio(_fetchPaymentOptions())));
    
    if (currentPage == 1) setState(() => _middleContent = _buildPaymentDetailsForm());
  }
   

  Widget _buildChoosePaymentOption(_PaymentOptionsRadio paymentOptionRadio) {
    return SizedBox(child: paymentOptionRadio,);
  }

  Widget _buildPaymentDetailsForm() {
    return PaymentDetailsTab(ChosenPaymentOption.paymentOption);
  }

  Widget _buildContinueButton() => Container(
              margin: EdgeInsets.only(top: widget.allowedHeight * 0.1),
              child: GradientColoredLongActionButton(
                text: "CONTINUE",
                onPressed: (){
                  if (ChosenPaymentOption.paymentOption == null) { 
                    return;
                  }

                  if (currentPage == 0) {
                    setState(() => currentPage++);
                  }
                  else Provider.of<CheckoutProgress>(context, listen: false).saveProgress();
                },
              ),
            );

  Widget _buildTabHeader() {
    return Container(
              margin: EdgeInsets.only(
                top: widget.allowedHeight * 0.08, 
                bottom: widget.allowedHeight * 0.02),

              child: ChosenPaymentOption.paymentOption == null
                ? Text("Choose Payment Method", textAlign: TextAlign.center, style: PGSK.homepageTexts)
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    Icon(Icons.lock_rounded, color: Colors.grey),
                    Text(ChosenPaymentOption.paymentOption.name, 
                      style: PGSK.homepageTexts.copyWith(color: Theme.of(context).accentColor)
                    ),
                    Expanded(child: SizedBox(),),
                    Image.asset(ChosenPaymentOption.paymentOption.imageUrl, height: 70, width: 70)
                  ],
                )
          );
  }

  @override
  Widget build(BuildContext context) {
    _buildMiddleContent();

    return Center(
      child: SizedBox(
        width: widget.allowedWidth,
        height: widget.allowedHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTabHeader(),
            Expanded(child: _middleContent),    
            _buildContinueButton(),
            SizedBox(height: widget.allowedHeight * 0.1)
          ],
        )
      ),
    );
  }
}

class PaymentOption {
  final String imageUrl;
  final String name;

  const PaymentOption({
    @required this.imageUrl,
    @required this.name
  });
}

//This custom Radio button was made so that app owner can add new payment options
//without the need to involve the software company that built PGSK
class _PaymentOptionsRadio extends StatefulWidget {
  final List<PaymentOption> paymentOptions;

  _PaymentOptionsRadio(this.paymentOptions);

  @override
  _PaymentOptionsRadioState createState() => _PaymentOptionsRadioState();
}

class _PaymentOptionsRadioState extends State<_PaymentOptionsRadio> {

  ///chosenButton is the button tapped by user. index 0 is the first button. 
  ///Due to Dart's zero based array, 
  ///the range of valid values for chosenButton is 0 to widget.paymentOptions.length-1 
  int _chosenButton;

  Widget _buildButton (int index) {
    return IconButton(
      icon: _chosenButton == null 
              ? Icon(Icons.radio_button_off, color: Colors.grey)
              : index == _chosenButton 
                ? Icon(Icons.radio_button_on, color: Theme.of(context).accentColor)
                : Icon(Icons.radio_button_off, color: Colors.grey),
      onPressed: () => setState(() {
        _chosenButton = index;
        ChosenPaymentOption.paymentOption = widget.paymentOptions[index];
      }),
      iconSize: 15,
    );
  }

  Widget _buildPaymentOption({@required int index, @required PaymentOption paymentOption}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(index),
        GestureDetector(
          onTap: () => setState(() {
            ChosenPaymentOption.paymentOption = widget.paymentOptions[index];
            _chosenButton = index;
          }),
          child: Text(paymentOption.name, 
            style: Theme.of(context).textTheme.subtitle2.copyWith(
              color: index == _chosenButton 
                ? Theme.of(context).accentColor 
                : Colors.grey)),
        ),
        Expanded(
          child: SizedBox()),
        GestureDetector(
          onTap: () => setState(() {
            ChosenPaymentOption.paymentOption = widget.paymentOptions[index];
            _chosenButton = index;
          }),
          child: Image.asset(paymentOption.imageUrl, fit: BoxFit.contain, height: 60, width: 70,)),
      ],
    );
  }

  Widget _buildPaymentOptions () {
    //W stands for widget, to differentiate it from widget.paymentOptions
    List<Row> paymentOptionsW = List<Row>();

    for( int i = 0; i< widget.paymentOptions.length ; i++) {
      paymentOptionsW.add(
        _buildPaymentOption(index: i, paymentOption: widget.paymentOptions[i])
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: paymentOptionsW,
    );
  }

  @override
  Widget build(BuildContext context) => _buildPaymentOptions();
}

///ChosenPaymentOption is used to encapsulate the preferred chosen payment 
///so that other widgets can have acces to it
class ChosenPaymentOption {
  static PaymentOption paymentOption;
}