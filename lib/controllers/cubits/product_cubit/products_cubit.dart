import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/entities/product.dart';
import '../../../core/repositories/data_repositories/entities_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final EntitiesRepository entitiesRepository;

  ProductsCubit(this.entitiesRepository) : super(InitialProducts());

  void fetchAllProducts() async {
    List<Product> allProducts = await entitiesRepository.fetchAllProducts();
    emit(AllProducts(allProducts));
  }

  void fetchProductByCategory(String categoryName) async {
    List<Product> productCategory =
        await entitiesRepository.fetchProductsByCategory(categoryName);
    emit(ProductsByCategory(productCategory));
  }
}
