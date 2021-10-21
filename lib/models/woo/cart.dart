

class MyWooCart {
  var currency;
  var itemCount;
  List<WooCartItems>? items;
  Totals? totals;
  var needsShipping;
  var totalPrice;
  var totalWeight;

  MyWooCart(
      {this.currency,
        this.itemCount,
        this.items,
        this.needsShipping,
        this.totalPrice,
        this.totalWeight});

  MyWooCart.fromJson(Map<String, dynamic> json) {
    currency =/* json['currency'] ??*/ "";
    itemCount = json['item_count'] ?? "";
    print("itemCount = " + itemCount.toString());
    if (json['items'] != null) {
      items = <WooCartItems>[];
      print("json['items']" + json['items'].toString());
      json['items'].forEach((v) {
        items!.add(new WooCartItems.fromJson(v));
      });
    }else{
      print("json['items'] items = null!!" );
    }
    totals = new Totals.fromJson(json['totals']) ;

    needsShipping = json['needs_shipping'] ?? "";
    totalPrice = json['total_price'].toString() ?? "";

    totalWeight = json['total_weight'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['item_count'] = this.itemCount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['needs_shipping'] = this.needsShipping;
    data['total_price'] = this.totalPrice;
    data['total_weight'] = this.totalWeight;
    return data;
  }
  @override toString() => this.toJson().toString();
}

class WooCartItems {
  var key;
  var id;
  var quantity;
  var name;
  var description;
  var short_description;
  Prices? prices;
  List<WooCartImages>? images;

/*  var sku;
  var permalink;
  var linePrice;
  List<String>? variation;*/

  WooCartItems(
      {this.key,
        this.id,
        this.quantity,
        this.name,
        this.description,
        this.short_description,
        this.images,
        this.prices,
        /*this.sku,
        this.permalink,
        this.linePrice,
        this.variation*/
      });

  WooCartItems.fromJson(Map<String, dynamic> json) {
    key = json['key'] ?? "";
    print(" key = " + key.toString());
    id = json['id' ] ?? "";
    quantity = json['quantity'] ?? "";
    print(" quantity = " + quantity.toString());
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    short_description = json['short_description'] ?? "";
    print(" name = " + name.toString());

    if (json['images'] != null) {
      images = <WooCartImages>[];
      json['images'].forEach((v) {
        images!.add(new WooCartImages.fromJson(v));
      });
    }
    // price = json['price'] ?? "";
    prices = new Prices.fromJson(json['prices']) ?? null;

    print(" price = " + prices.toString());
    // sku = json['sku'] ?? "";
    // permalink = json['permalink'] ?? "";
    // linePrice = json['line_price'] ?? "";
    // variation = json['variation'].cast<String>() ?? "";
    print("================================");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.prices;
    // data['sku'] = this.sku;
    // data['permalink'] = this.permalink;
    // data['line_price'] = this.linePrice;
    // data['variation'] = this.variation;
    return data;
  }
}

class WooCartImages {
  var id;
  var src;
  var thumbnail;
  var srcset;
  var sizes;
  var name;
  var alt;

  WooCartImages(
      {this.id,
        this.src,
        this.thumbnail,
        this.srcset,
        this.sizes,
        this.name,
        this.alt});

  WooCartImages.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString() ?? "";
    src = json['src'] ?? "";
    print(" image src = " + src.toString());
    thumbnail = json['thumbnail'] ?? "";
    srcset = json['srcset'].toString() ?? "";
    sizes = json['sizes'] ?? "";
    name = json['name'] ?? "";
    alt = json['alt'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['thumbnail'] = this.thumbnail;
    data['srcset'] = this.srcset;
    data['sizes'] = this.sizes;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}


class Totals {
  var totalItems;
  var totalItemsTax;
  var totalFees;
  var totalFeesTax;
  var totalDiscount;
  var totalDiscountTax;
  var totalShipping;
  var totalShippingTax;
  var totalPrice;
  var totalTax;
  // List<Null> taxLines;
  var currencyCode;
  var currencySymbol;
  var currencyMinorUnit;
  var currencyDecimalSeparator;
  var currencyThousandSeparator;
  var currencyPrefix;
  var currencySuffix;

  Totals({this.totalItems, this.totalItemsTax, this.totalFees, this.totalFeesTax, this.totalDiscount,
    this.totalDiscountTax, this.totalShipping, this.totalShippingTax, this.totalPrice,
    this.totalTax, /*this.taxLines,*/ this.currencyCode, this.currencySymbol, this.currencyMinorUnit,
    this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix, this.currencySuffix});

  Totals.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'] ?? "";
    totalItemsTax = json['total_items_tax'] ?? "";
    totalFees = json['total_fees'] ?? "";
    totalFeesTax = json['total_fees_tax'] ?? "";
    totalDiscount = json['total_discount'] ?? "";
    totalDiscountTax = json['total_discount_tax'] ?? "";
    totalShipping = json['total_shipping'] ?? "";
    totalShippingTax = json['total_shipping_tax'] ?? "";
    totalPrice = json['total_price'] ?? "";
    // print("BEFORE totalPrice = " + totalPrice.toString());

    if(totalPrice.toString() != "" && totalPrice.toString().length > 4){
      totalPrice = totalPrice.toString().substring(0 , totalPrice.toString().length-2);
    }
    // print("AFTER totalPrice = " + totalPrice.toString());
    totalTax = json['total_tax'] ?? "";
    // if (json['tax_lines'] != null) {
    //   taxLines = new List<Null>();
    //   json['tax_lines'].forEach((v) { taxLines.add(new Null.fromJson(v)); });
    // }
    currencyCode = json['currency_code'] ?? "";
    currencySymbol = json['currency_symbol'] ?? "";
    currencyMinorUnit = json['currency_minor_unit'] ?? "";
    currencyDecimalSeparator = json['currency_decimal_separator'] ?? "";
    currencyThousandSeparator = json['currency_thousand_separator'] ?? "";
    currencyPrefix = json['currency_prefix'] ?? "";
    currencySuffix = json['currency_suffix'] ?? "";
  }

}

class Prices {
  var price;
  var regularPrice;
  var salePrice;
  var priceRange;
  var currencyCode;
  var currencySymbol;
  var currencyMinorUnit;
  var currencyDecimalSeparator;
  var currencyThousandSeparator;
  var currencyPrefix;
  var currencySuffix;
  // RawPrices rawPrices;

  Prices({this.price, this.regularPrice, this.salePrice, this.priceRange, this.currencyCode, this.currencySymbol, this.currencyMinorUnit, this.currencyDecimalSeparator, this.currencyThousandSeparator, this.currencyPrefix, this.currencySuffix, /*this.rawPrices*/});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'] ?? "";
    if(price != null && price.toString().isNotEmpty){
      price = price.toString().substring(0 , price.toString().length-2);
    }
    regularPrice = json['regular_price'] ?? "";
    salePrice = json['sale_price'] ?? "";
    priceRange = json['price_range'] ?? "";
    currencyCode = json['currency_code'] ?? "";
    currencySymbol = json['currency_symbol'] ?? "";
    currencyMinorUnit = json['currency_minor_unit'] ?? "";
    currencyDecimalSeparator = json['currency_decimal_separator'] ?? "";
    currencyThousandSeparator = json['currency_thousand_separator'] ?? "";
    currencyPrefix = json['currency_prefix'] ?? "";
    currencySuffix = json['currency_suffix'] ?? "";
    // rawPrices = json['raw_prices'] != null ? new RawPrices.fromJson(json['raw_prices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['price_range'] = this.priceRange;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    /*if (this.rawPrices != null) {
      data['raw_prices'] = this.rawPrices.toJson();
    }*/
    return data;
  }
}