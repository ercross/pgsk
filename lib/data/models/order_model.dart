import 'package:equatable/equatable.dart';

import '../../core/entities/order.dart';

class OrderModel extends Equatable {
  final Map<String, dynamic> map;

  const OrderModel(this.map);
  
  //TODO: extract shipping and billing info fields once shippingInfo class has been implemented
  ///map should be empty and ensure map is initialized before assigning it to from().
  OrderModel.from(Order order, this.map) {
    map.putIfAbsent('date', () => order.date);
    map.putIfAbsent('id', () => order.id);
    map.putIfAbsent('totalAmount', ()=> order.totalAmount);
    map.putIfAbsent('product', ()=> order.product);
    map.putIfAbsent('status', () => order.status);
  }

  Order toOrder() => Order(
    status: map['status'],
    date: map['date'],
    id: map['id'],
    totalAmount: map['totalAmount'],
    product: map['product'],
  );

  @override
  List<Object> get props => [map];

}