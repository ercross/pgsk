import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pgsk/core/repositories/data_repositories/entities_repository.dart';

part 'product_category_state.dart';

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  final EntitiesRepository entitiesRepository;

  ProductCategoryCubit(this.entitiesRepository) : super(ProductCategoryInitial());
}
