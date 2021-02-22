
import 'package:flutter/material.dart';

import '../../../../core/entities/product.dart';
import '../../../../core/entities/product_category.dart';
import '../../../../main.dart';
import '../../../widgets/gradient_colored_long_action_button.dart';
import '../../home_screen/homepage.dart';
import 'product_card_cart_screen.dart';

class CartPage extends StatelessWidget {
  final BoxConstraints size;
  CartPage(this.size);

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
          Align(alignment: Alignment.bottomCenter, child: GradientColoredLongActionButton(text: "CHECK OUT", onPressed: (){}, height: size.maxHeight * 0.07, width: size.maxWidth * HomePage.screenWidthMultiplier))
        ],
      )
    );
  }

  BuildContext ctx;

  Widget _buildAPriceRow(String title, double price) {
    return Row(
      children: [
        SizedBox(width: size.maxWidth * 0.4, child: Text(title, style: Theme.of(ctx).textTheme.caption.copyWith(fontSize: 11)),),
        Expanded(child: Text(":", style: Theme.of(ctx).textTheme.caption)),
        SizedBox(width: size.maxWidth * 0.4, child: Text("${PGSK.currency}${price.toString()}\n", style: Theme.of(ctx).textTheme.caption))
      ],
    );
  }

  ///mapProductToQuantity counts the quantity of a product type in products 
  ///to generate a ProductAndQuantity object for each product type and quantity.
  ///Products are differentiated by their product.name property.
  ///Note that @param products is modified in the method. Therefore it is recommended to pass in a copy
  ///of the actual products list using List<>.from() constructor
  List<ProductAndQuantity> _mapProductToQuantity(List<Product> products) {
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
      productsAndQuantities.add(ProductAndQuantity(quantity, product));
    }

    return productsAndQuantities;
  }

  @override
  Widget build(BuildContext context) {
    final moreProducts = List<Product>.from(_moreProducts);
    List<ProductAndQuantity> products = _mapProductToQuantity(moreProducts);
    print(products);
    ctx = context;
    return Column(
      children: [
        Center(child: SizedBox(
          height: size.maxHeight * 0.4,
          width: size.maxWidth * 0.85,
          child: _buildCartItems(products))),
        Expanded(
          child: _buildPriceBreakdown(
            subTotal: 160,
            shippingFee: 9.90,
            tax: 6.50,
            total: 185.40
          ),
        )
      ],
    );
  }
}

class ProductAndQuantity {
  final int quantity;
  final Product product;

  const ProductAndQuantity(this.quantity, this.product);
}