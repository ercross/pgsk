import 'package:equatable/equatable.dart';

import '../../core/entities/blog_item.dart';

class BlogItemModel extends Equatable{

  final Map<String, dynamic> map;

  BlogItemModel(this.map);

  ///map should be empty and ensure map is initialized before assigning it to from().
  BlogItemModel.from(BlogItem blogItem, this.map) {
    map.putIfAbsent('articleUrl', () => blogItem.articleUrl);
    map.putIfAbsent('articleIntro', () => blogItem.articleIntro);
    map.putIfAbsent('imageUrl', () => blogItem.imageUrl);
  }

  BlogItem toBlogItem() => BlogItem(
    articleIntro: map['articleIntro'],
    articleUrl: map['articleUrl'],
    imageUrl: map['imageUrl'],
  );

  @override
  List<Object> get props => [map];

}