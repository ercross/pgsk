import 'package:flutter/material.dart';

import 'choose_payment_tab.dart';

class PaymentDetailsTab extends StatefulWidget {

  final PaymentOption paymentOption;

  PaymentDetailsTab(this.paymentOption);

  @override
  _PaymentDetailsTabState createState() => _PaymentDetailsTabState();
}

class _PaymentDetailsTabState extends State<PaymentDetailsTab> {

  ///fetchRequiredFields fetches the field required
  List<String> _fetchRequiredFields({@required String from}) {

  }

  Widget _buildTextFormField({
    ///modifiedWidth is used to resize the width of the container in cases of two textformfield stacked on a row
    double modifiedWidth,
    @required String fieldName, 
    @required String placeholderText }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldName, style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.black),),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          padding: EdgeInsets.only(top: 3, left: 3),
          width: modifiedWidth == null ? double.infinity : modifiedWidth,
          height: 30,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey,))
          ),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeholderText,
              hintStyle: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w500)
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTextFormField(
                fieldName: "Card Number",
                placeholderText: "1234 5678 9012 3456"
              ),
              _buildTextFormField(
                fieldName: "Card Holder Name",
                placeholderText: "Denzel Washington"
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTextFormField(
                fieldName: "Exp Date",
                placeholderText: "03/24",
                modifiedWidth: 120
              ),
              _buildTextFormField(
                fieldName: "CCV",
                placeholderText: "321",
                modifiedWidth: 120,
              ),
                ],
              )
            ],
          )
        )
      ));
  }
}