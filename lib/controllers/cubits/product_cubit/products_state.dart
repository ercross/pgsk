part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class InitialProducts extends ProductsState {}

class AllProducts extends ProductsState {
  final List<Product> allProducts;

  const AllProducts(this.allProducts);

  @override
  List<Object> get props => [allProducts];
}

class ProductsByCategory extends ProductsState {
  final List<Product> categoryProducts;

  const ProductsByCategory(this.categoryProducts);


  @override
  List<Object> get props => [categoryProducts];
}
