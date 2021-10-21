import 'shipping.dart';
import 'billing.dart';

class Customer {
  var token;
  var id;
  var email;
  var niceName;
  var username;
  var password;
  var firstName;
  var lastName;
  var displayName;
  Billing? billing;
  Shipping? shipping;
  var avatarUrl;

  Customer(
      {this.token,
        this.id,
        this.email,
        this.niceName,
        this.firstName,
        this.lastName,
        this.username,
        this.password,
        this.avatarUrl,
        this.billing,
        this.shipping,
        this.displayName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    token = json['token'] ?? "";
    email = json['email'] ?? "";
    niceName = json['nicename'] ?? "";
    username = json['username'] ?? "";
    firstName = json['firstName'] ?? json['first_name'];
    lastName = json['lastName'] ?? json['last_name'] ;
    displayName = json['displayName'] ?? "";
    avatarUrl = json['avatar_url'] ?? "";
    print("json['billing'] = " + json['billing'].toString());
    billing =
    json['billing'] != null ? new Billing.fromJson(json['billing']) : Billing();
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : Shipping();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token ?? "";
    data['id'] = this.id ?? "";
    data['email'] = this.email ?? "";
    data['nicename'] = this.niceName ?? "";
    data['firstName'] = this.firstName ?? "";
    data['lastName'] = this.lastName ?? "";
    data['displayName'] = this.displayName ?? "";
    data['username'] = this.username ?? "";
    data['password'] = this.password ?? "";
    data['avatar_url'] = this.avatarUrl ?? "";
    return data;
  }
}