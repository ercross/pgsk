import 'package:equatable/equatable.dart';

import '../../controllers/providers/cart.dart';


class CartModel extends Equatable {
  final Map<String, dynamic> map;
  
  ///Note that @param map must be empty
  const CartModel(this.map);

  ///map should be empty and ensure map is initialized before assigning it to from().
  CartModel.from(Cart cart, this.map) {
    map.putIfAbsent("totalNumberOfProducts", ()=>cart.totalNumberOfProducts);
    map.putIfAbsent("productsAndQuantity", ()=>cart.productsAndQuantity);
    map.putIfAbsent("total", ()=>cart.total);
  }

  Cart toCart() {
    Cart cart = Cart();
    cart.totalNumberOfProducts = map['totalNumberOfProducts'];
    cart.productsAndQuantity.add(map['productsAndQuantity']); //TODO ensure products is gotten out of this
    cart.total = map['total'];
    return cart;
  } 

  @override
  List<Object> get props => [map];

}