
import 'package:flutter/material.dart';
import 'package:pgsk/controllers/providers/cart.dart';
import 'package:pgsk/views/screens/checkout_screen/checkout_screen.dart';
import 'package:pgsk/views/screens/home_screen/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../../core/entities/product.dart';
import '../../../../main.dart';
import '../../../widgets/gradient_colored_long_action_button.dart';
import '../../home_screen/homepage.dart';
import 'product_card_cart_screen.dart';


///CartPage contains the cartpage. If size is omitted, CartPage is rendered as a full page through scaffold
class CartPage extends StatelessWidget {

  final BoxConstraints size;
  CartPage([this.size]);
  BuildContext ctx;

  Widget _buildCartItems(List<ProductAndQuantity> productAndQuantity){

    final List<ProductCardCartPage> productCards = List<ProductCardCartPage>();

    for(int i=0; i<productAndQuantity.length ; i++) {
      productCards.add(ProductCardCartPage(
        containerheight: size.maxHeight * 0.14,
        quantity: productAndQuantity[i].quantity,
        product: productAndQuantity[i].product,
      )
    );
    }
    
    return ListView(children: productCards);
  }

  Widget _buildPriceBreakdown({
    @required double total,
    @required double subTotal, 
    @required double shippingFee, 
    @required double tax}) {
    return Container(
      width: size.maxWidth,
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
          Align(alignment: Alignment.bottomCenter, child: GradientColoredLongActionButton(text: "CHECKOUT", onPressed: () => Navigator.of(ctx).pushReplacementNamed(CheckoutPage.routeName), height: size.maxHeight * 0.07, width: size.maxWidth * HomePage.screenWidthMultiplier))
        ],
      )
    );
  }

  Widget _buildAPriceRow(String title, double price) {
    return Row(
      children: [
        SizedBox(width: size.maxWidth * 0.4, child: Text(title, style: Theme.of(ctx).textTheme.caption.copyWith(fontSize: 11)),),
        Expanded(child: Text(":", style: Theme.of(ctx).textTheme.caption)),
        SizedBox(width: size.maxWidth * 0.4, child: Text("${PGSK.currency}${price.toString()}\n", style: Theme.of(ctx).textTheme.caption))
      ],
    );
  }

  ///if width is non-null, then buildCartTabView is to be rendered as a full page.
  ///else, its width is determined by the parent widget, which is explore_screen
  ///@Total is = subTotal, which is just the total sum of all products in cart
  Widget _buildCartTabView(List<ProductAndQuantity> products, {@required double total, double width}) {
    return Column(
      children: [
        Center(child: SizedBox(
          height: size != null ? size.maxHeight * 0.4 : null,
          width: width != null ? width : size.maxWidth * HomePage.screenWidthMultiplier,
          child: _buildCartItems(products))),
        Expanded(
          child: _buildPriceBreakdown(
            subTotal: total,
            shippingFee: 9.90,
            tax: 6.50,
            total: 185.40
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Cart cartProvider = Provider.of<Cart>(context);
    ctx = context;
    cartProvider.fetchMyCart();

    //if size is null, then cart page should be rendered as a full page
    if (size == null) {
      return Scaffold(
        body: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomAppBar(size: constraints, title: "Cart", trailing: SizedBox()),
              _buildCartTabView(cartProvider.productsAndQuantity, 
                total: cartProvider.total,
                width: constraints.maxWidth * HomePage.screenWidthMultiplier)
            ]
          );
        }
        )
      );
    }

    return _buildCartTabView(cartProvider.productsAndQuantity, total: cartProvider.total);
  }
}

///ProductAndQuantity encapsulates the quantity of a type of product to the quantity of it in the cart
class ProductAndQuantity {

  ///quantity is the amount of this.product in the cart since there can be more than one this.product in the cart
  ///quantity is made an optional arg so that users of this class can either increment/decrement quantity directly
  ///or pass in a whole value for it
  int quantity = 0;
  final Product product;

  ProductAndQuantity(this.product, [int _quantity]) {
    if(_quantity != null) quantity = _quantity;
  }

  ///from counts the quantity of a product type in products 
  ///to generate a ProductAndQuantity object for each product type and quantity.
  ///Products are differentiated by their product.name property.
  ///Note that @param products is modified in the method. Therefore it is recommended to pass in a copy
  ///of the actual products list using List<>.from() constructor
  static List<ProductAndQuantity> from({@required List<Product> products}) {
    List<ProductAndQuantity> productsAndQuantities = List<ProductAndQuantity>();
    int length = products.length;
    Product product;

    while(length != 0) {
      product = products.first;
      final int initialLength = products.length;
      //removes all occurrences of product.name
      products.removeWhere( (otherProduct) => otherProduct.name.compareTo(product.name) == 0);
      final int truncatedLength = products.length;
      length = truncatedLength;
      final int quantity = initialLength - truncatedLength;
      productsAndQuantities.add(ProductAndQuantity(product, quantity));
    }

    return productsAndQuantities;
  }
}
