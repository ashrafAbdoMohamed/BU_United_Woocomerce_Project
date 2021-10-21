import 'package:bu_united_flutter_app/apiservices/customer_api_service.dart';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  // Rx<Customer> savedCustomer = Customer().obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

  }


  Future<Customer?> getAllCustomers() async {
    try {
      isLoading(true);
      var customer = await CustomerService().getAllCustomers() as Customer;
      return customer;
    } finally {
      isLoading(false);
    }
  }

  Future<Customer?> updateCustomerBilling(Customer customer) async {
    try {
      isLoading(true);
      var mCustomer = await CustomerService().updateCustomerBilling(customer);
      return mCustomer;
    } finally {
      isLoading(false);
    }
  }
  Future<Customer?> updateCustomerShipping(Customer customer) async {
    try {
      isLoading(true);
      var mCustomer = await CustomerService().updateCustomerShipping(customer);
      return mCustomer;
    } finally {
      isLoading(false);
    }
  }
  Future<Customer?> updateCustomerInfo(Customer customer) async {
    try {
      isLoading(true);
      var mCustomer = await CustomerService().updateCustomerInfo(customer);
      return mCustomer;
    } finally {
      isLoading(false);
    }
  }



}
