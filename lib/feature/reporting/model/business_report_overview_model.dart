import 'package:demandium_provider/feature/reporting/model/booking_report_model.dart';

class BusinessReportOverviewModel {
  Content? content;
  BusinessReportOverviewModel(
      { this.content});

  BusinessReportOverviewModel.fromJson(Map<String, dynamic> json) {
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
  List<Amounts>? amounts;
  ChartData? chartData;
  TotalPromotionalCost? totalPromotionalCost;
  String? deterministic;

  Content(
      {this.zones,
        this.categories,
        this.subCategories,
        this.amounts,
        this.chartData,
        this.totalPromotionalCost,
        this.deterministic});

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
    if (json['amounts'] != null) {
      amounts = <Amounts>[];
      json['amounts'].forEach((v) {
        amounts!.add(new Amounts.fromJson(v));
      });
    }
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
    if (this.amounts != null) {
      data['amounts'] = this.amounts!.map((v) => v.toJson()).toList();
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


class Amounts {
  double? serviceUnitCost;
  double? discountByAdmin;
  double? serviceTax;
  double? discountByProvider;
  double? couponDiscountByAdmin;
  double? couponDiscountByProvider;
  double? campaignDiscountByAdmin;
  double? campaignDiscountByProvider;
  double? adminCommission;
  double? providerEarning;
  int? year;

  Amounts(
      {this.serviceUnitCost,
        this.discountByAdmin,
        this.serviceTax,
        this.discountByProvider,
        this.couponDiscountByAdmin,
        this.couponDiscountByProvider,
        this.campaignDiscountByAdmin,
        this.campaignDiscountByProvider,
        this.adminCommission,
        this.providerEarning,
        this.year});

  Amounts.fromJson(Map<String, dynamic> json) {
    serviceUnitCost = double.tryParse(json['service_unit_cost'].toString());
    discountByAdmin = double.tryParse(json['discount_by_admin'].toString());
    serviceTax = double.tryParse(json['service_tax'].toString());
    discountByProvider = double.tryParse(json['discount_by_provider'].toString());
    couponDiscountByAdmin = double.tryParse(json['coupon_discount_by_admin'].toString());
    couponDiscountByProvider = double.tryParse( json['coupon_discount_by_provider'].toString());
    campaignDiscountByAdmin = double.tryParse(json['campaign_discount_by_admin'].toString());
    campaignDiscountByProvider = double.tryParse(json['campaign_discount_by_provider'].toString());
    providerEarning = double.tryParse(json['provider_earning'].toString());
    adminCommission = double.tryParse(json['admin_commission'].toString());
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_unit_cost'] = this.serviceUnitCost;
    data['discount_by_admin'] = this.discountByAdmin;
    data['service_tax'] = this.serviceTax;
    data['discount_by_provider'] = this.discountByProvider;
    data['coupon_discount_by_admin'] = this.couponDiscountByAdmin;
    data['coupon_discount_by_provider'] = this.couponDiscountByProvider;
    data['campaign_discount_by_admin'] = this.campaignDiscountByAdmin;
    data['campaign_discount_by_provider'] = this.campaignDiscountByProvider;
    data['admin_commission'] = this.adminCommission;
    data['provider_earning'] = this.providerEarning;
    data['year'] = this.year;
    return data;
  }
}

class ChartData {
  List<double>? earnings;
  List<double>? expenses;
  List<int>? timeline;

  ChartData({this.earnings, this.expenses, this.timeline});

  ChartData.fromJson(Map<String, dynamic> json) {
    if (json['earnings'] != null) {
      earnings = [];
      json['earnings'].forEach((v){
        earnings?.add(double.parse(v.toString()));
      });
    }
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
    data['earnings'] = this.earnings;
    data['expenses'] = this.expenses;
    data['timeline'] = this.timeline;
    return data;
  }
}

class TotalPromotionalCost {
  double? discount;
  double? coupon;
  double? campaign;

  TotalPromotionalCost({this.discount, this.coupon, this.campaign});

  TotalPromotionalCost.fromJson(Map<String, dynamic> json) {
    discount = double.tryParse(json['discount'].toString());
    coupon = double.tryParse(json['coupon'].toString());
    campaign = double.tryParse(json['campaign'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount'] = this.discount;
    data['coupon'] = this.coupon;
    data['campaign'] = this.campaign;
    return data;
  }
}
