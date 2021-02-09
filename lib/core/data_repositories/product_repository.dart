import '../entities/product.dart';
import '../entities/product_category.dart';

abstract class ProductRepository{

  Future<List<Product>> fetchAllProducts();

  Future<List<Product>> fetchBy(ProductCategory productCategory);
}