import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pgsk/core/entities/product_category.dart';
import 'package:pgsk/core/functionalities/custom_exceptions/no_internet_connection_exception.dart';
import 'package:pgsk/core/repositories/data_repositories/entities_repository.dart';

part 'product_category_state.dart';

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  final EntitiesRepository entitiesRepository;

  ProductCategoryCubit(this.entitiesRepository) : super(ProductCategoryInitial());

  void fetchAllCategories() async {
    try {
      List<ProductCategory> categories = await entitiesRepository.fetchAllProductCategories();
      emit(AllCategories(categories));
    } on NoInternetConnectionException catch (error) {
      throw error;
    }
  }
}
