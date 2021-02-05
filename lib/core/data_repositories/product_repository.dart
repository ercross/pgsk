import 'package:meta/meta.dart';

import '../entities/product.dart';

abstract class ProductRepository{

  Future<List<Product>> fetchAllProducts();

  ///named argument productCategory used to improve readability
  Future<List<Product>> fetchBy({@required ProductCategory value});
}