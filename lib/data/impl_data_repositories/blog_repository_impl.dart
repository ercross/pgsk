import 'package:http/http.dart' as http;

import '../../core/data_repositories/blog_repository.dart';
import '../../core/entities/blog_item.dart';
import 'local_storage_repository_impl.dart';

class BlogRepositoryImpl extends BlogRepository {

  static const String apiUrlSuffix = '/blog';

  @override
  Future<List<BlogItem>> fetchAllBlogs() async {
    http.Response response = await http.get(LocalStorageRepositoryImpl.apiUrl + apiUrlSuffix);
    
  }

}