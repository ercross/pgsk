import 'package:equatable/equatable.dart';

import '../../core/entities/order.dart';

class OrderModel extends Equatable {
  final Map<String, dynamic> map;

  const OrderModel(this.map);
  
  //TODO: extract shipping and billing info fields once shippingInfo class has been implemented
  ///map should be empty and ensure map is initialized before assigning it to from().
  OrderModel.from(Order order, this.map) {
    map.putIfAbsent('totalAmount', ()=> order.totalAmount);
    map.putIfAbsent('products', ()=> order.products);
    map.putIfAbsent('shippingInfo', () => order.shippingInfo);
    map.putIfAbsent('billingInfo', () => order.billingInfo);
  }

  Order toOrder() => Order(
    totalAmount: map['totalAmount'],
    products: map['products'],
    shippingInfo: map['shippingInfo'],
    billingInfo: map['billingInfo']
  );

  @override
  List<Object> get props => [map];

}