import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../controller/categroy_controller.dart';
import '../../../../provider/category_provider.dart';
import '../../detail/screens/inner_category_screen.dart';
import 'reusable_text_widget.dart';

class CategroyItemWidget extends ConsumerStatefulWidget {
  const CategroyItemWidget({super.key});

  @override
  ConsumerState<CategroyItemWidget> createState() => _CategroyWidgetState();
}

class _CategroyWidgetState extends ConsumerState<CategroyItemWidget> {
  // A future that Will hold the list of categories once loaded from API

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategroies();
  }

  Future<void> _fetchCategroies() async {
    final CategoryController categoryController = CategoryController();
    try {
      final categories = await categoryController.loadcategories();
      ref.read(categoryProvider.notifier).setCategories(categories);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      children: [
        const ReusableTextWidget(tilte: 'Categories', subTilte: 'View all'),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
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
        )
      ],
    );
  }
}
