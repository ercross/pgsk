import 'package:equatable/equatable.dart';

import '../../core/entities/product_category.dart';

class ProductCategoryModel extends Equatable{
  final Map<String, dynamic> map;

  const ProductCategoryModel(this.map);

  ProductCategoryModel.from(ProductCategory category, this.map) {
    map.putIfAbsent('id', () => category.id);
    map.putIfAbsent('name', () => category.name);
  }

  ProductCategory toProductCategory() => ProductCategory(
    id: map['id'],
    name: map['name'],
    products: map['products']
  );

  @override
  List<Object> get props => [map];
}