import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'product.dart';

enum OrderStatus {
  pending,
  cleared,
}

class Order extends Equatable {
  final String id;
  final DateTime date;
  final double totalAmount;
  final Product product;
  final OrderStatus status;

  Order({
    @required this.status,
    @required this.id,
    @required this.date,
    @required this.totalAmount, 
    @required this.product, 
  });

  @override
  List<Object> get props => [id, totalAmount, product];

}