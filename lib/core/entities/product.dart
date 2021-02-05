import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ProductCategory{
  smartDevices,
  antivirusProtection,
  internetSecurity,
  mobileSecurity,
  businessSolutions,
  homeSolutions,
}

class Product extends Equatable {
  final String id;
  final String name;
  final ProductCategory productCategory;
  final double price;
  final String description;
  final String specification;
  final String imageUrl;
  final String review;
  final int customersRatings;

  const Product({
    @required this.id,
    @required this.name,
    @required this.productCategory,
    @required this.price,
    @required this.description,
    this.review = "no reviews added yet",
    this.customersRatings = 0,
    @required this.specification,
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [id, name, price, productCategory, description, specification, review, imageUrl, customersRatings];

  @override
    String toString() => "product name: $name" +
                            "\nid: $id \ncategory: ${productCategory.toString().split(".").last}" + 
                            "\nprice: $price \ndescription: $description \nspecification: $specification, ";
}