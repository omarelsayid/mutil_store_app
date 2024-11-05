import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subcategory_model.dart';

class SubcategoryProvider extends StateNotifier<List<Subcategory>> {
  SubcategoryProvider() : super([]);

  //set the list of subcategories
  void setSubcategories(List<Subcategory> subcategories) {
    state = subcategories;
  }
}

final subcategoryProvider =
    StateNotifierProvider<SubcategoryProvider, List<Subcategory>>(
  (ref) {
    return SubcategoryProvider();
  },
);