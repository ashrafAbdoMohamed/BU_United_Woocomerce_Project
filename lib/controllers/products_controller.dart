import 'package:bu_united_flutter_app/apiservices/products_api_service.dart';
import 'package:bu_united_flutter_app/models/Product.dart';
import 'package:bu_united_flutter_app/models/product_category.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {

  // Rx<Category> allCategories = Category().obs;
  RxList<ProductCategory?> allCategoriesList = RxList<ProductCategory>();
  RxList<Product?> allProductsList = RxList<Product>();
  RxList<Product> relatedProducts = RxList<Product>();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // try {
    //   isLoading(true);
    // } finally {
    //   isLoading(false);
    // }
  }

  getAllRelatedProducts(Product product) async {
    try{
      print("6");
      relatedProducts.clear();
      print("7");
      print("8");
      List<Product> mRelatedProducts = [];
      print("9");
      for(int i = 0 ; i < allProductsList.length ; i++){
        for(int j = 0 ; j < product.relatedIds!.length ; j++){
          if(int.parse(product.relatedIds!.elementAt(j).toString()) == int.parse(allProductsList.elementAt(i)!.id.toString())){
            mRelatedProducts.add(allProductsList.elementAt(i)!);
            print("10 a- id =" + allProductsList.elementAt(i)!.id.toString());
            print("semi related b- id =" + product.relatedIds!.elementAt(j).toString());
          }
        }
      }
      print("11");
      relatedProducts(mRelatedProducts);
      print("Related : " + relatedProducts.length.toString());
    }finally{
    }

  }

  Future<List<ProductCategory?>?> getAllProductsCategories() async {
    try {
      isLoading(true);
      var categories = await ProductsApiService().getAllCategories() ;
      // List<ProductCategory> list = [];
      // for(int i = 0 ; i < categories!.length ; i++){
      //   list.add(categories[i]!);
      //   list.add(categories[i]!);
      // }
      allCategoriesList(categories);
      print("categories list  = " + categories!.length.toString());
      return categories;
    } finally {
      isLoading(false);
      print("stop1");
    }
  }

  Future<List<Product?>?> getAllProducts() async {
    try {
      isLoading(true);
      var products = await ProductsApiService().getAllProducts();
      allProductsList(products);
      print("products list  = " + products!.length.toString());

      return products;
    } finally {
      isLoading(false);
      print("stop2");
    }
  }

  putAllProductsInCategories(){
    print("start update");
    for(int i = 0 ; i < allCategoriesList.length ; i++){
      for(int p = 0 ; p < allProductsList.length ; p++) {
      for(int c = 0 ; c < allProductsList.elementAt(p)!.categories!.length ; c++) {
          print("Category ID 1: " + allProductsList.elementAt(p)!.categories!.elementAt(c).id.toString());
          print("Category ID 2: " + allCategoriesList.elementAt(i)!.id.toString());
          if (allProductsList.elementAt(p)!.categories!.elementAt(c).id == allCategoriesList.elementAt(i)!.id) {
            print("TRUE");
            allCategoriesList.elementAt(i)!.products!.add(
                allProductsList.elementAt(p)!);
          }
          print("---------");
      }
      }
    }
    print("length 1 = " + allCategoriesList.elementAt(0)!.products!.length.toString() );
    print("length 2 = " + allCategoriesList.elementAt(1)!.products!.length.toString() );
    print("end update");
    isLoading(false);
    update();

  }

}
