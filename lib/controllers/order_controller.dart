import 'package:bu_united_flutter_app/apiservices/order_service.dart';
import 'package:bu_united_flutter_app/models/order.dart';
import 'package:bu_united_flutter_app/models/simple_order.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {

  Rx<Order> order = Order().obs;
  RxList<SimpleOrder?> allOrders = RxList<SimpleOrder>();

  var isLoading = false.obs;
  var isMyOrdersLoading = false.obs;
  var isViewLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

  }


  Future<Order?> createAnOrder(Order order) async {
    try {
      isLoading(true);
      var mOrder = await OrderApiService().createAnOrder(order);
      return mOrder;
    } finally {
      isLoading(false);
    }
  }
  Future<Order?> getOrderByNumber(String orderNumber) async {
    try {
      isLoading(true);
      var mOrder = await OrderApiService().getOrderByNumber(orderNumber);
      order(mOrder);

      return mOrder;
    } finally {
      isLoading(false);
    }
  }
  Future<List<SimpleOrder>?> getMyOrders(String email) async {
    try {
      isMyOrdersLoading(true);
      var mOrders = await OrderApiService().getMyOrders(email);
      print(" new orders = " + mOrders!.length.toString());
      allOrders(mOrders);
      return mOrders;
    } finally {
      isMyOrdersLoading(false);
    }
  }



}
