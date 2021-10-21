import 'package:flutter/cupertino.dart';

class Product {
  var id;
  var name;
  var slug;
  var permalink;
  var dateCreated;
  var dateCreatedGmt;
  var dateModified;
  var dateModifiedGmt;
  var type;
  var status;
  var featured;
  var catalogVisibility;
  var description;
  var shortDescription;
  var sku;
  var price;
  var regularPrice;
  var salePrice;
  /*Null dateOnSaleFrom;
  Null dateOnSaleFromGmt;
  Null dateOnSaleTo;
  Null dateOnSaleToGmt;*/
  var onSale;
  var purchasable;
  var totalSales;
  var virtual;
  /*var downloadable;
  List<Null> downloads;
  var downloadLimit;
  var downloadExpiry;*/
  var externalUrl;
  var buttonText;
  var taxStatus;
  var taxClass;
  var manageStock;
  // Null stockQuantity;
  var inStock;
  var backorders;
  var backordersAllowed;
  var backordered;
  var soldIndividually;
  var weight;
  var dimensions;
  var shipping;
  var shippingTaxable;
  var shippingClass;
  var shippingClassId;
  var reviewsAllowed;
  var averageRating;
  var ratingCount;
  /*List<Null> upsellIds;
  List<Null> crossSellIds;*/
  var parentId;
  var purchaseNote;
  List<Categories>? categories;
  List<Tags>? tags;
  List<Images>? images;
  List<Attribute>? attributes;
  List<int>? relatedIds;
  /*List<Null> defaultAttributes;
  List<Null> variations;
  List<Null> groupedProducts;*/
  var menuOrder;
  var priceHtml;
  /*List<var> relatedIds;
  List<MetaData> metaData;
  Links lLinks;*/

  Product(
      { this.id,
         this.name,
         this.slug,
         this.permalink,
         this.dateCreated,
         this.dateCreatedGmt,
         this.dateModified,
         this.dateModifiedGmt,
         this.type,
         this.status,
         this.featured,
         this.catalogVisibility,
         this.description,
         this.shortDescription,
         this.sku,
         this.price,
         this.regularPrice,
         this.salePrice,

         this.relatedIds,
         this.onSale,
         this.purchasable,
         this.totalSales,
         this.virtual,

         this.externalUrl,
         this.buttonText,
         this.taxStatus,
         this.taxClass,
         this.manageStock,
         this.inStock,
         this.backorders,
         this.backordersAllowed,
         this.backordered,
         this.soldIndividually,
         this.weight,
         this.dimensions,
         this.shipping,
         this.shippingTaxable,
         this.shippingClass,
         this.shippingClassId,
         this.reviewsAllowed,
         this.averageRating,
         this.ratingCount,
         this.parentId,
         this.purchaseNote,
         this.categories,
         this.tags,
         this.images,
         this.menuOrder,
         this.attributes,
         this.priceHtml});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];

    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    totalSales = json['total_sales'];
    virtual = json['virtual'];
    /*downloadable = json['downloadable'];
    if (json['downloads'] != null) {
      downloads = new List<Null>();
      json['downloads'].forEach((v) {
        downloads.add(new Null.fromJson(v));
      });
    }
    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];*/
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    inStock = json['in_stock'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    soldIndividually = json['sold_individually'];
    weight = json['weight'];
    dimensions = (json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null)!;
    shipping = json['shipping_'];
    shippingTaxable = json['shipping_taxable'];
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    /*if (json['upsell_ids'] != null) {
      upsellIds = new List<Null>();
      json['upsell_ids'].forEach((v) {
        upsellIds.add(new Null.fromJson(v));
      });
    }*/
    /*if (json['cross_sell_ids'] != null) {
      crossSellIds = new List<Null>();
      json['cross_sell_ids'].forEach((v) {
        crossSellIds.add(new Null.fromJson(v));
      });
    }*/
    relatedIds = json['related_ids'].cast<int>();
    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];
    if (json['attributes'] != null) {
      attributes = <Attribute>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attribute.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    menuOrder = json['menu_order'];
    priceHtml = json['price_html'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] =  this.id;
    data['name'] =  this.name;
    data['slug'] =  this.slug;
    data['permalink'] =  this.permalink;
    data['date_created'] =  this.dateCreated;
    data['date_created_gmt'] =  this.dateCreatedGmt;
    data['date_modified'] =  this.dateModified;
    data['date_modified_gmt'] =  this.dateModifiedGmt;
    data['type'] =  this.type;
    data['status'] =  this.status;
    data['featured'] =  this.featured;
    data['catalog_visibility'] =  this.catalogVisibility;
    data['description'] =  this.description;
    data['short_description'] =  this.shortDescription;
    data['sku'] =  this.sku;
    data['price'] =  this.price;
    data['regular_price'] =  this.regularPrice;
    data['sale_price'] =  this.salePrice;
    data['on_sale'] =  this.onSale;
    data['purchasable'] =  this.purchasable;
    data['total_sales'] =  this.totalSales;
    data['virtual'] =  this.virtual;
    data['external_url'] =  this.externalUrl;
    data['button_text'] =  this.buttonText;
    data['tax_status'] =  this.taxStatus;
    data['tax_class'] =  this.taxClass;
    data['manage_stock'] =  this.manageStock;
    data['in_stock'] =  this.inStock;
    data['backorders'] =  this.backorders;
    data['backorders_allowed'] =  this.backordersAllowed;
    data['backordered'] =  this.backordered;
    data['sold_individually'] =  this.soldIndividually;
    data['weight'] =  this.weight;
    if ( this.dimensions != null) {
      data['dimensions'] =  this.dimensions.toJson();
    }
    data['shipping_'] =  this.shipping;
    data['shipping_taxable'] =  this.shippingTaxable;
    data['shipping_class'] =  this.shippingClass;
    data['shipping_class_id'] =  this.shippingClassId;
    data['reviews_allowed'] =  this.reviewsAllowed;
    data['average_rating'] =  this.averageRating;
    data['rating_count'] =  this.ratingCount;
    data['parent_id'] =  this.parentId;
    data['purchase_note'] =  this.purchaseNote;
    if ( this.categories != null) {
      data['categories'] =  this.categories!.map((v) => v.toJson()).toList();
    }
    if ( this.tags != null) {
      data['tags'] =  this.tags!.map((v) => v.toJson()).toList();
    }
    if ( this.images != null) {
      data['images'] =  this.images!.map((v) => v.toJson()).toList();
    }
    data['menu_order'] =  this.menuOrder;
    data['price_html'] =  this.priceHtml;
    return data;
  }
}

class Attribute {
  var id;
  var name;
  var options;

  Attribute({ this.id,  this.name,  this.options});

  Attribute.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    options = json['options'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] =  this.id ?? "";
    data['name'] =  this.name ?? "";
    data['options'] =  this.options?? "";
    return data;
  }
}

class Dimensions {
  var length;
  var width;
  var height;

  Dimensions({ this.length,  this.width,  this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] =  this.length;
    data['width'] =  this.width;
    data['height'] =  this.height;
    return data;
  }
}

class Categories {
  var id;
  var name;
  var slug;

  Categories({ this.id,  this.name,  this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] =  this.id;
    data['name'] =  this.name;
    data['slug'] =  this.slug;
    return data;
  }
}
class Tags {
  var id;
  var name;
  var slug;

  Tags({ this.id,  this.name,  this.slug});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] =  this.id;
    data['name'] =  this.name;
    data['slug'] =  this.slug;
    return data;
  }
}

class Images {
  var id;
  var dateCreated;
  var dateCreatedGmt;
  var dateModified;
  var dateModifiedGmt;
  var src;
  var name;
  var alt;
  var position;

  Images(
      { this.id,
         this.dateCreated,
         this.dateCreatedGmt,
         this.dateModified,
         this.dateModifiedGmt,
         this.src,
         this.name,
         this.alt,
         this.position});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] =  this.id;
    data['date_created'] =  this.dateCreated;
    data['date_created_gmt'] =  this.dateCreatedGmt;
    data['date_modified'] =  this.dateModified;
    data['date_modified_gmt'] =  this.dateModifiedGmt;
    data['src'] =  this.src;
    data['name'] =  this.name;
    data['alt'] =  this.alt;
    data['position'] =  this.position;
    return data;
  }
}
