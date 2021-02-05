import 'package:flutter/material.dart';

class ProductTV extends StatefulWidget {
  ProductTV({Key key}) : super(key: key);

  @override
  _ProductTV createState() => _ProductTV();
}

class _ProductTV extends State<ProductTV> {

  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
      Expanded(
         child: _buildProductInfo()),
      SizedBox(height: 10,),
      _buildActionButtons(), 
     ],
    );
  }

  Widget _buildProductInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/images/product1.png', fit: BoxFit.scaleDown),
        //SizedBox(width: 30,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            Text("Price Here", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            Text("Product Info", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
          ],
        )
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton("Buy Now", (){}),
        _buildActionButton("To Cart", (){}),
        _buildActionButton("To Wishlist", (){})
      ],
    );
  }

  Widget _buildActionButton(String buttonName, Function onPressed) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(20),
        color: Colors.red,
      ),
      child: Text(buttonName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
    );
  }
}

