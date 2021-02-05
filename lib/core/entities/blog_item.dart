import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class BlogItem extends Equatable{

  final String articleUrl;
  final String imageUrl;
  final String articleIntro;

  BlogItem({
    @required this.articleUrl, 
    @required this.imageUrl, 
    @required this.articleIntro
  });

  @override
  List<Object> get props => [articleUrl, imageUrl, articleIntro];

}