import 'dart:convert';
BookingRequestModel bookingRequestModelFromJson(String str) => BookingRequestModel.fromJson(json.decode(str));

String bookingRequestModelToJson(BookingRequestModel data) => json.encode(data.toJson());

class BookingRequestModel {
  BookingRequestModel({
    this.id,
    this.readableId,
    this.customerId,
    this.providerId,
    this.zoneId,
    this.bookingStatus,
    this.isPaid,
    this.paymentMethod,
    this.transactionId,
    required this.totalBookingAmount,
    this.totalTaxAmount,
    this.totalDiscountAmount,
    this.serviceSchedule,
    this.serviceAddressId,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.subCategoryId,
    this.servicemanId,

  });

  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  String totalBookingAmount;
  String? totalTaxAmount;
  String? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  String? servicemanId;


  factory BookingRequestModel.fromJson(Map<String, dynamic> json) => BookingRequestModel(
    id: json["id"],
    readableId: json['readable_id'],
    customerId: json["customer_id"],
    providerId: json["provider_id"],
    zoneId: json["zone_id"],
    bookingStatus: json["booking_status"],
    isPaid: json["is_paid"],
    paymentMethod: json["payment_method"],
    transactionId: json["transaction_id"],
    totalBookingAmount: json["total_booking_amount"].toString(),
    totalTaxAmount: json["total_tax_amount"].toString(),
    totalDiscountAmount: json["total_discount_amount"].toString(),
    serviceSchedule: json["service_schedule"],
    serviceAddressId: json["service_address_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    servicemanId: json["serviceman_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "readable_id": readableId,
    "customer_id": customerId,
    "provider_id": providerId,
    "zone_id": zoneId,
    "booking_status": bookingStatus,
    "is_paid": isPaid,
    "payment_method": paymentMethod,
    "transaction_id": transactionId,
    "total_booking_amount": totalBookingAmount,
    "total_tax_amount": totalTaxAmount,
    "total_discount_amount": totalDiscountAmount,
    "service_schedule": serviceSchedule,
    "service_address_id": serviceAddressId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "serviceman_id": servicemanId,
  };
}

class Customer {
  Customer({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.identificationNumber,
    this.identificationType,
    this.identificationImage,
    this.dateOfBirth,
    this.gender,
    this.profileImage,
    this.fcmToken,
    this.isPhoneVerified,
    this.isEmailVerified,
    this.phoneVerifiedAt,
    this.emailVerifiedAt,
    this.isActive,
    this.userType,
    this.rememberToken,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? identificationNumber;
  String? identificationType;
  List<String>? identificationImage;
  String? dateOfBirth;
  String? gender;
  String? profileImage;
  String? fcmToken;
  int? isPhoneVerified;
  int? isEmailVerified;
  DateTime? phoneVerifiedAt;
  DateTime? emailVerifiedAt;
  int? isActive;
  String? userType;
  bool? rememberToken;
  DateTime? deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    roleId: json["role_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    identificationNumber: json["identification_number"],
    identificationType: json["identification_type"],
    identificationImage: List<String>.from(json["identification_image"].map((x) => x)),
    dateOfBirth: json["date_of_birth"],
    gender: json["gender"],
    profileImage: json["profile_image"],
    fcmToken: json["fcm_token"],
    isPhoneVerified: json["is_phone_verified"],
    isEmailVerified: json["is_email_verified"],
    phoneVerifiedAt: json["phone_verified_at"],
    emailVerifiedAt: json["email_verified_at"],
    isActive: json["is_active"],
    userType: json["user_type"],
    rememberToken: json["remember_token"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "role_id": roleId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "identification_number": identificationNumber,
    "identification_type": identificationType,
    "identification_image": List<dynamic>.from(identificationImage!.map((x) => x)),
    "date_of_birth": dateOfBirth,
    "gender": gender,
    "profile_image": profileImage,
    "fcm_token": fcmToken,
    "is_phone_verified": isPhoneVerified,
    "is_email_verified": isEmailVerified,
    "phone_verified_at": phoneVerifiedAt,
    "email_verified_at": emailVerifiedAt,
    "is_active": isActive,
    "user_type": userType,
    "remember_token": rememberToken,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}


