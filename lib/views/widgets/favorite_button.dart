import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/wishlist.dart';
import '../../core/entities/product.dart';

class FavoriteButton extends StatefulWidget {

  //product is passed in here so as to edit its product.inWishlist field
  //since passing the field as an argument into the constructor copies the value instead
  final Product product;

  FavoriteButton(this.product);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  static final List<Color> _colors = [Colors.grey, Colors.red];
  static final List<Icon> _icons = [
    Icon(Icons.favorite_outline_rounded, color:_colors[0]),
    Icon(Icons.favorite_rounded, color: _colors[1])
  ];
  Widget _currentIcon;

  @override
  Widget build(BuildContext context) {

    final Wishlist wishlist = Provider.of<Wishlist>(context, listen: false);

    //initialize _currentIcon first time rendering favorite
    if (_currentIcon == null) {
      if(widget.product.inWishlist) _currentIcon = _icons[1];
      else _currentIcon = _icons[0];
    }

    return GestureDetector(
                onTap: () => setState(() {
                  if (widget.product.inWishlist == false) {
                    widget.product.inWishlist = true;
                    wishlist.addProduct(widget.product);
                    _currentIcon = _icons[1];

                  } 
                  else if (widget.product.inWishlist) {
                    widget.product.inWishlist = false;
                    wishlist.removeProduct(widget.product);
                    _currentIcon = _icons[0];
                  } 
                }) ,
                child: _currentIcon);
  }
}