import 'package:equatable/equatable.dart';

import '../../core/entities/product.dart';


class ProductModel extends Equatable {

  final Map<String, dynamic> map;

  const ProductModel(this.map);

  ///map should be empty and ensure map is initialized before assigning it to from().
  ProductModel.from(Product product, this.map) {
    map.putIfAbsent("id", ()=>product.id);
    map.putIfAbsent("name", ()=>product.name);
    map.putIfAbsent("price", ()=>product.price);
    map.putIfAbsent("categoryName", ()=>product.categoryName);
    map.putIfAbsent("description", ()=>product.description);
    map.putIfAbsent("specification", ()=>product.specification);
    map.putIfAbsent("imageUrl", ()=>product.imageUrl);
    map.putIfAbsent("reviews", ()=>product.reviews);
    map.putIfAbsent("customersRatings", ()=>product.customersRatings);
  }

  Product toProduct() => Product(
    categoryName: map["categoryName"],
    id: map['id'],
    name: map['name'],
    price: map['price'],
    description: map['description'],
    specification: map['specification'],
    reviews: map['reviews'],
    imageUrl: map['imageUrl'],
    customersRatings: map['customersRatings']
  );
 
  @override
  List<Object> get props => [map];
}