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

  ///inWishlist indicates if this product has already been added to the wishlist
  //This shouldn't be added to the product entity. It could have been checked by checking if the product is in the wishlist
  //but this method would take more time than this simple boolean check
  //Future versions may/may not change this.
  //Note that inWishlist does not automatically add this product into wishlist. That is done within FavoriteButton
  bool inWishlist; 

  Product({
    this.id,
    this.inWishlist = false,
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
  List<Object> get props => [id, name, price, categoryName, description, specification, reviews, imageUrl, customersRatings, inWishlist];

  @override
    String toString() => "product name: $name" +
                            "\nid: $id \ncategory: $categoryName" + 
                            "\nprice: $price \ndescription: $description \nspecification: $specification, ";
}