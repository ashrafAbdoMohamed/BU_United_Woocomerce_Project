import 'package:bu_united_flutter_app/apiservices/cart_service.dart';
import 'package:bu_united_flutter_app/models/woo/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {

  Rx<MyWooCart> myCart = MyWooCart().obs;
  // RxList<WooCartItems?> allCartItems = RxList<WooCartItems>();

  var isLoading = true.obs;
  var isDeleting = false.obs;
  var isIncreasing = false.obs;
  var isDecreasing = false.obs;


  @override
  void onInit() {
    super.onInit();

  }

  Future<MyWooCart?> getMyCart(String userToken) async {
    print("TO TO ; " + userToken);
    try {
      isLoading(true);
      var items = await CartService().getMyCart(userToken);
      myCart(items);
      return items;
    } finally {
      isLoading(false);
    }
  }

  Future<bool?> addToMyCart(String userToken , String productId , String quantity) async {
    try {
      if(quantity == "1") isIncreasing(true);
      if(quantity == "-1") isDecreasing(true);
      bool value = await CartService().addToMyCart(userToken , productId , quantity);
      return value;
    } finally {
      if(quantity == "1") isIncreasing(false);
      if(quantity == "-1") isDecreasing(false);
    }
  }
  Future<bool?> editCartItem(String userToken , String productKey , String quantity) async {
    try {
      isLoading(true);
      bool value = await CartService().editCartItem(userToken , productKey , quantity);
        return value;
    } finally {
      isLoading(false);
    }
  }
  Future<bool?> deleteCartItem(String userToken , String productKey) async {
    try {
      isDeleting(true);
      bool value = await CartService().deleteCartItem(userToken , productKey );
        return value;
    } finally {
      isDeleting(false);
    }
  }


}
