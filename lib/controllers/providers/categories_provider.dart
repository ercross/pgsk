import 'package:flutter/material.dart';
import 'package:pgsk/core/repositories/data_repositories/entities_repository.dart';

class CategoriesProvider with ChangeNotifier {
  List<String> _categoriesNames = List<String>();
  final EntitiesRepository entitiesRepository;

  CategoriesProvider(this._categoriesNames);

  List<String> get categoriesNames => _categoriesNames;

  void fetchCategoriesNames() {
    
  }
}