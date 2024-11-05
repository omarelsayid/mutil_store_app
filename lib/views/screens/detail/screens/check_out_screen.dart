import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../services/manage_http_response.dart';
import '../../main_screen.dart';

import '../../../../controller/order_controller.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/user_provider.dart';
import 'shipping_address_screen.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectedMethod = 'stripe';
  final OrderController _orderController = OrderController();
  @override
  Widget build(BuildContext context) {
    final cartData = ref.read(cartprovider);
    final cartProvider = ref.read(cartprovider.notifier);
    final user = ref.watch(userProvider);
    // final user = ref.read(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const ShippingAddressScreen();
                    },
                  ));
                },
                child: SizedBox(
                  width: 335,
                  height: 74,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 335,
                          height: 74,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(
                                0xFFEFF0F2,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 70,
                        top: 17,
                        child: SizedBox(
                          width: 215,
                          height: 41,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -1,
                                left: -1,
                                child: SizedBox(
                                  width: 219,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 114,
                                          child: user!.state.isNotEmpty
                                              ? const Text(
                                                  'Address',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.1,
                                                  ),
                                                )
                                              : const Text(
                                                  'Add Address',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.1,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: user.state.isNotEmpty
                                            ? Text(
                                                user.state,
                                                style: GoogleFonts.lato(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.3,
                                                ),
                                              )
                                            : Text(
                                                'United state',
                                                style: GoogleFonts.lato(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.3,
                                                ),
                                              ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: user.city.isNotEmpty
                                            ? Text(
                                                user.city,
                                                style: GoogleFonts.lato(
                                                  color:
                                                      const Color(0xFF7F808C),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              )
                                            : Text(
                                                'Enter the City',
                                                style: GoogleFonts.lato(
                                                  color:
                                                      const Color(0xFF7F808C),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: SizedBox.square(
                          dimension: 42,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 43,
                                  height: 43,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFFBF7F5,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: [
                                      Positioned(
                                        left: 11,
                                        top: 11,
                                        child: Image.network(
                                          height: 26,
                                          width: 26,
                                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 305,
                        top: 25,
                        child: Image.network(
                          width: 20,
                          height: 20,
                          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Your Item',
                style: GoogleFonts.quicksand(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                  child: ListView.builder(
                itemCount: cartData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final cartItem = cartData.values.toList()[index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: 336,
                      height: 91,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFEFF0F2),
                          )),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              left: 6,
                              top: 6,
                              child: SizedBox(
                                width: 311,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 78,
                                      height: 78,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFBCC5FF),
                                      ),
                                      child: Image.network(cartItem.image[0]),
                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 78,
                                        alignment: const Alignment(0, -0.51),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  cartItem.productName,
                                                  style: GoogleFonts.quicksand(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.3,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  cartItem.category,
                                                  style: GoogleFonts.lato(
                                                    color: Colors.blueGrey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      '\$ ${cartItem.productPrice.toStringAsFixed(2)}',
                                      style: GoogleFonts.robotoSerif(
                                        fontSize: 14,
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.3,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              )),
              const SizedBox(
                height: 10,
              ),
              Text(
                'choose Payment Method',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RadioListTile<String>(
                title: Text(
                  'stripe',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 'stripe',
                groupValue: selectedMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedMethod = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text(
                  'cash on Delivery',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: 'cashOnDelivery',
                groupValue: selectedMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedMethod = value!;
                  });
                },
              )
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: user.state.isEmpty
            ? TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ShippingAddressScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  'Please ENter Shipping adderss',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.7,
                    fontSize: 17,
                  ),
                ))
            : InkWell(
                onTap: () async {
                  if (selectedMethod == 'stripe') {
                    // pay with stripe
                  } else {
                    await Future.forEach(cartProvider.getCartItems.entries,
                        (entry) {
                      var item = entry.value;

                      _orderController.uploadOrders(
                        context: context,
                        id: '',
                        fullName: ref.read(userProvider)!.fullName,
                        email: ref.read(userProvider)!.email,
                        state: ref.read(userProvider)!.state,
                        city: ref.read(userProvider)!.city,
                        locality: ref.read(userProvider)!.locality,
                        productName: item.productName,
                        productPrice: item.productPrice,
                        quantity: item.quantity,
                        category: item.category,
                        image: item.image[0],
                        buyerId: ref.read(userProvider)!.id,
                        vendorId: item.vendorId,
                        processing: true,
                        delivered: false,
                      );
                    }).then(
                      (value) {
                        cartProvider.clearCart();
                        // ignore: use_build_context_synchronously
                        showSnackBar(context, 'order successfully placed');
                        Navigator.push(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  width: 338,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF3854EE),
                  ),
                  child: Center(
                    child: Text(
                      selectedMethod == 'stripe' ? 'Pay Now' : 'Place holder',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
