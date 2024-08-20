import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controller/categroy_controller.dart';
import 'package:multi_store_app/controller/subcategory_controller.dart';
import 'package:multi_store_app/models/categroy_model.dart';
import 'package:multi_store_app/models/subcategory_model.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/header_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // A future that Will hold the list of categories once loaded from API

  List<Subcategory> _subcategories = [];
  final SubcategoryController _subcategoryController = SubcategoryController();
  late Future<List<Category>> futureCategory;
  Category? _selectedCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategory = CategoryController().loadcategories();
    //once the categories are loaded procces then

    futureCategory.then((categories) {
      // ietrate throught the categories to find the "Fashion" category
      for (var category in categories) {
        if (category.name == "Fashion") {
          // if "fashion" category is found , set it as the selected catgeory

          setState(() {
            _selectedCategory = category;
          });
          // this will load subcategories base on the category name
          _loadSubCategories(category.name);
        }
      }
    });
  }

  // this will load subcategories based on category name
  Future<void> _loadSubCategories(String categoryName) async {
    final subcategoies = await _subcategoryController
        .getSubCategoriesByCategoryName(categoryName);

    setState(() {
      _subcategories = subcategoies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height) * 20,
        child: const HeaderWidget(),
      ),
      body: Row(
        children: [
          // left side - Display categroy

          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              child: FutureBuilder(
                future: futureCategory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error:${snapshot.error}'),
                    );
                  } else {
                    final categories = snapshot.data;
                    return ListView.builder(
                      itemCount: categories!.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });

                            _loadSubCategories(category.name);
                          },
                          title: Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                              color: _selectedCategory == category
                                  ? Colors.blue
                                  : Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),

// Right side - Display selected category details
          Expanded(
              flex: 5,
              child: _selectedCategory != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _selectedCategory!.name,
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.7,
                            ),
                          ),
                        ),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                _selectedCategory!.banner,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        _subcategories.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: _subcategories.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 4),
                                itemBuilder: (context, index) {
                                  final subcategory = _subcategories[index];
                                  return Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                        ),
                                        child: Center(
                                          child: Image.network(
                                            subcategory.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          subcategory.categoryName,
                                          style: GoogleFonts.quicksand(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  'No sub categories',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    letterSpacing: 1.7,
                                  ),
                                ),
                              )
                      ],
                    )
                  : Container())
        ],
      ),
    );
  }
}
