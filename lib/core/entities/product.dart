import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'product_category.dart';
import 'product_review.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final ProductCategory productCategory;
  final double price;
  final String description;
  final String specification;
  final String imageUrl;
  final List<ProductReview> reviews;
  final int customersRatings;

  const Product({
    @required this.id,
    @required this.name,
    @required this.productCategory,
    @required this.price,
    @required this.description,
    this.reviews,
    this.customersRatings = 0,
    @required this.specification,
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [id, name, price, productCategory, description, specification, reviews, imageUrl, customersRatings];

  @override
    String toString() => "product name: $name" +
                            "\nid: $id \ncategory: ${productCategory.toString().split(".").last}" + 
                            "\nprice: $price \ndescription: $description \nspecification: $specification, ";
}