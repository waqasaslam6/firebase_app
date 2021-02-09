// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  Products({
    this.code,
    this.msg,
  });

  int code;
  List<Msg> msg;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    code: json["code"],
    msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
  };
}

class Msg {
  Msg({
    this.product,
    this.category,
    this.store,
    this.productImage,
  });

  Product product;
  Category category;
  Store store;
  List<ProductImage> productImage;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    product: Product.fromJson(json["Product"]),
    category: Category.fromJson(json["Category"]),
    store: Store.fromJson(json["Store"]),
    productImage: List<ProductImage>.from(json["ProductImage"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Product": product.toJson(),
    "Category": category.toJson(),
    "Store": store.toJson(),
    "ProductImage": List<dynamic>.from(productImage.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.storeId,
    this.name,
    this.image,
    this.description,
    this.level,
    this.featured,
    this.active,
  });

  String id;
  String storeId;
  String name;
  String image;
  String description;
  String level;
  String featured;
  String active;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
    description: json["description"] == null ? null : json["description"],
    level: json["level"] == null ? null : json["level"],
    featured: json["featured"] == null ? null : json["featured"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "store_id": storeId == null ? null : storeId,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
    "description": description == null ? null : description,
    "level": level == null ? null : level,
    "featured": featured == null ? null : featured,
    "active": active == null ? null : active,
  };
}

class Product {
  Product({
    this.id,
    this.categoryId,
    this.storeId,
    this.title,
    this.description,
    this.size,
    this.price,
    this.salePrice,
    this.updated,
    this.created,
  });

  String id;
  String categoryId;
  String storeId;
  String title;
  String description;
  String size;
  String price;
  String salePrice;
  DateTime updated;
  DateTime created;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    categoryId: json["category_id"],
    storeId: json["store_id"],
    title: json["title"],
    description: json["description"],
    size: json["size"],
    price: json["price"],
    salePrice: json["sale_price"],
    updated: DateTime.parse(json["updated"]),
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "store_id": storeId,
    "title": title,
    "description": description,
    "size": size,
    "price": price,
    "sale_price": salePrice,
    "updated": updated.toIso8601String(),
    "created": created.toIso8601String(),
  };
}

class ProductImage {
  ProductImage({
    this.id,
    this.productId,
    this.image,
    this.created,
  });

  String id;
  String productId;
  String image;
  DateTime created;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    id: json["id"],
    productId: json["product_id"],
    image: json["image"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "image": image,
    "created": created.toIso8601String(),
  };
}

class Store {
  Store({
    this.id,
    this.userId,
    this.name,
    this.about,
    this.logo,
    this.cover,
    this.shippingBaseFee,
    this.shippingFeePerDistance,
    this.distanceUnit,
    this.active,
    this.created,
    this.storeLocation,
  });

  String id;
  String userId;
  StoreName name;
  About about;
  Logo logo;
  Cover cover;
  String shippingBaseFee;
  String shippingFeePerDistance;
  String distanceUnit;
  String active;
  Created created;
  StoreLocation storeLocation;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    name: json["name"] == null ? null : storeNameValues.map[json["name"]],
    about: json["about"] == null ? null : aboutValues.map[json["about"]],
    logo: json["logo"] == null ? null : logoValues.map[json["logo"]],
    cover: json["cover"] == null ? null : coverValues.map[json["cover"]],
    shippingBaseFee: json["shipping_base_fee"] == null ? null : json["shipping_base_fee"],
    shippingFeePerDistance: json["shipping_fee_per_distance"] == null ? null : json["shipping_fee_per_distance"],
    distanceUnit: json["distance_unit"] == null ? null : json["distance_unit"],
    active: json["active"] == null ? null : json["active"],
    created: json["created"] == null ? null : createdValues.map[json["created"]],
    storeLocation: json["StoreLocation"] == null ? null : StoreLocation.fromJson(json["StoreLocation"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "name": name == null ? null : storeNameValues.reverse[name],
    "about": about == null ? null : aboutValues.reverse[about],
    "logo": logo == null ? null : logoValues.reverse[logo],
    "cover": cover == null ? null : coverValues.reverse[cover],
    "shipping_base_fee": shippingBaseFee == null ? null : shippingBaseFee,
    "shipping_fee_per_distance": shippingFeePerDistance == null ? null : shippingFeePerDistance,
    "distance_unit": distanceUnit == null ? null : distanceUnit,
    "active": active == null ? null : active,
    "created": created == null ? null : createdValues.reverse[created],
    "StoreLocation": storeLocation == null ? null : storeLocation.toJson(),
  };
}

enum About { TARGET }

final aboutValues = EnumValues({
  "target": About.TARGET
});

enum Cover { APP_WEBROOT_UPLOADS_STORE_15_F83_F2_D369643_PNG }

final coverValues = EnumValues({
  "app/webroot/uploads/store/1/5f83f2d369643.png": Cover.APP_WEBROOT_UPLOADS_STORE_15_F83_F2_D369643_PNG
});

enum Created { THE_00000000000000 }

final createdValues = EnumValues({
  "0000-00-00 00:00:00": Created.THE_00000000000000
});

enum Logo { APP_WEBROOT_UPLOADS_STORE_15_F83_F2_D368_E12_PNG }

final logoValues = EnumValues({
  "app/webroot/uploads/store/1/5f83f2d368e12.png": Logo.APP_WEBROOT_UPLOADS_STORE_15_F83_F2_D368_E12_PNG
});

enum StoreName { WALL_MART }

final storeNameValues = EnumValues({
  "Wall Mart": StoreName.WALL_MART
});

class StoreLocation {
  StoreLocation({
    this.id,
    this.storeId,
    this.lat,
    this.long,
    this.city,
    this.state,
    this.street,
    this.zipCode,
    this.countryId,
    this.created,
    this.country,
  });

  String id;
  String storeId;
  String lat;
  String long;
  City city;
  String state;
  String street;
  String zipCode;
  String countryId;
  Created created;
  Country country;

  factory StoreLocation.fromJson(Map<String, dynamic> json) => StoreLocation(
    id: json["id"],
    storeId: json["store_id"],
    lat: json["lat"],
    long: json["long"],
    city: cityValues.map[json["city"]],
    state: json["state"],
    street: json["street"],
    zipCode: json["zip_code"],
    countryId: json["country_id"],
    created: createdValues.map[json["created"]],
    country: Country.fromJson(json["Country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "lat": lat,
    "long": long,
    "city": cityValues.reverse[city],
    "state": state,
    "street": street,
    "zip_code": zipCode,
    "country_id": countryId,
    "created": createdValues.reverse[created],
    "Country": country.toJson(),
  };
}

enum City { FAISALABAD }

final cityValues = EnumValues({
  "Faisalabad": City.FAISALABAD
});

class Country {
  Country({
    this.id,
    this.iso,
    this.name,
    this.country,
    this.iso3,
    this.numcode,
    this.countryCode,
    this.currencyCode,
    this.currencySymbol,
    this.active,
  });

  String id;
  Iso iso;
  CountryName name;
  CountryEnum country;
  Iso3 iso3;
  String numcode;
  String countryCode;
  Currency currencyCode;
  Currency currencySymbol;
  String active;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    iso: isoValues.map[json["iso"]],
    name: countryNameValues.map[json["name"]],
    country: countryEnumValues.map[json["country"]],
    iso3: iso3Values.map[json["iso3"]],
    numcode: json["numcode"],
    countryCode: json["country_code"],
    currencyCode: currencyValues.map[json["currency_code"]],
    currencySymbol: currencyValues.map[json["currency_symbol"]],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "iso": isoValues.reverse[iso],
    "name": countryNameValues.reverse[name],
    "country": countryEnumValues.reverse[country],
    "iso3": iso3Values.reverse[iso3],
    "numcode": numcode,
    "country_code": countryCode,
    "currency_code": currencyValues.reverse[currencyCode],
    "currency_symbol": currencyValues.reverse[currencySymbol],
    "active": active,
  };
}

enum CountryEnum { PAKISTAN }

final countryEnumValues = EnumValues({
  "Pakistan": CountryEnum.PAKISTAN
});

enum Currency { PKR }

final currencyValues = EnumValues({
  "PKR": Currency.PKR
});

enum Iso { PK }

final isoValues = EnumValues({
  "PK": Iso.PK
});

enum Iso3 { PAK }

final iso3Values = EnumValues({
  "PAK": Iso3.PAK
});

enum CountryName { PAKISTAN }

final countryNameValues = EnumValues({
  "PAKISTAN": CountryName.PAKISTAN
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
