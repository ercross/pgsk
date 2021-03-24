import 'package:flutter/material.dart';
import '../../../controllers/providers/checkout_progress.dart';
import '../../widgets/gradient_colored_long_action_button.dart';
import 'package:provider/provider.dart';

class PersonalInfoTab extends StatelessWidget {
  final double allowedHeight;
  final double allowedWidth;

  static BuildContext ctx;

  const PersonalInfoTab(
      {@required this.allowedHeight, @required this.allowedWidth});

  Widget _buildTextFormField(
      {

      ///modifiedWidth is used to resize the width of the container in cases of two textformfield stacked on a row
      double modifiedWidth,
      @required String fieldName,
      @required String placeholderText}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style:
              Theme.of(ctx).textTheme.subtitle2.copyWith(color: Colors.black),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 0),
          padding: EdgeInsets.only(top: 8, left: 3),
          width: modifiedWidth == null ? allowedWidth : modifiedWidth,
          height: allowedHeight * 0.07,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.grey,
          ))),
          child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholderText,
                hintStyle: Theme.of(ctx)
                    .textTheme
                    .subtitle2
                    .copyWith(fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTextFormField(
              fieldName: "Full Name", placeholderText: "Damisa Alex"),
          _buildTextFormField(
              fieldName: "Address",
              placeholderText: "104 Denzel Washington drive"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildTextFormField(
                  modifiedWidth: allowedWidth * 0.45,
                  fieldName: "State",
                  placeholderText: "Washington DC"),
              _buildTextFormField(
                  modifiedWidth: allowedWidth * 0.45,
                  fieldName: "ZIP Code",
                  placeholderText: "001234"),
            ],
          ),
          _buildTextFormField(
              fieldName: "Country", placeholderText: "United States"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Center(
      child: SizedBox(
          width: allowedWidth,
          height: allowedHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(child: _buildForm(), height: allowedHeight * 0.7),
                SizedBox(height: allowedHeight * 0.09),
                SizedBox(
                  height: allowedHeight * 0.13,
                  child: GradientColoredLongActionButton(
                    onPressed: () {
                      Provider.of<CheckoutProgress>(context, listen: false)
                          .saveProgress();
                    },
                    text: "SAVE",
                  ),
                ),
                SizedBox(
                  height: allowedHeight * 0.08,
                )
              ],
            ),
          )),
    );
  }
}
