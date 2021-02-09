import 'package:flutter/cupertino.dart';
import 'package:pgsk/core/data_repositories/blog_repository.dart';
import 'package:pgsk/core/entities/blog_item.dart';

class Blogs with ChangeNotifier {
  final BlogRepository blogRepository;

  Blogs(this.blogRepository);

  ///blogs is initialized as an empty list. Invoke fetchBlogItems to fetch all blogs items from PGSK server
  List<BlogItem> blogs = List<BlogItem>();

  ///fetchBlogItems fetches all blog items from PGSK server
  void fetchBlogItems() async {
    blogs = await blogRepository.fetchAllBlogs();
    notifyListeners();
  }
}