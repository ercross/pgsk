import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ProductReview extends Equatable {
  final String id;
  final String review;
  final int starRating;
  final int productId;
  final String writerName;

  const ProductReview({
    this.id, 
    @required this.review, 
    @required this.starRating,
    @required this.productId,
    @required this.writerName,
  });

  @override
  List<Object> get props => [id, review, starRating, writerName, productId];

}