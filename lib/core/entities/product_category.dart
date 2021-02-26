import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'product.dart';

class ProductCategory extends Equatable {
  final int id;
  final String name;
  final List<Product> products;

  const ProductCategory({
    this.id,
    @required this.name,
    @required this.products
  });

  @override
  List<Object> get props => [id, name, products];

}