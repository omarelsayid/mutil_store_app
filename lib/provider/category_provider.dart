import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/categroy_model.dart';

class CategoryProvider extends StateNotifier<List<Category>> {
  CategoryProvider() : super([]);

// set the list of categories
  void setCategories(List<Category> categroies) {
    state = categroies;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryProvider, List<Category>>(
  (ref) {
    return CategoryProvider();
  },
);
