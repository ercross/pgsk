import 'package:equatable/equatable.dart';
import 'package:pgsk/core/entities/cart.dart';

class CartModel extends Equatable {
  final Map<String, dynamic> map;

  const CartModel(this.map);

  ///map should be empty and ensure map is initialized before assigning it to from().
  CartModel.from(Cart cart, this.map) {
    map.putIfAbsent("numberOfItems", ()=>cart.numberOfItems);
    map.putIfAbsent("products", ()=>cart.products);
    map.putIfAbsent("total", ()=>cart.total);
  }

  Cart toCart() {
    Cart cart = Cart();
    cart.numberOfItems = map['numberOfItems'];
    cart.products.add(map['products']); //TODO ensure products is gotten out of this
    cart.total = map['total'];
    return cart;
  } 

  @override
  List<Object> get props => [map];

}