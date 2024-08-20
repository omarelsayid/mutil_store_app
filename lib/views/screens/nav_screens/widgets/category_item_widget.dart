import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controller/categroy_controller.dart';
import 'package:multi_store_app/models/categroy_model.dart';
import 'package:multi_store_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategroyItemWidget extends StatefulWidget {
  const CategroyItemWidget({super.key});

  @override
  State<CategroyItemWidget> createState() => _CategroyWidgetState();
}

class _CategroyWidgetState extends State<CategroyItemWidget> {
  // A future that Will hold the list of categories once loaded from API

  late Future<List<Category>> futureCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategory = CategoryController().loadcategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ReusableTextWidget(tilte: 'Categories', subTilte: 'View all'),
        FutureBuilder(
            future: futureCategory,
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
                  child: Text('No Categories'),
                );
              } else {
                final categories = snapshot.data;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return InnerCategoryScreen(
                              category: category,
                            );
                          },
                        ));
                      },
                      child: Column(
                        // Add return statement here
                        children: [
                          Image.network(
                            height: 57,
                            width: 57,
                            category.image,
                          ),
                          Text(
                            category.name,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
      ],
    );
  }
}
