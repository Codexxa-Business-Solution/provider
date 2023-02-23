import 'package:demandium_provider/feature/booking_requests/model/request_model.dart';

class ReviewData {
  String? id;
  String? bookingId;
  String? serviceId;
  String? providerId;
  double? reviewRating;
  String? reviewComment;
  String? bookingDate;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Customer? customer;
  Booking? booking;
  Provider? provider;

  ReviewData(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.providerId,
        this.reviewRating,
        this.reviewComment,
        this.bookingDate,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.customer,
        this.booking,
        this.provider
      });

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    providerId = json['provider_id'];
    reviewRating = double.parse(json['review_rating'].toString());
    reviewComment = json['review_comment'];
    bookingDate = json['booking_date'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    booking = json['booking'] != null
        ? new Booking.fromJson(json['booking'])
        : null;
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['provider_id'] = this.providerId;
    data['review_rating'] = this.reviewRating;
    data['review_comment'] = this.reviewComment;
    data['booking_date'] = this.bookingDate;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    return data;
  }
}

class Rating {
  var ratingCount;
  var averageRating;
  List<RatingGroupCount>? ratingGroupCount;

  Rating({this.ratingCount, this.averageRating, this.ratingGroupCount});

  Rating.fromJson(Map<String, dynamic> json) {
    ratingCount = json['rating_count'];
    averageRating = json['average_rating'];
    if (json['rating_group_count'] != null) {
      ratingGroupCount = <RatingGroupCount>[];
      json['rating_group_count'].forEach((v) {
        ratingGroupCount!.add(new RatingGroupCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating_count'] = this.ratingCount;
    data['average_rating'] = this.averageRating;
    if (this.ratingGroupCount != null) {
      data['rating_group_count'] =
          this.ratingGroupCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatingGroupCount {
  double? reviewRating;
  double? total;

  RatingGroupCount({this.reviewRating, this.total});

  RatingGroupCount.fromJson(Map<String, dynamic> json) {
    reviewRating = double.parse(json['review_rating'].toString());
    total = double.parse(json['total'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_rating'] = this.reviewRating;
    data['total'] = this.total;
    return data;
  }
}

class Booking {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? servicemanId;
  int? isChecked;
  List<Detail>? detail;

  Booking(
      {this.id,
        this.readableId,
        this.customerId,
        this.providerId,
        this.zoneId,
        this.bookingStatus,
        this.isPaid,
        this.paymentMethod,
        this.transactionId,
        this.serviceSchedule,
        this.serviceAddressId,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.subCategoryId,
        this.servicemanId,
        this.isChecked,
        this.detail});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    servicemanId = json['serviceman_id'];
    isChecked = json['is_checked'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readable_id'] = this.readableId;
    data['customer_id'] = this.customerId;
    data['provider_id'] = this.providerId;
    data['zone_id'] = this.zoneId;
    data['booking_status'] = this.bookingStatus;
    data['is_paid'] = this.isPaid;
    data['payment_method'] = this.paymentMethod;
    data['transaction_id'] = this.transactionId;
    data['service_schedule'] = this.serviceSchedule;
    data['service_address_id'] = this.serviceAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['serviceman_id'] = this.servicemanId;
    data['is_checked'] = this.isChecked;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int? id;
  String? bookingId;
  String? serviceId;
  String? serviceName;
  String? variantKey;
  double? serviceCost;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Detail(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.serviceName,
        this.variantKey,
        this.serviceCost,
        this.quantity,
        this.createdAt,
        this.updatedAt,
      });

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    variantKey = json['variant_key'];
    serviceCost = double.tryParse(json['service_cost'].toString());
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['variant_key'] = this.variantKey;
    data['service_cost'] = this.serviceCost;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Provider {
  String? id;
  String? userId;
  String? companyName;
  String? companyPhone;
  String? companyAddress;
  String? companyEmail;
  String? logo;
  String? contactPersonName;
  String? contactPersonPhone;
  String? contactPersonEmail;
  int? orderCount;
  int? serviceManCount;
  int? serviceCapacityPerDay;
  int? ratingCount;
  double? avgRating;
  int? commissionStatus;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? isApproved;
  String? zoneId;

  Provider(
      {this.id,
        this.userId,
        this.companyName,
        this.companyPhone,
        this.companyAddress,
        this.companyEmail,
        this.logo,
        this.contactPersonName,
        this.contactPersonPhone,
        this.contactPersonEmail,
        this.orderCount,
        this.serviceManCount,
        this.serviceCapacityPerDay,
        this.ratingCount,
        this.avgRating,
        this.commissionStatus,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.isApproved,
        this.zoneId});

  Provider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyName = json['company_name'];
    companyPhone = json['company_phone'];
    companyAddress = json['company_address'];
    companyEmail = json['company_email'];
    logo = json['logo'];
    contactPersonName = json['contact_person_name'];
    contactPersonPhone = json['contact_person_phone'];
    contactPersonEmail = json['contact_person_email'];
    orderCount = json['order_count'];
    serviceManCount = json['service_man_count'];
    serviceCapacityPerDay = json['service_capacity_per_day'];
    ratingCount = json['rating_count'];
    avgRating = double.tryParse(json['avg_rating'].toString());
    commissionStatus = json['commission_status'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isApproved = json['is_approved'];
    zoneId = json['zone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['company_name'] = this.companyName;
    data['company_phone'] = this.companyPhone;
    data['company_address'] = this.companyAddress;
    data['company_email'] = this.companyEmail;
    data['logo'] = this.logo;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_phone'] = this.contactPersonPhone;
    data['contact_person_email'] = this.contactPersonEmail;
    data['order_count'] = this.orderCount;
    data['service_man_count'] = this.serviceManCount;
    data['service_capacity_per_day'] = this.serviceCapacityPerDay;
    data['rating_count'] = this.ratingCount;
    data['avg_rating'] = this.avgRating;
    data['commission_status'] = this.commissionStatus;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_approved'] = this.isApproved;
    data['zone_id'] = this.zoneId;
    return data;
  }
}

class BookingDetails {
  int? id;
  String? bookingId;
  String? serviceId;
  String? serviceName;
  String? variantKey;
  double? serviceCost;
  int? quantity;
  double? discountAmount;
  double? taxAmount;
  double? totalCost;
  String? createdAt;
  String? updatedAt;
  double? campaignDiscountAmount;
  double? overallCouponDiscountAmount;

  BookingDetails(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.serviceName,
        this.variantKey,
        this.serviceCost,
        this.quantity,
        this.discountAmount,
        this.taxAmount,
        this.totalCost,
        this.createdAt,
        this.updatedAt,
        this.campaignDiscountAmount,
        this.overallCouponDiscountAmount});

  BookingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    variantKey = json['variant_key'];
    serviceCost = double.tryParse(json['service_cost'].toString());
    quantity = json['quantity'];
    discountAmount = double.tryParse(json['discount_amount'].toString());
    taxAmount = double.tryParse(json['tax_amount'].toString());
    totalCost = double.tryParse(json['total_cost'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    campaignDiscountAmount = double.tryParse(json['campaign_discount_amount'].toString());
    overallCouponDiscountAmount = double.tryParse(json['overall_coupon_discount_amount'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['variant_key'] = this.variantKey;
    data['service_cost'] = this.serviceCost;
    data['quantity'] = this.quantity;
    data['discount_amount'] = this.discountAmount;
    data['tax_amount'] = this.taxAmount;
    data['total_cost'] = this.totalCost;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['campaign_discount_amount'] = this.campaignDiscountAmount;
    data['overall_coupon_discount_amount'] = this.overallCouponDiscountAmount;
    return data;
  }
}

