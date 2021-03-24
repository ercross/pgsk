import 'package:flutter/material.dart';

import '../../../core/entities/product.dart';
import '../../../main.dart';
import '../../widgets/gradient_colored_long_action_button.dart';
import '../explore_screen/cart_screen/cart_screen.dart';
import '../explore_screen/cart_screen/product_card_cart_screen.dart';
import '../home_screen/homepage.dart';
import 'checkout_successful.dart';
import 'choose_payment_tab.dart';

class ConfirmationTab extends StatelessWidget {
  final double allowedWidth;
  final double allowedHeight;
  final List<Product> checkoutProducts;
  final PaymentOption chosenPaymentOption;

  static BuildContext ctx;

  ConfirmationTab(
      {@required this.checkoutProducts,
      @required this.chosenPaymentOption,
      @required this.allowedWidth,
      @required this.allowedHeight});

  Widget buildPaymentMethodInfo() {
    //Because the ancestor of this ConfirmationTab is an IndexedStack contained in the CheckoutPage widget
    //an attempt to render this widget is made when the ancestor IndexedStack is invoked,
    //thereby resulting in an error as a result of null ChosenPaymentOption that should be invoked on
    //the second child tab of the ancestor IndexedStack, thereby generating an error.
    //So an early check is made to determine if chosenPaymentOption has been initialized
    if (chosenPaymentOption == null)
      return SizedBox();
    else
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: [
          Text("Payment Method: ", style: PGSK.homepageTexts),
          Expanded(child: SizedBox()),
          Text(chosenPaymentOption.name,
              style: PGSK.homepageTexts.copyWith(color: Colors.grey)),
        ]),
      );
  }

  Widget _buildCheckoutProducts() {
    final productsAndQuantity =
        ProductAndQuantity.from(products: List<Product>.from(checkoutProducts));

    return ListView(
        children: productsAndQuantity
            .map((pAndQ) => ProductCardCartPage(
                  containerheight: allowedHeight * 0.15,
                  quantity: pAndQ.quantity,
                  product: pAndQ.product,
                ))
            .toList());
  }

  Widget _buildMiddleContent() {
    return SizedBox(
        child: Column(
      children: [
        buildPaymentMethodInfo(),
        Expanded(
            child: SizedBox(
          child: SizedBox(
            width: allowedWidth,
            child: _buildCheckoutProducts(),
          ),
        )),
      ],
    ));
  }

  Widget _buildPriceBreakdown(
      {@required double total,
      @required double subTotal,
      @required double shippingFee,
      @required double tax}) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow()],
          color: Colors.white,
        ),
        child: Column(
          children: [
            _buildAPriceRow("Sub Total", subTotal),
            _buildAPriceRow("Shipping Fee", shippingFee),
            _buildAPriceRow("Estimation Tax", tax),
            SizedBox(height: 15),
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            SizedBox(height: 10),
            _buildAPriceRow("Total", total),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.bottomCenter,
                child: GradientColoredLongActionButton(
                    text: "PLACE ORDER",
                    onPressed: () => Navigator.of(ctx).pushReplacementNamed(
                            CheckoutSuccessPage.routeName,
                            arguments: {
                              CheckoutSuccessPage.orderNumberKey,
                              "#FF23SQ12"
                            }),
                    height: allowedHeight * 0.07,
                    width: allowedWidth * HomePage.screenWidthMultiplier))
          ],
        ));
  }

  Widget _buildAPriceRow(String title, double price) {
    return Row(
      children: [
        SizedBox(
          width: allowedWidth * 0.4,
          child: Text(title,
              style: Theme.of(ctx).textTheme.caption.copyWith(fontSize: 11)),
        ),
        Expanded(child: Text(":", style: Theme.of(ctx).textTheme.caption)),
        SizedBox(
            width: allowedWidth * 0.4,
            child: Text("${PGSK.currency}${price.toString()}\n",
                style: Theme.of(ctx).textTheme.caption))
      ],
    );
  }

  ///confirmProductsPrices refetches all the products from the server and checks if the price is still the same
  ///This ensures that there is no price disparity from when the checkout process starts up till confirmation
  List<Product> _confirmProductsPrices() {
    //TODO: Implement. Fetch products by Id
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    double subTotal = 0;
    checkoutProducts.forEach((product) => subTotal += product.price);
    final double shipping = 30;
    final double tax = 8;

    return Center(
      child: SizedBox(
          height: allowedHeight,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: _buildMiddleContent(),
              ),
              _buildPriceBreakdown(
                  shippingFee: shipping,
                  subTotal: subTotal,
                  tax: tax,
                  total: shipping + tax + subTotal)
            ],
          )),
    );
  }
}
