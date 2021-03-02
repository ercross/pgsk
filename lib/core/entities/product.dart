import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'product_review.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String categoryName;
  final double price;
  final String description;
  final String specification;
  final String imageUrl;
  final List<ProductReview> reviews;
  final int customersRatings;

  const Product({
    this.id,
    @required this.name,
    @required this.categoryName,
    @required this.price,
    @required this.description,
    this.reviews,
    this.customersRatings = 0,
    @required this.specification,
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [id, name, price, categoryName, description, specification, reviews, imageUrl, customersRatings];

  @override
    String toString() => "product name: $name" +
                            "\nid: $id \ncategory: $categoryName" + 
                            "\nprice: $price \ndescription: $description \nspecification: $specification, ";
}