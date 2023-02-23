
import 'package:demandium_provider/feature/service_details/model/service_details_model.dart';

class MySubscriptionModel {
  String? responseCode;
  String? message;
  SubscriptionModelContent? content;

  MySubscriptionModel(
      {this.responseCode, this.message, this.content});

  MySubscriptionModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new SubscriptionModelContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class SubscriptionModelContent {
  int? currentPage;
  List<SubscriptionModelData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  String? path;
  String? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  SubscriptionModelContent(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  SubscriptionModelContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SubscriptionModelData>[];
      json['data'].forEach((v) {
        data!.add(new SubscriptionModelData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class SubscriptionModelData {
  String? id;
  String? providerId;
  String? categoryId;
  String? subCategoryId;
  int? isSubscribed;
  String? createdAt;
  String? updatedAt;
  SubCategory? subCategory;

  SubscriptionModelData(
      {this.id,
        this.providerId,
        this.categoryId,
        this.subCategoryId,
        this.isSubscribed,
        this.createdAt,
        this.updatedAt,
        this.subCategory});

  SubscriptionModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    isSubscribed = int.parse(json['is_subscribed'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subCategory = json['sub_category'] != null
        ? new SubCategory.fromJson(json['sub_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['is_subscribed'] = this.isSubscribed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.toJson();
    }
    return data;
  }
}

class SubCategory {
  String? id;
  String? parentId;
  String? name;
  String? image;
  int? position;
  String? description;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? servicesCount;
  List<Service>? services;

  SubCategory(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.position,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.servicesCount,
        this.services});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    servicesCount = int.parse(json['services_count'].toString());
    if (json['services'] != null) {
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['position'] = this.position;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['services_count'] = this.servicesCount;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  Service({
    this.id,
    this.name,
    this.thumbnail,
    this.subCategoryId,
    this.coverImage,
    this.isActive,
    this.serviceDiscount,
    this.campaignDiscount,
    this.categoryDiscount
  });

  String? id;
  String? name;
  String? thumbnail;
  String? subCategoryId;
  String? coverImage;
  int? isActive;
  List<ServiceDiscount>? serviceDiscount;
  List<ServiceDiscount>? campaignDiscount;
  List<ServiceDiscount>? categoryDiscount;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    name: json["name"],
    thumbnail: json["thumbnail"],
    subCategoryId: json["sub_category_id"],
    coverImage: json['cover_image'],
    isActive: json['is_active'],
    serviceDiscount: List<ServiceDiscount>.from(json["service_discount"].map((x) => ServiceDiscount.fromJson(x))),
    campaignDiscount: List<ServiceDiscount>.from(json["campaign_discount"].map((x) => ServiceDiscount.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail": thumbnail,
    "sub_category_id": subCategoryId,
    'cover_image': coverImage,
    'is_active': isActive,
    "service_discount": List<dynamic>.from(serviceDiscount!.map((x) => x.toJson())),
    "campaign_discount": List<dynamic>.from(serviceDiscount!.map((x) => x.toJson())),
  };
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}