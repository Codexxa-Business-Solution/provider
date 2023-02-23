class DashboardSubscriptionModel {
  String? id;
  String? providerId;
  String? categoryId;
  String? subCategoryId;
  int? isSubscribed;
  String? createdAt;
  String? updatedAt;
  int? servicesCount;
  int? completedBookingCount;
  SubCategory? subCategory;

  DashboardSubscriptionModel(
      {this.id,
        this.providerId,
        this.categoryId,
        this.subCategoryId,
        this.isSubscribed,
        this.createdAt,
        this.updatedAt,
        this.servicesCount,
        this.completedBookingCount,
        this.subCategory,
      });

  DashboardSubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    isSubscribed = int.parse(json['is_subscribed'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    servicesCount = int.parse(json['services_count'].toString());
    completedBookingCount = int.parse(json['completed_booking_count'].toString());
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
    data['services_count'] = this.servicesCount;
    data['completed_booking_count'] = this.completedBookingCount;
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
  String? description;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  SubCategory(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    isActive = int.parse(json['is_active'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
