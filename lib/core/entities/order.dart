import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'product.dart';

enum OrderStatus {
  pending,
  cleared,
}

class Order extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime settledAt;
  ///totalAmount includes 
  final double totalAmount;
  final Product product;
  final OrderStatus status;

  Order({
    this.settledAt,
    @required this.createdAt,
    @required this.status,
    @required this.id,
    @required this.totalAmount, 
    @required this.product, 
  });

  @override
  List<Object> get props => [id, totalAmount, product];

}