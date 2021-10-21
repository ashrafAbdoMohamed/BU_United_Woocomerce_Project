import 'package:bu_united_flutter_app/apiservices/auth_api_service.dart';
import 'package:bu_united_flutter_app/apiservices/customer_api_service.dart';
import 'package:bu_united_flutter_app/models/customer.dart';
import 'package:bu_united_flutter_app/utils/account.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<Customer> loggedInCustomer = Customer().obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      isLoading(true);

    } finally {
      isLoading(false);
    }
  }

  Future<Customer?> getCustomerByID(String id) async {
    try {
      isLoading(true);
      var customer = await CustomerService().getCustomer(id) /*as Customer*/;
      customer!.token = account.customerToken;
      print("CCC customer : " + customer!.email);
      loggedInCustomer(customer);
      isLoading(false);
      return customer;
    } finally {
      isLoading(false);
    }
  }

  Future<Customer?> registerCustomer({required Customer customer , required onFailed(msg) }) async {
    try {
      isLoading(true);
      var insertedCustomer = await AuthApiService().tryToCreateCustomers(customer, (msg) => onFailed(msg)) as Customer;
      loggedInCustomer(customer);
      return insertedCustomer;
    } finally {
      isLoading(false);
    }
  }


  Future<Customer?> customerLogin({required String emailOrUserName ,required String password , required onFailed(msg)}) async {

    try {
      // isLoading(true);
      Customer? customer = await AuthApiService().loginCustomer( emailOrUserName ,  password , (msg) => onFailed(msg) );
      if(customer != null ) print("customer = " + customer.email ); else print("customer is null from controller");
      loggedInCustomer(customer);
      return customer;
    } finally {
      // isLoading(false);
    }
  }

  Future<String?> resetPassword({required String email }) async {

    try {
      isLoading(true);
      String? msg = await AuthApiService().resetPassword( email /*, (msg) => onFailed(msg)*/ );
      return msg;
    } finally {
      isLoading(false);
    }
  }
  Future<String?> sendPasswordViaMail({required String email , required String pass}) async {

    try {
      isLoading(true);
      String? msg = await AuthApiService().sendPasswordViaMail( email , pass  );
      return msg;
    } finally {
      isLoading(false);
    }
  }


/*setTeacher(Teacher? teacher) {
    loggedInTeacher(teacher);
    loggedInStudent(null);
  }

  logout() {
    account.studentId = "-1";
    loggedInStudent(Student());
    update();
    print("loggedInStudent = " + loggedInStudent.toString());
    // print("loggedInStudent ID = " + loggedInStudent.value.id);
  }*/


}
