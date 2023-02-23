import 'package:demandium_provider/feature/reporting/model/booking_report_model.dart';

class BusinessReportEarningModel {

  Content? content;


  BusinessReportEarningModel(
      { this.content});

  BusinessReportEarningModel.fromJson(Map<String, dynamic> json) {
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
  Bookings? bookings;
  ChartData? chartData;
  String? deterministic;
  Content(
      {this.zones,
        this.categories,
        this.subCategories,
        this.bookings,
        this.chartData,
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
    bookings = json['bookings'] != null
        ? new Bookings.fromJson(json['bookings'])
        : null;

    chartData = json['chart_data'] != null
        ? new ChartData.fromJson(json['chart_data'])
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
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.toJson();
    }

    if (this.chartData != null) {
      data['chart_data'] = this.chartData!.toJson();
    }
    return data;
  }
}


class Bookings {
  int? currentPage;
  int? lastPage;
  int? to;
  int? total;
  List<BusinessReportEarningFilterData>? filterData;

  Bookings(
      {
        this.currentPage,
        this.lastPage,
        this.to,
        this.total,
        this.filterData
      });

  Bookings.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    to = json['to'];
    total = json['total'];
    if (json['data'] != null) {
      filterData = <BusinessReportEarningFilterData>[];
      json['data'].forEach((v) {
        filterData!.add(new BusinessReportEarningFilterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['to'] = this.to;
    data['total'] = this.total;

    if (this.filterData != null) {
      data['data'] = this.filterData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessReportEarningFilterData {
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
  double? totalCampaignDiscountAmount;
  double? totalCouponDiscountAmount;
  BookingDetailsAmounts? bookingDetailsAmounts;

  BusinessReportEarningFilterData(
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
        this.totalCampaignDiscountAmount,
        this.totalCouponDiscountAmount,
        this.bookingDetailsAmounts});

  BusinessReportEarningFilterData.fromJson(Map<String, dynamic> json) {
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
    totalCampaignDiscountAmount = double.tryParse(json['total_campaign_discount_amount'].toString());
    totalCouponDiscountAmount = double.tryParse(json['total_coupon_discount_amount'].toString());
    bookingDetailsAmounts = json['booking_details_amounts'] != null
        ? new BookingDetailsAmounts.fromJson(json['booking_details_amounts'])
        : null;
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
    data['total_campaign_discount_amount'] = this.totalCampaignDiscountAmount;
    data['total_coupon_discount_amount'] = this.totalCouponDiscountAmount;
    if (this.bookingDetailsAmounts != null) {
      data['booking_details_amounts'] = this.bookingDetailsAmounts!.toJson();
    }
    return data;
  }
}

class BookingDetailsAmounts {
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
  double? providerEarning;
  String? createdAt;
  String? updatedAt;

  BookingDetailsAmounts(
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
        this.providerEarning,
        this.createdAt,
        this.updatedAt});

  BookingDetailsAmounts.fromJson(Map<String, dynamic> json) {
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
    providerEarning = double.tryParse(json['provider_earning'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['provider_earning'] = this.providerEarning;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}



class ChartData {
  List<double>? netProfit;
  List<double>? totalEarning;
  List<double>? totalExpense;
  List<int>? timeline;

  ChartData({this.netProfit, this.totalEarning,this.totalExpense, this.timeline});

  ChartData.fromJson(Map<String, dynamic> json) {
    if (json['net_profit'] != null) {
      netProfit = [];
      json['net_profit'].forEach((v){
        netProfit?.add(double.parse(v.toString()));
      });
    }
    if (json['total_earning'] != null) {
      totalEarning = [];
      json['total_earning'].forEach((v){
        totalEarning?.add(double.parse(v.toString()));
      });
    }
    if (json['total_expense'] != null) {
      totalExpense = [];
      json['total_expense'].forEach((v){
        totalExpense?.add(double.parse(v.toString()));
      });
    }
    timeline = json['timeline'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['net_profit'] = this.netProfit;
    data['total_earning'] = this.totalEarning;
    data['total_expense'] = this.totalExpense;
    data['timeline'] = this.timeline;
    return data;
  }
}
