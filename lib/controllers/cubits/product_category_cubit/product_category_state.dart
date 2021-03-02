part of 'product_category_cubit.dart';

abstract class ProductCategoryState extends Equatable {
  const ProductCategoryState();

  @override
  List<Object> get props => [];
}

class ProductCategoryInitial extends ProductCategoryState {}

class CategoriesNames extends ProductCategoryState {
  final List<String> categoriesNames;

  const CategoriesNames(this.categoriesNames);

  @override
  List<Object> get props => [categoriesNames];
}

class AllCategories extends ProductCategoryState {
  final List<ProductCategory> productCategories;

  const AllCategories(this.productCategories);

  @override
  List<Object> get props => [productCategories];
}

