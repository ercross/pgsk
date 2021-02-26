import 'package:flutter/material.dart';

import '../../../core/entities/product.dart';
import '../../../core/entities/product_category.dart';
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
  final PaymentOption chosenPaymentOption;

  static BuildContext ctx;

  ConfirmationTab({
    @required this.chosenPaymentOption,
    @required this.allowedWidth, 
    @required this.allowedHeight
  });

  Widget buildPaymentMethodInfo() {
    //Because the ancestor of this ConfirmationTab is an IndexedStack contained in the CheckoutPage widget
    //an attempt to render this widget is made when the ancestor IndexedStack is invoked, 
    //thereby resulting in an error as a result of null ChosenPaymentOption that should be invoked on
    //the second child tab of the ancestor IndexedStack, thereby generating an error.
    //So an early check is made to determine if chosenPaymentOption has been initialized
    if (chosenPaymentOption == null) return SizedBox();
    else return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Row(
              
              children: [
                Text("Payment Method: ", style: PGSK.homepageTexts),
                Expanded(child: SizedBox()),
                Text(chosenPaymentOption.name , style: PGSK.homepageTexts.copyWith(color: Colors.grey)),

              ]
            ),
  );
  } 

  Widget _renderCartProducts(List<ProductAndQuantity> productsAndQuantity) {
    final List<ProductCardCartPage> productCards = List<ProductCardCartPage>();

    for(int i=0; i<productsAndQuantity.length ; i++) {
      productCards.add(ProductCardCartPage(
        containerheight: allowedHeight * 0.15,
        quantity: productsAndQuantity[i].quantity,
        product: productsAndQuantity[i].product,
       )
      );
    }
    return ListView(children: productCards);
  }

  static const String prefix = "assets/images/";
    static final List<Product> _products = [
      Product(
        id: 1.toString(),
        name: "Avast Antivirus",
        price: 40,
        specification: "",
        description: "",
        category: ProductCategory(id: 1.toString(), name: "Antivirus Protection"),
        imageUrl: prefix + "product_1_avast.png"
      ),
      Product(
        id: 2.toString(),
        name: "Quick Heal Antivirus",
        price: 50,
        specification: "",
        description: "",
        category: ProductCategory(id: 2.toString(), name: "Internet Protection"),
        imageUrl: prefix + "product_2_quickheal.png"
      ),
      Product(
        id: 2.toString(),
        name: "Kaspersky Antivirus",
        price: 75,
        specification: "",
        description: "",
        category: ProductCategory(id: 2.toString(), name: "Internet Protection"),
        imageUrl: prefix + "product_3_kaspersky.png"
      ),
    ];

  final List<Product> _moreProducts = [
    ..._products.getRange(0,1),
    ..._products.getRange(1,2),
    ..._products,
    ..._products.getRange(0,2),
  ];

  Widget _buildMiddleContent() {
    return SizedBox(
      child: Column(
        children: [
          buildPaymentMethodInfo(),
          Expanded( child: SizedBox(
              child: SizedBox(
                width: allowedWidth,
                child: _renderCartProducts(ProductAndQuantity.from(
                  products: List<Product>.from(_moreProducts))),
              ),)),
          
        ],
      )
    );
  }

  Widget _buildPriceBreakdown({
    @required double total,
    @required double subTotal, 
    @required double shippingFee, 
    @required double tax}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 8),
      decoration:BoxDecoration(
        boxShadow: [BoxShadow()],
        color: Colors.white,
      ),
      child: Column(
        
        children: [
          _buildAPriceRow("Sub Total", subTotal),
          _buildAPriceRow("Shipping Fee", shippingFee),
          _buildAPriceRow("Estimation Tax", tax),
          SizedBox(height: 15),
          Divider(color: Colors.grey, thickness: 2,),
          SizedBox(height: 10),
          _buildAPriceRow("Total", total),
          SizedBox(height: 10),
          Align(alignment: Alignment.bottomCenter, child: GradientColoredLongActionButton(text: "PLACE ORDER", onPressed: () => Navigator.of(ctx).pushReplacementNamed(
            CheckoutSuccessPage.routeName, 
            arguments: {CheckoutSuccessPage.orderNumberKey, "#FF23SQ12"}), 
            height: allowedHeight * 0.07, 
            width: allowedWidth * HomePage.screenWidthMultiplier))
        ],
      )
    );
  }

  Widget _buildAPriceRow(String title, double price) {
    return Row(
      children: [
        SizedBox(width: allowedWidth * 0.4, child: Text(title, style: Theme.of(ctx).textTheme.caption.copyWith(fontSize: 11)),),
        Expanded(child: Text(":", style: Theme.of(ctx).textTheme.caption)),
        SizedBox(width: allowedWidth * 0.4, child: Text("${PGSK.currency}${price.toString()}\n", style: Theme.of(ctx).textTheme.caption))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Center(
      child: SizedBox(
        height: allowedHeight,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(child: _buildMiddleContent(),),
            _buildPriceBreakdown(
              shippingFee: 10,
              subTotal: 180,
              tax: 9.8,
              total: 200
            )
          ],
        )
      ),
    );
  }
}