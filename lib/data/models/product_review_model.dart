import 'package:equatable/equatable.dart';
import '../../core/entities/product_review.dart';

class ProductReviewModel extends Equatable {
  final Map<String, dynamic> map;

  ///Note that @param map must be empty
  const ProductReviewModel(this.map);

  ProductReviewModel.from(ProductReview productReview, this.map) {
    map.putIfAbsent("id", ()=>productReview.id);
    map.putIfAbsent("review", ()=>productReview.review);
    map.putIfAbsent("starRating", ()=>productReview.starRating);
    map.putIfAbsent("productId", ()=>productReview.productId);
    map.putIfAbsent("writerName", ()=>productReview.writerName);
  }

  ProductReview toProductReview() => ProductReview(
    id: map['id'],
    review: map['review'],
    productId: map['productId'],
    starRating: map['starRating'],
    writerName: map['writerName'],
  );

  @override
  List<Object> get props => [map];

}