class BookingDetailsModel {
  String? responseCode;
  String? message;
  BookingDetailsContent? content;

  BookingDetailsModel({this.responseCode, this.message, this.content});

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? new BookingDetailsContent.fromJson(json['content']) : null;
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

class BookingDetailsContent {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  String totalBookingAmount='';
  String totalTaxAmount='';
  String totalDiscountAmount='';
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? servicemanId;
  List<BookingService>? detail;
  List<ScheduleHistories>? scheduleHistories;
  List<StatusHistories>? statusHistories;
  ServiceAddress? serviceAddress;
  Customer? customer;
  Provider? provider;
  Serviceman? serviceman;
  String ? totalCampaignDiscountAmount;
  String ? totalCouponDiscountAmount;

  BookingDetailsContent(
      {this.id,
      this.readableId,
      this.customerId,
      this.providerId,
      this.zoneId,
      this.bookingStatus,
      this.isPaid,
      this.paymentMethod,
      this.transactionId,
      required this.totalBookingAmount,
      required this.totalTaxAmount,
      required this.totalDiscountAmount,
      this.serviceSchedule,
      this.serviceAddressId,
      this.createdAt,
      this.updatedAt,
      this.servicemanId,
      this.detail,
      this.scheduleHistories,
      this.statusHistories,
      this.serviceAddress,
      this.customer,
      this.provider,
      this.serviceman,
      this.totalCampaignDiscountAmount,
      this.totalCouponDiscountAmount});

  BookingDetailsContent.fromJson(Map<String, dynamic> json) {
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
    servicemanId = json['serviceman_id'];
    if (json['detail'] != null) {
      detail = <BookingService>[];
      json['detail'].forEach((v) {
        detail!.add(new BookingService.fromJson(v));
      });
    }
    if (json['schedule_histories'] != null) {
      scheduleHistories = <ScheduleHistories>[];
      json['schedule_histories'].forEach((v) {
        scheduleHistories!.add(new ScheduleHistories.fromJson(v));
      });
    }
    if (json['status_histories'] != null) {
      statusHistories = <StatusHistories>[];
      json['status_histories'].forEach((v) {

        statusHistories!.add(new StatusHistories.fromJson(v));
      });
    }
    serviceAddress = json['service_address'] != null
        ? new ServiceAddress.fromJson(json['service_address'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;

    serviceman = json['serviceman'] != null
        ? new Serviceman.fromJson(json['serviceman'])
        : null;
    totalCampaignDiscountAmount = json['total_campaign_discount_amount'].toString();
    totalCouponDiscountAmount =json['total_coupon_discount_amount'].toString();


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
    data['serviceman_id'] = this.servicemanId;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleHistories != null) {
      data['schedule_histories'] =
          this.scheduleHistories!.map((v) => v.toJson()).toList();
    }
    if (this.statusHistories != null) {
      data['status_histories'] =
          this.statusHistories!.map((v) => v.toJson()).toList();
    }
    if (this.serviceAddress != null) {
      data['service_address'] = this.serviceAddress!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }

    if (this.serviceman != null) {
      data['serviceman'] = this.provider!.toJson();
    }
    return data;
  }
}

class BookingService {
  int? id;
  String? bookingId;
  String? serviceId;
  String? serviceName;
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
  bookingDetailsService? service;

  BookingService(
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
        this.service,
        this.campaignDiscountAmount,
        this.overallCouponDiscountAmount,});

  BookingService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    variantKey = json['variant_key'];
    serviceCost = json['service_cost'].toString();
    quantity = json['quantity'];
    discountAmount = json['discount_amount'].toString();
    taxAmount = json['tax_amount'].toString();
    totalCost = json['total_cost'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    campaignDiscountAmount = json['campaign_discount_amount'].toString();
    service =
    json['service'] != null ? new bookingDetailsService.fromJson(json['service']) : null;
    overallCouponDiscountAmount =json['overall_coupon_discount_amount'].toString();
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
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class bookingDetailsService {
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
  String? createdAt;
  String? updatedAt;

  bookingDetailsService(
      {this.id,
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
      this.createdAt,
      this.updatedAt});

  bookingDetailsService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    coverImage = json['cover_image'];
    thumbnail = json['thumbnail'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    tax = json['tax'];
    orderCount = json['order_count'];
    isActive = json['is_active'];
    ratingCount = json['rating_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['cover_image'] = this.coverImage;
    data['thumbnail'] = this.thumbnail;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['tax'] = this.tax;
    data['order_count'] = this.orderCount;
    data['is_active'] = this.isActive;
    data['rating_count'] = this.ratingCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class ScheduleHistories {
  int? id;
  String? bookingId;
  String? changedBy;
  String? schedule;
  String? createdAt;
  String? updatedAt;
  User? user;

  ScheduleHistories(
      {this.id,
        this.bookingId,
        this.changedBy,
        this.schedule,
        this.createdAt,
        this.updatedAt,
        this.user});

  ScheduleHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    changedBy = json['changed_by'];
    schedule = json['schedule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['changed_by'] = this.changedBy;
    data['schedule'] = this.schedule;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}


class StatusHistories {
  int? id;
  String? bookingId;
  String? changedBy;
  String? bookingStatus;
  String? createdAt;
  String? updatedAt;
  ServicemanBody? user;

  StatusHistories(
      {this.id,
      this.bookingId,
      this.changedBy,
      this.bookingStatus,
      this.createdAt,
      this.updatedAt,
      this.user});

  StatusHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    changedBy = json['changed_by'];
    bookingStatus = json['booking_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new ServicemanBody.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['changed_by'] = this.changedBy;
    data['booking_status'] = this.bookingStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationNumber;
  String? identificationType;
  String? gender;
  String? profileImage;
  int? isPhoneVerified;
  int? isEmailVerified;
  int? isActive;
  String? userType;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.identificationNumber,
      this.identificationType,
      this.gender,
      this.profileImage,
      this.isPhoneVerified,
      this.isEmailVerified,
      this.isActive,
      this.userType,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];
    gender = json['gender'];
    profileImage = json['profile_image'];
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

    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_active'] = this.isActive;
    data['user_type'] = this.userType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ServiceAddress {
  int? id;
  String? userId;
  String? lat;
  String? lon;
  String? city;
  String? street;
  String? zipCode;
  String? country;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? addressType;
  String? contactPersonName;
  String? contactPersonNumber;
  String? addressLabel;

  ServiceAddress(
      {this.id,
      this.userId,
      this.lat,
      this.lon,
      this.city,
      this.street,
      this.zipCode,
      this.country,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.addressType,
      this.contactPersonName,
      this.contactPersonNumber,
      this.addressLabel});

  ServiceAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lon = json['lon'];
    city = json['city'];
    street = json['street'];
    zipCode = json['zip_code'];
    country = json['country'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addressType = json['address_type'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    addressLabel = json['address_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['city'] = this.city;
    data['street'] = this.street;
    data['zip_code'] = this.zipCode;
    data['country'] = this.country;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['address_type'] = this.addressType;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_number'] = this.contactPersonNumber;
    data['address_label'] = this.addressLabel;
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
    data['identification_type'] = this.identificationType;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
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
  var avgRating;
  int? commissionStatus;
  int? commissionPercentage;
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
      this.commissionPercentage,
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
    avgRating = json['avg_rating'];
    commissionStatus = json['commission_status'];
    commissionPercentage = json['commission_percentage'];
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
    data['commission_percentage'] = this.commissionPercentage;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_approved'] = this.isApproved;
    data['zone_id'] = this.zoneId;
    return data;
  }
}

class Serviceman {
  String? id;
  String? providerId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  ServicemanBody? user;

  Serviceman(
      {this.id,
        this.providerId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user});

  Serviceman.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new ServicemanBody.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class ServicemanBody {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationNumber;
  String? identificationType;
  List<dynamic>? identificationImage;
  String? gender;
  String? profileImage;
  int? isPhoneVerified;
  int? isEmailVerified;
  int? isActive;
  String? userType;
  String? createdAt;
  String? updatedAt;

  ServicemanBody(
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
        this.isPhoneVerified,
        this.isEmailVerified,
        this.isActive,
        this.userType,
        this.createdAt,
        this.updatedAt});

  ServicemanBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];
    identificationImage = json['identification_image'];
    gender = json['gender'];
    profileImage = json['profile_image'];
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
    data['is_phone_verified'] = this.isPhoneVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_active'] = this.isActive;
    data['user_type'] = this.userType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}