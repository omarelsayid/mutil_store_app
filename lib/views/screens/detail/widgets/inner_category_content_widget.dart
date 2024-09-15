import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controller/product_controller.dart';
import 'package:multi_store_app/controller/subcategory_controller.dart';
import 'package:multi_store_app/models/categroy_model.dart';
import 'package:multi_store_app/models/product.dart';
import 'package:multi_store_app/models/subcategory_model.dart';
import 'package:multi_store_app/views/screens/detail/widgets/inner_banner_widegt.dart';
import 'package:multi_store_app/views/screens/detail/widgets/inner_header_widget.dart';
import 'package:multi_store_app/views/screens/detail/widgets/subcategory_tile_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class InnerCategoryContentWidget extends StatefulWidget {
  const InnerCategoryContentWidget({super.key, required this.category});
  final Category category;
  @override
  State<InnerCategoryContentWidget> createState() =>
      _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryContentWidget> {
  late Future<List<Subcategory>> _subCategories;
  final SubcategoryController _subcategoryController = SubcategoryController();
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _subCategories = _subcategoryController
        .getSubCategoriesByCategoryName(widget.category.name);
    futureProducts =
        ProductController().loadProductByCategory(widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 20),
          child: const InnerHeaderWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InnerBannerWidegt(
              image: widget.category.banner,
            ),
            Center(
              child: Text(
                'Shop By categories',
                style: GoogleFonts.quicksand(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.7,
                ),
              ),
            ),
            FutureBuilder(
                future: _subCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      // Add return statement here
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No  Subcategories'),
                    );
                  } else {
                    final subcategories = snapshot.data;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: List.generate(
                            (subcategories!.length / 7).ceil(), (setIndex) {
                          // for each row, calculate the startting and ending indices
                          final start = setIndex * 7;
                          final end = (setIndex + 1) * 7;

                          // create a padding widget to add spacing arround row
                          return Padding(
                            padding: EdgeInsets.all(8.9),
                            child: Row(
                              // create a row of the subcategory tie
                              children: subcategories
                                  .sublist(
                                      start,
                                      end > subcategories.length
                                          ? subcategories.length
                                          : end)
                                  .map((subcategory) => SubcategoryTileWidget(
                                      image: subcategory.image,
                                      title: subcategory.subCategoryName))
                                  .toList(),
                            ),
                          );
                        }),
                      ),
                    );
                  }
                }),
            const ReusableTextWidget(
                tilte: 'Popular Product', subTilte: 'View all'),
            FutureBuilder(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No popular Products'),
                  );
                }
                final products = snapshot.data;
                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductItemWidget(
                        product: product,
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
