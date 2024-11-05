import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../provider/favourite_provider.dart';
import '../main_screen.dart';

class FavouriteScreen extends ConsumerStatefulWidget {
  const FavouriteScreen({super.key});

  @override
  ConsumerState<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final wishListData = ref.watch(favouriteProvider).values.toList();
    final wishListProvider = ref.read(favouriteProvider.notifier);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 118,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/icons/cartb.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                    left: 322,
                    top: 52,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/icons/not.png',
                          width: 25,
                          height: 25,
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.yellow[800],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  wishListData.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )),
                Positioned(
                    left: 61,
                    top: 51,
                    child: Text(
                      'My WishList',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
        ),
        body: wishListData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'your wishlist is empty \n you can add product to your cart from the button below',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        letterSpacing: 1.7,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ));
                      },
                      child: const Text('Shop Now'),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: wishListData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final wishData = wishListData[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          decoration: const BoxDecoration(),
                          clipBehavior: Clip.antiAlias,
                          width: 335,
                          height: 95,
                          child: SizedBox(
                            width: double.infinity,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 336,
                                    height: 96,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0xFFEFF0F2),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 13,
                                  top: 9,
                                  child: Container(
                                    width: 78,
                                    height: 78,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFBCC5FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.network(
                                      wishData.image[0],
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 275,
                                  top: 16,
                                  child: Text(
                                    '\$ ${wishData.productPrice}',
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff0B0C1E),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 101,
                                  top: 14,
                                  child: Text(
                                    wishData.productName,
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff0B0C1E),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 284,
                                  top: 47,
                                  child: IconButton(
                                    icon: Image.asset(
                                        width: 25,
                                        height: 28,
                                        fit: BoxFit.cover,
                                        'assets/icons/delete.png'),
                                    onPressed: () {
                                      wishListProvider
                                          .removeFavourite(wishData.productId);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                }));
  }
}
