import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'billing_info.dart';
import 'product.dart';
import 'shipping_info.dart';

class Order extends Equatable {
  final double totalAmount;
  final List<Product> products;
  final ShippingInfo shippingInfo;
  final BillingInfo billingInfo;

  Order({
    @required this.totalAmount, 
    @required this.products, 
    @required this.shippingInfo, 
    @required this.billingInfo});

  @override
  List<Object> get props => [totalAmount, products, shippingInfo, billingInfo];

}