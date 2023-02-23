class DashboardRecentActivityModel {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  String? totalBookingAmount;
  String? totalTaxAmount;
  String? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? servicemanId;
  String? totalCampaignDiscountAmount;
  String? totalCouponDiscountAmount;
  String? couponCode;
  List<Detail>? detail;

  DashboardRecentActivityModel(
      {this.id,
        this.readableId,
        this.customerId,
        this.providerId,
        this.zoneId,
        this.bookingStatus,
        this.isPaid,
        this.paymentMethod,
        this.transactionId,
        this.totalBookingAmount,
        this.totalTaxAmount,
        this.totalDiscountAmount,
        this.serviceSchedule,
        this.serviceAddressId,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.subCategoryId,
        this.servicemanId,
        this.totalCampaignDiscountAmount,
        this.totalCouponDiscountAmount,
        this.couponCode,
        this.detail});

  DashboardRecentActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    totalBookingAmount = json['total_booking_amount'].toString();
    totalTaxAmount = json['total_tax_amount'].toString();
    totalDiscountAmount = json['total_discount_amount'].toString();
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    servicemanId = json['serviceman_id'];
    totalCampaignDiscountAmount = json['total_campaign_discount_amount'].toString();
    totalCouponDiscountAmount = json['total_coupon_discount_amount'].toString();
    couponCode = json['coupon_code'];
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
    data['total_booking_amount'] = this.totalBookingAmount;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['total_discount_amount'] = this.totalDiscountAmount;
    data['service_schedule'] = this.serviceSchedule;
    data['service_address_id'] = this.serviceAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['serviceman_id'] = this.servicemanId;
    data['total_campaign_discount_amount'] = this.totalCampaignDiscountAmount;
    data['total_coupon_discount_amount'] = this.totalCouponDiscountAmount;
    data['coupon_code'] = this.couponCode;
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
  String? variantKey;
  String? serviceCost;
  int? quantity;
  String? discountAmount;
  String? taxAmount;
  String? totalCost;
  String? createdAt;
  String? updatedAt;
  String? campaignDiscountAmount;
  String? overallCouponDiscountAmount;
  DashboardService? service;

  Detail(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.variantKey,
        this.serviceCost,
        this.quantity,
        this.discountAmount,
        this.taxAmount,
        this.totalCost,
        this.createdAt,
        this.updatedAt,
        this.campaignDiscountAmount,
        this.overallCouponDiscountAmount,
        this.service});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    variantKey = json['variant_key'];
    serviceCost = json['service_cost'].toString();
    quantity = json['quantity'];
    discountAmount = json['discount_amount'].toString();
    taxAmount = json['tax_amount'].toString();
    totalCost = json['total_cost'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    campaignDiscountAmount = json['campaign_discount_amount'].toString();
    overallCouponDiscountAmount = json['overall_coupon_discount_amount'].toString();
    service =
    json['service'] != null ? new DashboardService.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
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
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class DashboardService {
  String? id;
  String? name;
  String? thumbnail;

  DashboardService({this.id, this.name, this.thumbnail});

  DashboardService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
