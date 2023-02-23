import 'package:demandium_provider/feature/reporting/model/booking_report_model.dart';

class TransactionReportModel {
  String? responseCode;
  Content? content;

  TransactionReportModel({this.responseCode,this.content});

  TransactionReportModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];

    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class Content {
  List<ZonesList>? zones;
  FilteredTransactions? filteredTransactions;
  TransactionReportAccountInfo? accountInfo;

  Content({this.zones, this.filteredTransactions,this.accountInfo});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['zones'] != null) {
      zones = <ZonesList>[];
      json['zones'].forEach((v) {
        zones!.add(new ZonesList.fromJson(v));
      });
    }
    filteredTransactions = json['filtered_transactions'] != null
        ? new FilteredTransactions.fromJson(json['filtered_transactions'])
        : null;

    accountInfo = json['account_info'] != null
        ? new TransactionReportAccountInfo.fromJson(json['account_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.zones != null) {
      data['zones'] = this.zones!.map((v) => v.toJson()).toList();
    }
    if (this.filteredTransactions != null) {
      data['filtered_transactions'] = this.filteredTransactions!.toJson();
    }
    if (this.accountInfo != null) {
      data['account_info'] = this.accountInfo!.toJson();
    }
    return data;
  }
}


class FilteredTransactions {
  int? currentPage;
  List<TransactionReportData>? data;
  int? lastPage;
  int? to;
  int? total;

  FilteredTransactions(
      {this.currentPage, this.data, this.lastPage, this.to, this.total});

  FilteredTransactions.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TransactionReportData>[];
      json['data'].forEach((v) {
        data!.add(new TransactionReportData.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = this.lastPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class TransactionReportData {
  String? id;
  String? trxType;
  double? debit;
  double? credit;
  double? balance;
  String? fromUserId;
  String? toUserId;
  String? createdAt;
  String? updatedAt;
  String? fromUserAccount;
  FromUser? fromUser;
  FromUser? toUser;

  TransactionReportData(
      {this.id,
        this.trxType,
        this.debit,
        this.credit,
        this.balance,
        this.fromUserId,
        this.toUserId,
        this.createdAt,
        this.updatedAt,
        this.fromUserAccount,
        this.fromUser,
        this.toUser});

  TransactionReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trxType = json['trx_type'];
    debit = double.tryParse(json['debit'].toString());
    credit = double.tryParse(json['credit'].toString());
    balance = double.tryParse(json['balance'].toString());
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fromUserAccount = json['from_user_account'];
    fromUser = json['from_user'] != null
        ? new FromUser.fromJson(json['from_user'])
        : null;
    toUser =
    json['to_user'] != null ? new FromUser.fromJson(json['to_user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trx_type'] = this.trxType;
    data['debit'] = this.debit;
    data['credit'] = this.credit;
    data['balance'] = this.balance;
    data['from_user_id'] = this.fromUserId;
    data['to_user_id'] = this.toUserId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['from_user_account'] = this.fromUserAccount;
    if (this.fromUser != null) {
      data['from_user'] = this.fromUser!.toJson();
    }
    if (this.toUser != null) {
      data['to_user'] = this.toUser!.toJson();
    }
    return data;
  }
}

class FromUser {
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

  FromUser(
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

  FromUser.fromJson(Map<String, dynamic> json) {
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

class TransactionReportAccountInfo {
  String? id;
  String? userId;
  double? balancePending;
  double? receivedBalance;
  double? accountPayable;
  double? accountReceivable;
  double? totalWithdrawn;


  TransactionReportAccountInfo(
      {this.id,
        this.userId,
        this.balancePending,
        this.receivedBalance,
        this.accountPayable,
        this.accountReceivable,
        this.totalWithdrawn,});

  TransactionReportAccountInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    balancePending = double.tryParse(json['balance_pending'].toString());
    receivedBalance = double.tryParse(json['received_balance'].toString());
    accountPayable = double.tryParse(json['account_payable'].toString());
    accountReceivable = double.tryParse(json['account_receivable'].toString());
    totalWithdrawn = double.tryParse(json['total_withdrawn'].toString());
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
    return data;
  }
}
