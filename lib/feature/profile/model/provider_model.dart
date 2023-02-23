class ProviderModel {
  String? responseCode;
  String? message;
  Content? content;


  ProviderModel({this.responseCode, this.message, this.content});

  ProviderModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;

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

class Content {
  ProviderInfo? providerInfo;
  List<BookingOverview>? bookingOverview;
  PromotionalCostPercentage? promotionalCostPercentage;

  Content({this.providerInfo, this.bookingOverview,this.promotionalCostPercentage});

  Content.fromJson(Map<String, dynamic> json) {
    providerInfo = json['provider_info'] != null
        ? new ProviderInfo.fromJson(json['provider_info'])
        : null;
    if (json['booking_overview'] != null) {
      bookingOverview = <BookingOverview>[];
      json['booking_overview'].forEach((v) {
        bookingOverview!.add(new BookingOverview.fromJson(v));
      });
    }
    promotionalCostPercentage = json['promotional_cost_percentage'] != null
        ? new PromotionalCostPercentage.fromJson(json['promotional_cost_percentage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.providerInfo != null) {
      data['provider_info'] = this.providerInfo!.toJson();
    }
    if (this.bookingOverview != null) {
      data['booking_overview'] =
          this.bookingOverview!.map((v) => v.toJson()).toList();
    }

    if (this.promotionalCostPercentage != null) {
      data['promotional_cost_percentage'] = this.promotionalCostPercentage!.toJson();
    }
    return data;
  }
}

class ProviderInfo {
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
  String? orderCount;
  int? serviceManCount;
  int? serviceCapacityPerDay;
  int? ratingCount;
  var avgRating;
  int? commissionStatus;
  double? commissionPercentage;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  int? isApproved;
  String? zoneId;
  Owner? owner;

  ProviderInfo(
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

  ProviderInfo.fromJson(Map<String, dynamic> json) {
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
    orderCount = json['order_count'].toString();
    serviceManCount = int.parse(json['service_man_count'].toString());
    serviceCapacityPerDay = int.parse(json['service_capacity_per_day'].toString());
    ratingCount =  int.parse(json['rating_count'].toString());
    avgRating = json['avg_rating'];
    commissionStatus =  int.parse(json['commission_status'].toString());
    commissionPercentage = double.parse(json['commission_percentage'].toString());
    isActive = int.parse(json['is_active'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isApproved = int.parse(json['is_approved'].toString());
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
  int? isPhoneVerified;
  int? isEmailVerified;
  int? isActive;
  String? userType;
  String? createdAt;
  String? updatedAt;
  Account? account;

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
        this.isPhoneVerified,
        this.isEmailVerified,
        this.isActive,
        this.userType,
        this.createdAt,
        this.updatedAt,
        this.account});

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
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    isActive = json['is_active'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
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
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}

class Account {
  String? id;
  String? userId;
  String? balancePending;
  String? receivedBalance;
  String? accountPayable;
  String? accountReceivable;
  String? totalWithdrawn;
  String? createdAt;
  String? updatedAt;

  Account(
      {this.id,
        this.userId,
        this.balancePending,
        this.receivedBalance,
        this.accountPayable,
        this.accountReceivable,
        this.totalWithdrawn,
        this.createdAt,
        this.updatedAt});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    balancePending = json['balance_pending'].toString();
    receivedBalance = json['received_balance'].toString();
    accountPayable = json['account_payable'].toString();
    accountReceivable = json['account_receivable'].toString();
    totalWithdrawn = json['total_withdrawn'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['balance_pending'] = this.balancePending;
    data['received_balance'] = this.receivedBalance;
    data['account_payable'] = this.accountPayable;
    data['account_receivable'] = this.accountReceivable;
    data['total_withdrawn'] = this.totalWithdrawn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BookingOverview {
  String? bookingStatus;
  int? total;

  BookingOverview({this.bookingStatus, this.total});

  BookingOverview.fromJson(Map<String, dynamic> json) {
    bookingStatus = json['booking_status'];
    total = int.tryParse(json['total'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_status'] = this.bookingStatus;
    data['total'] = this.total;
    return data;
  }
}

class PromotionalCostPercentage {
  String? discount;
  String? campaign;
  String? coupon;

  PromotionalCostPercentage({this.discount, this.campaign, this.coupon});

  PromotionalCostPercentage.fromJson(Map<String, dynamic> json) {
    discount = json['discount'].toString();
    campaign = json['campaign'].toString();
    coupon = json['coupon'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount'] = this.discount;
    data['campaign'] = this.campaign;
    data['coupon'] = this.coupon;
    return data;
  }
}
