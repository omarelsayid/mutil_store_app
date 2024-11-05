//StatNotifier for delivered order count
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/controller/order_controller.dart';
import 'package:multi_store_app/services/manage_http_response.dart';

class DeliveredOrderCountProvider extends StateNotifier<int> {
  DeliveredOrderCountProvider() : super(0);

  //Method to fetch Delivered Orders count

  Future<void> fetchDeliveredOrderCount(String buyerId, context) async {
    try {
      OrderController orderController = OrderController();
      int count = await orderController.countDeliveredOrders(buyerId: buyerId);
      state = count; //Update the state with the count
    } catch (e) {
      showSnackBar(context, "Error Fetching Delivered order : $e");
    }
  }
}

final deliveredOrderCountProvider =
    StateNotifierProvider<DeliveredOrderCountProvider, int>(
  (ref) {
    return DeliveredOrderCountProvider();
  },
);
