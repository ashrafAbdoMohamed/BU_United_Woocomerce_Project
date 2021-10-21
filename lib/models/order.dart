import 'package:bu_united_flutter_app/models/billing.dart';
import 'package:bu_united_flutter_app/models/shipping.dart';

class Order {
  var id;
  var parentId;
  var status;
  var currency;
  var version;
  var pricesIncludeTax;
  var dateCreated;
  var dateModified;
  var discountTotal;
  var discountTax;
  var shippingTotal;
  var shippingTax;
  var cartTax;
  var total;
  var totalTax;
  var customerId;
  var orderKey;
  Billing? billing;
  Shipping? shipping;
  var paymentMethod;
  var paymentMethodTitle;
  var transactionId;
  var customerIpAddress;
  var customerUserAgent;
  var createdVia;
  var customerNote;
  var dateCompleted;
  var datePaid;
  var cartHash;
  var number;
  //List<MetaData>? metaData;
  List<LineItems>? lineItems;
  /*List<Null> taxLines;
  List<Null> shippingLines;
  List<Null> feeLines;
  List<Null> couponLines;
  List<Null> refunds;*/
  var dateCreatedGmt;
  var dateModifiedGmt;
  var dateCompletedGmt;
  var datePaidGmt;
  var currencySymbol;
  // Links lLinks;

  Order(
      {this.id,
        this.parentId,
        this.status,
        this.currency,
        this.version,
        this.pricesIncludeTax,
        this.dateCreated,
        this.dateModified,
        this.discountTotal,
        this.discountTax,
        this.shippingTotal,
        this.shippingTax,
        this.cartTax,
        this.total,
        this.totalTax,
        this.customerId,
        this.orderKey,
        this.billing,
        this.shipping,
        this.paymentMethod,
        this.paymentMethodTitle,
        this.transactionId,
        this.customerIpAddress,
        this.customerUserAgent,
        this.createdVia,
        this.customerNote,
        this.dateCompleted,
        this.datePaid,
        this.cartHash,
        this.number,
        //this.metaData,
        this.lineItems,
        /*this.taxLines,
        this.shippingLines,
        this.feeLines,
        this.couponLines,
        this.refunds,*/
        this.dateCreatedGmt,
        this.dateModifiedGmt,
        this.dateCompletedGmt,
        this.datePaidGmt,
        this.currencySymbol,
        // this.lLinks
      });

  Order.fromJson(Map<String, dynamic> json , {List<LineItems>? items}) {
    id = json['id'] ?? "";
    parentId = json['parent_id'] ?? "";
    status = json['status'] ?? "";
    currency = json['currency'] ?? "";
    version = json['version'] ?? "";
    pricesIncludeTax = json['prices_include_tax'] ?? "";
    dateCreated = json['date_created'] ?? "";
    dateModified = json['date_modified'] ?? "";
    discountTotal = json['discount_total'] ?? "";
    discountTax = json['discount_tax'] ?? "";
    shippingTotal = json['shipping_total'] ?? "";
    shippingTax = json['shipping_tax'] ?? "";
    cartTax = json['cart_tax'] ?? "";
    total = json['total'] ?? "";
    totalTax = json['total_tax'] ?? "";
    customerId = json['customer_id'] ?? "";
    orderKey = json['order_key'] ?? "";
    billing =
    json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    paymentMethod = json['payment_method'] ?? "";
    paymentMethodTitle = json['payment_method_title'] ?? "";
    transactionId = json['transaction_id'] ?? "";
    customerIpAddress = json['customer_ip_address'] ?? "";
    customerUserAgent = json['customer_user_agent'] ?? "";
    createdVia = json['created_via'] ?? "";
    customerNote = json['customer_note'] ?? "";
    dateCompleted = json['date_completed'] ?? "";
    datePaid = json['date_paid'] ?? "";
    cartHash = json['cart_hash'] ?? "";
    number = json['number'] ?? "";
    if(items!=null){
      lineItems = items;
    }
    /*lineItems = json['line_items'] ?? "";
    if(lineItems!.isNotEmpty)
      if (json['line_items'] != null) {
        lineItems = <LineItems>[];
        json['line_items'].forEach((v) {
          lineItems!.add(new LineItems.fromJson(v));
        });
      }*/
    dateCreatedGmt = json['date_created_gmt'] ?? "";
    dateModifiedGmt = json['date_modified_gmt'] ?? "";
    dateCompletedGmt = json['date_completed_gmt'] ?? "";
    datePaidGmt = json['date_paid_gmt'] ?? "";
    currencySymbol = json['currency_symbol'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    //data['set_paid'] = this.pa;
    data['status'] = this.status;
    data['customer_id'] = this.parentId;

    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class LineItems {
  var id;
  var name;
  var productId;
  var variationId;
  var quantity;
  var taxClass;
  var subtotal;
  var subtotalTax;
  var total;
  var totalTax;
  var sku;
  var price;
  var parentName;

  LineItems(
      {this.id,
        this.name,
        this.productId,
        this.variationId,
        this.quantity,
        this.taxClass,
        this.subtotal,
        this.subtotalTax,
        this.total,
        this.totalTax,
        this.sku,
        this.price,
        this.parentName});

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id']  ?? "";
    name = json['name'] ?? "";
    productId = json['product_id'] ?? "";
    variationId = json['variation_id'] ?? "";
    quantity = json['quantity'] ?? "";
    taxClass = json['tax_class'] ?? "";
    subtotal = json['subtotal'] ?? "";
    subtotalTax = json['subtotal_tax'] ?? "";
    total = json['total'] ?? "";
    totalTax = json['total_tax'] ?? "";
    sku = json['sku'] ?? "";
    price = json['price'] ?? "";
    parentName = json['parent_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    data['quantity'] = this.quantity;

    return data;
  }
}


/*class MetaData {
  int id;
  String key;
  String value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}*/
