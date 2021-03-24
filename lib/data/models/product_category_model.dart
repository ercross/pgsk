import 'package:equatable/equatable.dart';

import '../../core/entities/product_category.dart';

class ProductCategoryModel extends Equatable{
  final Map<String, dynamic> map;

  const ProductCategoryModel(this.map);

  ProductCategoryModel.from(ProductCategory category, this.map) {
    map.putIfAbsent('id', () => category.id);
    map.putIfAbsent('name', () => category.name);
    map.putIfAbsent('products', () => category.products);
    map.putIfAbsent('imageUrl', () => category.imageUrl);
  }

  ProductCategory toProductCategory() => ProductCategory(
    id: map['id'],
    name: map['name'],
    products: map['products'],
    imageUrl: map['imageUrl'],
  );

  @override
  List<Object> get props => [map];
}