import 'package:equatable/equatable.dart';

class ProductReview extends Equatable {
  final String id;
  final String review;
  final int starRating;

  const ProductReview({this.id, this.review, this.starRating});

  @override
  List<Object> get props => [id, review, starRating];

}