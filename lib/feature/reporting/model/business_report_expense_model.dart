import 'package:demandium_provider/feature/reporting/model/booking_report_model.dart';

class BusinessReportExpenseModel {
  Content? content;
  BusinessReportExpenseModel(
      {this.content});

  BusinessReportExpenseModel.fromJson(Map<String, dynamic> json) {
    content = json['content'] != null ? new Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class Content {
  List<ZonesList>? zones;
  List<Categories>? categories;
  List<SubCategories>? subCategories;
  FilteredBookingAmounts? filteredBookingAmounts;
  ChartData? chartData;
  TotalPromotionalCost? totalPromotionalCost;
  String? deterministic;

  Content(
      {this.zones,
        this.categories,
        this.subCategories,
        this.filteredBookingAmounts,
        this.chartData,
        this.totalPromotionalCost,
        this.deterministic
      });

  Content.fromJson(Map<String, dynamic> json) {
    if (json['zones'] != null) {
      zones = <ZonesList>[];
      json['zones'].forEach((v) {
        zones!.add(new ZonesList.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
    filteredBookingAmounts = json['filtered_booking_amounts'] != null
        ? new FilteredBookingAmounts.fromJson(json['filtered_booking_amounts'])
        : null;
    chartData = json['chart_data'] != null
        ? new ChartData.fromJson(json['chart_data'])
        : null;
    totalPromotionalCost = json['total_promotional_cost'] != null
        ? new TotalPromotionalCost.fromJson(json['total_promotional_cost'])
        : null;
    deterministic = json['deterministic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.zones != null) {
      data['zones'] = this.zones!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    if (this.filteredBookingAmounts != null) {
      data['filtered_booking_amounts'] = this.filteredBookingAmounts!.toJson();
    }
    if (this.chartData != null) {
      data['chart_data'] = this.chartData!.toJson();
    }
    if (this.totalPromotionalCost != null) {
      data['total_promotional_cost'] = this.totalPromotionalCost!.toJson();
    }
    data['deterministic'] = this.deterministic;
    return data;
  }
}


class FilteredBookingAmounts {
  int? currentPage;
  List<BusinessReportFilterData>? data;

  int? lastPage;
  int? total;

  FilteredBookingAmounts(
      {this.currentPage,
        this.data,
        this.lastPage,
        this.total});

  FilteredBookingAmounts.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <BusinessReportFilterData>[];
      json['data'].forEach((v) {
        data!.add(new BusinessReportFilterData.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = this.lastPage;
    data['total'] = this.total;
    return data;
  }
}

class BusinessReportFilterData {
  String? id;
  String? bookingDetailsId;
  String? bookingId;
  double? serviceUnitCost;
  double? discountByAdmin;
  double? discountByProvider;
  double? couponDiscountByAdmin;
  double? couponDiscountByProvider;
  double? campaignDiscountByAdmin;
  double? campaignDiscountByProvider;
  double? adminCommission;
  String? createdAt;
  String? updatedAt;
  Booking? booking;

  BusinessReportFilterData(
      {this.id,
        this.bookingDetailsId,
        this.bookingId,
        this.serviceUnitCost,
        this.discountByAdmin,
        this.discountByProvider,
        this.couponDiscountByAdmin,
        this.couponDiscountByProvider,
        this.campaignDiscountByAdmin,
        this.campaignDiscountByProvider,
        this.adminCommission,
        this.createdAt,
        this.updatedAt,
        this.booking});

  BusinessReportFilterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingDetailsId = json['booking_details_id'];
    bookingId = json['booking_id'];
    serviceUnitCost = double.tryParse(json['service_unit_cost'].toString());
    discountByAdmin = double.tryParse(json['discount_by_admin'].toString());
    discountByProvider = double.tryParse(json['discount_by_provider'].toString());
    couponDiscountByAdmin = double.tryParse(json['coupon_discount_by_admin'].toString());
    couponDiscountByProvider = double.tryParse(json['coupon_discount_by_provider'].toString());
    campaignDiscountByAdmin = double.tryParse(json['campaign_discount_by_admin'].toString());
    campaignDiscountByProvider = double.tryParse(json['campaign_discount_by_provider'].toString());
    adminCommission = double.tryParse(json['admin_commission'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    booking =
    json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_details_id'] = this.bookingDetailsId;
    data['booking_id'] = this.bookingId;
    data['service_unit_cost'] = this.serviceUnitCost;
    data['discount_by_admin'] = this.discountByAdmin;
    data['discount_by_provider'] = this.discountByProvider;
    data['coupon_discount_by_admin'] = this.couponDiscountByAdmin;
    data['coupon_discount_by_provider'] = this.couponDiscountByProvider;
    data['campaign_discount_by_admin'] = this.campaignDiscountByAdmin;
    data['campaign_discount_by_provider'] = this.campaignDiscountByProvider;
    data['admin_commission'] = this.adminCommission;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
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
  double? totalBookingAmount;
  double? totalTaxAmount;
  double? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? servicemanId;
  double? totalCampaignDiscountAmount;
  double? totalCouponDiscountAmount;

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
      });

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
    totalBookingAmount = double.tryParse(json['total_booking_amount'].toString());
    totalTaxAmount = double.tryParse(json['total_tax_amount'].toString());
    totalDiscountAmount = double.tryParse(json['total_discount_amount'].toString());
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    servicemanId = json['serviceman_id'];
    totalCampaignDiscountAmount = double.tryParse(json['total_campaign_discount_amount'].toString());
    totalCouponDiscountAmount = double.tryParse(json['total_coupon_discount_amount'].toString());
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
    return data;
  }
}


class ChartData {
  List<double>? expenses;
  List<int>? timeline;

  ChartData({this.expenses, this.timeline});

  ChartData.fromJson(Map<String, dynamic> json) {
    if (json['expenses'] != null) {
      expenses = [];
      json['expenses'].forEach((v){
        expenses?.add(double.parse(v.toString()));
      });
    }
    timeline = json['timeline'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenses'] = this.expenses;
    data['timeline'] = this.timeline;
    return data;
  }
}

class TotalPromotionalCost {
  double? totalExpense;
  double? discount;
  double? coupon;
  double? campaign;

  TotalPromotionalCost(
      {this.totalExpense, this.discount, this.coupon, this.campaign});

  TotalPromotionalCost.fromJson(Map<String, dynamic> json) {
    totalExpense = double.tryParse(json['total_expense'].toString());
    discount = double.tryParse(json['discount'].toString());
    coupon = double.tryParse(json['coupon'].toString());
    campaign = double.tryParse(json['campaign'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_expense'] = this.totalExpense;
    data['discount'] = this.discount;
    data['coupon'] = this.coupon;
    data['campaign'] = this.campaign;
    return data;
  }
}
