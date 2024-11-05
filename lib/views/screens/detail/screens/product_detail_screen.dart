import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../nav_screens/widgets/product_item_widget.dart';
import '../../../../controller/product_controller.dart';
import '../../../../provider/favourite_provider.dart';
import '../../../../provider/related_products_provider.dart';
import '../../nav_screens/widgets/reusable_text_widget.dart';
import '../../../../models/product.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../services/manage_http_response.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController
          .loadRelatedProductsBySubcategory(widget.product.id);
      ref.read(relatedProductsProvider.notifier).setProduct(products);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final relatedProduct = ref.watch(relatedProductsProvider);
    final cartProviderData = ref.read(cartprovider.notifier);
    final cartData = ref.watch(cartprovider);
    ref.watch(favouriteProvider);
    final isInCart = cartData.containsKey(widget.product.id);
    final favouriteProviderData = ref.read(favouriteProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.productName,
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                favouriteProviderData.addFavourite(
                    productName: widget.product.productName,
                    category: widget.product.category,
                    image: widget.product.images,
                    vendorId: widget.product.vendorId,
                    productPrice: widget.product.productPrice,
                    productQuantity: widget.product.quantity,
                    productId: widget.product.id,
                    productDescription: widget.product.description,
                    fullName: widget.product.fullName,
                    quantity: 1);
                showSnackBar(context,
                    'added to ${widget.product.productName}} favourite');
              },
              icon: favouriteProviderData.favouriteItems
                      .containsKey(widget.product.id)
                  ? Icon(Icons.favorite, color: Colors.red.shade600)
                  : const Icon(Icons.favorite_border)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 260,
                height: 275,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    Positioned(
                        left: 0,
                        top: 50,
                        child: Container(
                          width: 260,
                          height: 260,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            color: Color(0XFFD8DDFF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(130),
                            ),
                          ),
                        )),
                    Positioned(
                      left: 22,
                      top: 0,
                      child: Container(
                        width: 216,
                        height: 274,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9CA8FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: SizedBox(
                          height: 300,
                          child: PageView.builder(
                            itemCount: widget.product.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: widget.product.images[index],
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.productName,
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: const Color(0xFF3C55Ef),
                    ),
                  ),
                  Text(
                    '\$${widget.product.productPrice}',
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3C55Ef),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.product.category,
              style: GoogleFonts.roboto(
                color: Colors.grey,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                widget.product.totalRatings == 0
                    ? const Text('')
                    : const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.star, color: Colors.amber, size: 18),
                      ),
                Text(widget.product.avrageRating.toString(),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  "(${widget.product.totalRatings})",
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: GoogleFonts.lato(
                        fontSize: 17,
                        letterSpacing: 1.7,
                        color: const Color(0xFF363330)),
                  ),
                  Text(
                    widget.product.description,
                    style: GoogleFonts.mochiyPopOne(
                      fontSize: 15,
                      letterSpacing: 2,
                    ),
                  )
                ],
              ),
            ),
            const ReusableTextWidget(tilte: 'related products', subTilte: ''),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: relatedProduct.length,
                itemBuilder: (context, index) {
                  final product = relatedProduct[index];
                  return ProductItemWidget(
                    product: product,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: isInCart
              ? null
              : () {
                  cartProviderData.addProductToCart(
                    productName: widget.product.productName,
                    productPrice: widget.product.productPrice,
                    category: widget.product.category,
                    image: widget.product.images,
                    vendorId: widget.product.vendorId,
                    productQuantity: widget.product.quantity,
                    quantity: 1,
                    productId: widget.product.id,
                    productDescription: widget.product.description,
                    fullName: widget.product.fullName,
                  );

                  showSnackBar(
                    context,
                    widget.product.productName,
                  );
                },
          child: Container(
            width: 386,
            height: 46,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isInCart ? Colors.grey : const Color(0xFF3B54EE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
                child: Text(
              'ADD TO CART',
              style: GoogleFonts.mochiyPopOne(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
