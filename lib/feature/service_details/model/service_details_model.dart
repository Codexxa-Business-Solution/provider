import 'dart:convert';

ServiceDetailsModel serviceDetailsModelFromJson(String str) => ServiceDetailsModel.fromJson(json.decode(str));

String serviceDetailsModelToJson(ServiceDetailsModel data) => json.encode(data.toJson());

class ServiceDetailsModel {
  ServiceDetailsModel({
    this.responseCode,
    this.message,
    this.content,

  });

  String? responseCode;
  String? message;
  ServiceDetailsContent? content;


  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) => ServiceDetailsModel(
    responseCode: json["response_code"],
    message: json["message"],
    content: ServiceDetailsContent.fromJson(json["content"]),

  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "message": message,
    "content": content!.toJson(),
  };
}

class ServiceDetailsContent {
  ServiceDetailsContent({
    this.id,
    this.name,
    this.shortDescription,
    this.description,
    this.coverImage,
    this.thumbnail,
    this.categoryId,
    this.subCategoryId,
    this.tax,
    this.orderCount,
    this.isActive,
    this.ratingCount,
    this.avgRating,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.variations,
    this.serviceDiscount
  });

  String? id;
  String? name;
  String? shortDescription;
  String? description;
  String? coverImage;
  String? thumbnail;
  String? categoryId;
  String? subCategoryId;
  var tax;
  int? orderCount;
  int? isActive;
  int? ratingCount;
  var avgRating;
  DateTime? createdAt;
  DateTime? updatedAt;
  ServiceDetailsCategory? category;
  List<ServiceDetailsVariation>? variations;
  List<ServiceDiscount>? serviceDiscount;

  factory ServiceDetailsContent.fromJson(Map<String, dynamic> json) => ServiceDetailsContent(
    id: json["id"],
    name: json["name"],
    shortDescription:  json["short_description"],
    description: json["description"],
    coverImage: json["cover_image"],
    thumbnail: json["thumbnail"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    tax: json["tax"],
    orderCount: json["order_count"],
    isActive: json["is_active"],
    ratingCount: json["rating_count"],
    avgRating: json["avg_rating"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    category: ServiceDetailsCategory.fromJson(json["category"]),
    variations: List<ServiceDetailsVariation>.from(json["variations"].map((x) => ServiceDetailsVariation.fromJson(x))),
    serviceDiscount: List<ServiceDiscount>.from(json["service_discount"].map((x) => ServiceDiscount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_description": shortDescription,
    "description": description,
    "cover_image": coverImage,
    "thumbnail": thumbnail,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "tax": tax,
    "order_count": orderCount,
    "is_active": isActive,
    "rating_count": ratingCount,
    "avg_rating": avgRating,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "category": category!.toJson(),
    "variations": List<dynamic>.from(variations!.map((x) => x.toJson())),
    "service_discount": List<dynamic>.from(serviceDiscount!.map((x) => x.toJson())),
  };
}

class ServiceDetailsCategory {
  ServiceDetailsCategory({
    this.id,
    this.parentId,
    this.name,
    this.image,
    this.position,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.children,

  });

  String? id;
  String? parentId;
  String? name;
  String? image;
  int? position;
  String? description;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ServiceDetailsCategory>? children;


  factory ServiceDetailsCategory.fromJson(Map<String, dynamic> json) => ServiceDetailsCategory(
    id: json["id"],
    parentId: json["parent_id"],
    name: json["name"],
    image: json["image"],
    position: json["position"],
    description: json["description"] == null ? null : json["description"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    children: json["children"] == null ? null : List<ServiceDetailsCategory>.from(json["children"].map((x) => ServiceDetailsCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "name": name,
    "image": image,
    "position": position,
    "description": description == null ? null : description,
    "is_active": isActive,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "children": children == null ? null : List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}

class ServiceDetailsVariation {
  ServiceDetailsVariation({
    this.id,
    this.variant,
    this.variantKey,
    this.serviceId,
    this.zoneId,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? variant;
  String? variantKey;
  String? serviceId;
  String? zoneId;
  var price;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ServiceDetailsVariation.fromJson(Map<String, dynamic> json) => ServiceDetailsVariation(
    id: json["id"],
    variant: json["variant"],
    variantKey: json["variant_key"],
    serviceId: json["service_id"],
    zoneId: json["zone_id"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "variant": variant,
    "variant_key": variantKey,
    "service_id": serviceId,
    "zone_id": zoneId,
    "price": price,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class ServiceDiscount {
  int? id;
  String? discountId;
  String? discountType;
  String? typeWiseId;
  String? createdAt;
  String? updatedAt;
  Discount? discount;

  ServiceDiscount(
      {this.id,
        this.discountId,
        this.discountType,
        this.typeWiseId,
        this.createdAt,
        this.updatedAt,
        this.discount});

  ServiceDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountType = json['discount_type'];
    typeWiseId = json['type_wise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount_id'] = this.discountId;
    data['discount_type'] = this.discountType;
    data['type_wise_id'] = this.typeWiseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    return data;
  }
}
class CampaignDiscount {
  int? id;
  String? discountId;
  String? discountType;
  String? typeWiseId;
  String? createdAt;
  String? updatedAt;
  Discount? discount;

  CampaignDiscount(
      {this.id,
        this.discountId,
        this.discountType,
        this.typeWiseId,
        this.createdAt,
        this.updatedAt,
        this.discount});

  CampaignDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountType = json['discount_type'];
    typeWiseId = json['type_wise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount_id'] = this.discountId;
    data['discount_type'] = this.discountType;
    data['type_wise_id'] = this.typeWiseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    return data;
  }
}
class Discount {
  String? id;
  String? discountTitle;
  String? discountType;
  double? discountAmount;
  String? discountAmountType;
  double? minPurchase;
  double? maxDiscountAmount;
  int? limitPerUser;
  String? promotionType;
  int? isActive;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  Discount(
      {this.id,
        this.discountTitle,
        this.discountType,
        this.discountAmount,
        this.discountAmountType,
        this.limitPerUser,
        this.promotionType,
        this.isActive,
        this.startDate,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  Discount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountTitle = json['discount_title'];
    discountType = json['discount_type'];
    discountAmount = double.tryParse(json['discount_amount'].toString());
    discountAmountType = json['discount_amount_type'];
    minPurchase = double.tryParse(json['min_purchase'].toString());
    maxDiscountAmount = double.tryParse(json['max_discount_amount'].toString());
    limitPerUser = json['limit_per_user'];
    promotionType = json['promotion_type'];
    isActive = json['is_active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount_title'] = this.discountTitle;
    data['discount_type'] = this.discountType;
    data['discount_amount'] = this.discountAmount;
    data['discount_amount_type'] = this.discountAmountType;
    data['min_purchase'] = this.minPurchase;
    data['max_discount_amount'] = this.maxDiscountAmount;
    data['limit_per_user'] = this.limitPerUser;
    data['promotion_type'] = this.promotionType;
    data['is_active'] = this.isActive;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



