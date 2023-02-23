
import 'dart:core';

class BookingReportModel {
  BookingReportContent? content;
  BookingReportModel({this.content});

  BookingReportModel.fromJson(Map<String, dynamic> json) {
    content = json['content'] != null ? new BookingReportContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class BookingReportContent {
  List<ZonesList>? zones;
  List<Categories>? categories;
  List<SubCategories>? subCategories;
  BookingsCount? bookingsCount;
  BookingAmount? bookingAmount;
  FilterData? filterData;
  BookingReportChartData? chartData;

  BookingReportContent(
      {this.zones,
        this.categories,
        this.subCategories,
        this.bookingsCount,
        this.bookingAmount,
        this.chartData,
        this.filterData
      });

  BookingReportContent.fromJson(Map<String, dynamic> json) {
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
    bookingsCount = json['bookings_count'] != null
        ? new BookingsCount.fromJson(json['bookings_count'])
        : null;
    bookingAmount = json['booking_amount'] != null
        ? new BookingAmount.fromJson(json['booking_amount'])
        : null;

    chartData = json['chart_data'] != null
        ? new BookingReportChartData.fromJson(json['chart_data'])
        : null;

    filterData = json['filtered_bookings'] != null
        ? new FilterData.fromJson(json['filtered_bookings'])
        : null;
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
    if (this.bookingsCount != null) {
      data['bookings_count'] = this.bookingsCount!.toJson();
    }
    if (this.bookingAmount != null) {
      data['booking_amount'] = this.bookingAmount!.toJson();
    }

    if (this.chartData != null) {
      data['chart_data'] = this.chartData!.toJson();
    }
    if (this.filterData != null) {
      data['filtered_bookings'] = this.filterData!.toJson();
    }
    return data;
  }
}

class ZonesList {
  String? id;
  String? name;

  ZonesList({this.id, this.name});

  ZonesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SubCategories {
  String? id;
  String? parentId;
  String? name;

  SubCategories({this.id, this.parentId, this.name});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    return data;
  }
}

class BookingsCount {
  int? totalBookings;
  int? accepted;
  int? ongoing;
  int? completed;
  int? canceled;

  BookingsCount(
      {this.totalBookings, this.ongoing, this.completed, this.canceled,this.accepted});

  BookingsCount.fromJson(Map<String, dynamic> json) {
    totalBookings = json['total_bookings'];
    ongoing = json['ongoing'];
    accepted = json['accepted'];
    completed = json['completed'];
    canceled = json['canceled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_bookings'] = this.totalBookings;
    data['ongoing'] = this.ongoing;
    data['accepted'] = this.accepted;
    data['completed'] = this.completed;
    data['canceled'] = this.canceled;
    return data;
  }
}

class Categories {
  String? id;
  String? name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class BookingAmount {
  double? totalBookingAmount;
  double? totalPaidBookingAmount;
  double? totalUnpaidBookingAmount;

  BookingAmount(
      {this.totalBookingAmount,
        this.totalPaidBookingAmount,
        this.totalUnpaidBookingAmount});

  BookingAmount.fromJson(Map<String, dynamic> json) {
    totalBookingAmount = double.tryParse(json['total_booking_amount'].toString());
    totalPaidBookingAmount = double.tryParse(json['total_paid_booking_amount'].toString());
    totalUnpaidBookingAmount = double.tryParse(json['total_unpaid_booking_amount'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_booking_amount'] = this.totalBookingAmount;
    data['total_paid_booking_amount'] = this.totalPaidBookingAmount;
    data['total_unpaid_booking_amount'] = this.totalUnpaidBookingAmount;
    return data;
  }
}

class BookingReportChartData {
  List<double>? bookingAmount;
  List<double>? taxAmount;
  List<double>? adminCommission;
  List<int>? timeline;

  BookingReportChartData(
      {this.bookingAmount,
        this.taxAmount,
        this.adminCommission,
        this.timeline});

  BookingReportChartData.fromJson(Map<String, dynamic> json) {
    if (json['booking_amount'] != null) {
      bookingAmount = [];
      json['booking_amount'].forEach((v){
        bookingAmount?.add(double.parse(v.toString()));
      });
    }
    if (json['tax_amount'] != null) {
      taxAmount = [];
      json['tax_amount'].forEach((v){
        taxAmount?.add(double.parse(v.toString()));
      });
    }
    if (json['admin_commission'] != null) {
      adminCommission = [];
      json['admin_commission'].forEach((v){
        adminCommission?.add(double.parse(v.toString()));
      });
    }
    timeline = json['timeline'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_amount'] = this.bookingAmount;
    data['tax_amount'] = this.taxAmount;
    data['admin_commission'] = this.adminCommission;
    data['timeline'] = this.timeline;
    return data;
  }
}

class FilterData {
  List<BookingFilterData>? data;
  int? lastPage;
  int? total;

  FilterData({this.data, this.lastPage, this.total});

  FilterData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BookingFilterData>[];
      json['data'].forEach((v) {
        data!.add(new BookingFilterData.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = this.lastPage;
    data['total'] = this.total;
    return data;
  }
}

class BookingFilterData {
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
  int? isChecked;
  Customer? customer;
  Provider? provider;

  BookingFilterData(
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
        this.totalCouponDiscountAmount, e,
        this.isChecked,
        this.customer,
        this.provider});

  BookingFilterData.fromJson(Map<String, dynamic> json) {
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
    isChecked = json['is_checked'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
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
    data['serviceman_id'] = this.servicemanId;
    data['total_campaign_discount_amount'] = this.totalCampaignDiscountAmount;
    data['total_coupon_discount_amount'] = this.totalCouponDiscountAmount;
    data['is_checked'] = this.isChecked;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationType;
  String? gender;
  String? profileImage;
  String? fcmToken;
  int? isPhoneVerified;
  int? isEmailVerified;
  int? isActive;
  String? userType;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.identificationType,
        this.gender,
        this.profileImage,
        this.fcmToken,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.isActive,
        this.userType,
        this.createdAt,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationType = json['identification_type'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    fcmToken = json['fcm_token'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    isActive = json['is_active'];
    userType = json['user_type'];;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['identification_type'] = this.identificationType;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['fcm_token'] = this.fcmToken;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_active'] = this.isActive;
    data['user_type'] = this.userType;
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
  int? commissionPercentage;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? isApproved;
  String? zoneId;
  Owner? owner;

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
        this.commissionPercentage,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.isApproved,
        this.zoneId,
        this.owner});

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
    commissionPercentage = json['commission_percentage'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isApproved = json['is_approved'];
    zoneId = json['zone_id'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
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
    data['commission_percentage'] = this.commissionPercentage;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_approved'] = this.isApproved;
    data['zone_id'] = this.zoneId;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    return data;
  }
}

class Owner {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationNumber;
  String? identificationType;
  List<String>? identificationImage;
  String? gender;
  String? profileImage;
  String? fcmToken;
  int? isPhoneVerified;
  int? isEmailVerified;
  int? isActive;
  String? userType;
  String? createdAt;
  String? updatedAt;

  Owner(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.identificationNumber,
        this.identificationType,
        this.identificationImage,
        this.gender,
        this.profileImage,
        this.fcmToken,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.isActive,
        this.userType,
        this.createdAt,
        this.updatedAt});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];
    identificationImage = json['identification_image'].cast<String>();
    gender = json['gender'];
    profileImage = json['profile_image'];
    fcmToken = json['fcm_token'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    isActive = json['is_active'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['identification_number'] = this.identificationNumber;
    data['identification_type'] = this.identificationType;
    data['identification_image'] = this.identificationImage;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['fcm_token'] = this.fcmToken;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_active'] = this.isActive;
    data['user_type'] = this.userType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

