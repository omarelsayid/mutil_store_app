import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/cart.dart';

// Define a stateNotifier to expose an instance of the CartNotifier
// Making it accessible within our app
final cartprovider =
    StateNotifierProvider<CartNotifier, Map<String, Cart>>((ref) {
  return CartNotifier();
});

// A notifier class to manage the cart state, extending stateNotifier
// with an initial state of an empty map
class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier() : super({});

  // Method to add product to the cart
  void addProductToCart({
    required final String productName,
    required final int productPrice,
    required final String category,
    required final List<String> image,
    required final String vendorId,
    required final int productQuantity,
    required int quantity,
    required final String productId,
    required final String productDescription,
    required final String fullName,
  }) {
    // check if the product is already in the cart
    if (state.containsKey(productId)) {
      // if the product is already in the cart, update the quantity and maybe other details
      state = {
        ...state,
        productId: Cart(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          category: state[productId]!.category,
          image: state[productId]!.image,
          vendorId: state[productId]!.vendorId,
          productQuantity: state[productId]!.productQuantity,
          quantity: state[productId]!.quantity + 1, // Increment quantity
          productId: state[productId]!.productId,
          productDescription: state[productId]!.productDescription,
          fullName: state[productId]!.fullName,
        )
      };
    } else {
      // if the product is not in the cart, add it with the provided details
      state = {
        ...state, // Retain existing cart items
        productId: Cart(
          productName: productName,
          productPrice: productPrice,
          category: category,
          image: image,
          vendorId: vendorId,
          productQuantity: productQuantity,
          quantity: quantity,
          productId: productId,
          productDescription: productDescription,
          fullName: fullName,
        ),
      };
    }
  }

  // Method to increment the quantity of a product in the cart
  void incrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;

      // Notify listeners that the state has changed
      state = {...state};
    }
  }

  // Method to decrement the quantity of a product in the cart
  void decrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;

      // Notify listeners that the state has changed
      state = {...state};
    }
  }

  // Method to remove an item from the cart
  void removeCartItem(String productId) {
    state.remove(productId);
    // Notify listeners that the state has changed
    state = {...state};
  }

  // Method to calculate the total amount of items we have in the cart
  double calculateTotalAmount() {
    double totalAmount = 0.0;

    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });

    return totalAmount;
  }

  Map<String, Cart> get getCartItems => state;
}
