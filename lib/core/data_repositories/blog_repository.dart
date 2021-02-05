import '../entities/blog_item.dart';

abstract class BlogRepository {

  Future<List<BlogItem>> fetchAllBlogs();
}