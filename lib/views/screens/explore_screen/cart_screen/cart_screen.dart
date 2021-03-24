import 'package:flutter/material.dart';
import '../../../../controllers/providers/cart.dart';
import '../../checkout_screen/checkout_screen.dart';
import '../../home_screen/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../../core/entities/product.dart';
import '../../../../main.dart';
import '../../../widgets/gradient_colored_long_action_button.dart';
import '../../home_screen/homepage.dart';
import 'product_card_cart_screen.dart';

///CartPage contains the cartpage. If size is omitted, CartPage is rendered as a full page through scaffold
class CartPage extends StatelessWidget {
  final bool isFullPage;

  CartPage({@required this.isFullPage});

  BuildContext ctx;

  Widget _buildCartItems(List<ProductAndQuantity> productAndQuantity,
      {@required double maxHeight}) {
    final List<ProductCardCartPage> productCards = [];

    for (int i = 0; i < productAndQuantity.length; i++) {
      productCards.add(ProductCardCartPage(
        containerheight: maxHeight * 0.14,
        quantity: productAndQuantity[i].quantity,
        product: productAndQuantity[i].product,
      ));
    }

    return ListView(children: productCards);
  }

  Widget _buildPriceBreakdown({
    @required double maxWidth,
    @required double maxHeight,
    @required double subTotal,
    @required Cart cart,
  }) {
    return Container(
        width: maxWidth,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow()],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            _buildAPriceRow("Subtotal", subTotal),
            Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.bottomCenter,
                child: GradientColoredLongActionButton(
                    text: "CHECKOUT",
                    onPressed: () => cart.totalNumberOfProducts == 0
                        ? () {
                            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                              backgroundColor:
                                  PGSK.accentColor.withOpacity(0.6),
                              content: Text("Cart is empty",
                                  style: Theme.of(ctx)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(color: Colors.white)),
                            ));
                          }
                        : Navigator.of(ctx)
                            .pushReplacementNamed(CheckoutPage.routeName),
                    height: maxHeight * 0.07,
                    width: maxWidth * HomePage.screenWidthMultiplier))
          ],
        ));
  }

  Widget _buildAPriceRow(String title, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(title,
            style: Theme.of(ctx).textTheme.caption.copyWith(fontSize: 11)),
        Expanded(
            child: Center(
                child: Text(":", style: Theme.of(ctx).textTheme.caption))),
        Text("${PGSK.currency}${price.toString()}\n",
            style: Theme.of(ctx).textTheme.caption)
      ],
    );
  }

  ///if width is non-null, then buildCartTabView is to be rendered as a full page.
  ///else, its width is determined by the parent widget, which is explore_screen
  ///@Total is = subTotal, which is just the total sum of all products in cart
  Widget _buildCartTabView(List<ProductAndQuantity> products,
      {@required double subTotal,
      @required Cart cart,
      @required double maxHeight,
      @required double maxWidth}) {
    return SizedBox(
      height: maxHeight,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
                height: maxHeight * 0.4,
                width: maxWidth * HomePage.screenWidthMultiplier,
                child: _buildCartItems(products, maxHeight: maxHeight)),
          ),
          _buildPriceBreakdown(
              cart: cart,
              subTotal: subTotal,
              maxHeight: maxHeight,
              maxWidth: maxWidth)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Cart cartProvider = Provider.of<Cart>(context);
    ctx = context;
    cartProvider.fetchMyCart();

    if (isFullPage)
      return PGSK.buildFullPage(
          child: LayoutBuilder(builder: (ctx, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomAppBar(
                  size: constraints,
                  title: "Cart",
                  centerTitle: "Cart",
                  leading: GestureDetector(
                    child:
                        Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  trailing: SizedBox(),
                ),
                Expanded(
                  child: _buildCartTabView(
                    cartProvider.productsAndQuantity,
                    maxHeight: constraints.maxHeight,
                    maxWidth: constraints.maxWidth,
                    cart: cartProvider,
                    subTotal: cartProvider.total,
                  ),
                )
              ]),
        );
      }));
    else
      return LayoutBuilder(
        builder: (_, constraints) => _buildCartTabView(
            cartProvider.productsAndQuantity,
            subTotal: cartProvider.total,
            cart: cartProvider,
            maxHeight: constraints.maxHeight,
            maxWidth: constraints.maxWidth),
      );
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
    if (_quantity != null) quantity = _quantity;
  }

  ///from counts the quantity of a product type in products
  ///to generate a ProductAndQuantity object for each product type and quantity.
  ///Products are differentiated by their product.name property.
  ///Note that @param products is modified in the method. Therefore it is recommended to pass in a copy
  ///of the actual products list using List<>.from() constructor
  static List<ProductAndQuantity> from({@required List<Product> products}) {
    List<ProductAndQuantity> productsAndQuantities = [];
    int length = products.length;
    Product product;

    while (length != 0) {
      product = products.first;
      final int initialLength = products.length;
      //removes all occurrences of product.name
      products.removeWhere(
          (otherProduct) => otherProduct.name.compareTo(product.name) == 0);
      final int truncatedLength = products.length;
      length = truncatedLength;
      final int quantity = initialLength - truncatedLength;
      productsAndQuantities.add(ProductAndQuantity(product, quantity));
    }

    return productsAndQuantities;
  }
}
