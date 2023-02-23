class TransactionModel {
  String? responseCode;
  String? message;
  Content? content;


  TransactionModel(
      {this.responseCode, this.message, this.content});

  TransactionModel.fromJson(Map<String, dynamic> json) {
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
  WithdrawRequests? withdrawRequests;
  String? totalCollectedCash;

  Content({this.withdrawRequests, this.totalCollectedCash});

  Content.fromJson(Map<String, dynamic> json) {
    withdrawRequests = json['withdraw_requests'] != null
        ? new WithdrawRequests.fromJson(json['withdraw_requests'])
        : null;
    totalCollectedCash = json['total_collected_cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.withdrawRequests != null) {
      data['withdraw_requests'] = this.withdrawRequests!.toJson();
    }
    data['total_collected_cash'] = this.totalCollectedCash;
    return data;
  }
}

class WithdrawRequests {
  int? currentPage;
  List<TransactionData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  int? to;
  int? total;

  WithdrawRequests(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.to,
        this.total});

  WithdrawRequests.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TransactionData>[];
      json['data'].forEach((v) {
        data!.add(new TransactionData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class TransactionData {
  String? id;
  String? userId;
  String? requestUpdatedBy;
  String? amount;
  String? requestStatus;
  String? createdAt;
  String? updatedAt;
  int? isPaid;
  String? note;
  User? user;
  RequestUpdater? requestUpdater;

  TransactionData(
      {this.id,
        this.userId,
        this.requestUpdatedBy,
        this.amount,
        this.requestStatus,
        this.createdAt,
        this.updatedAt,
        this.isPaid,
        this.note,
        this.user,
        this.requestUpdater
      });

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    requestUpdatedBy = json['request_updated_by'];
    amount = json['amount'].toString();
    requestStatus = json['request_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPaid = json['is_paid'];
    note = json['note'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    requestUpdater = json['request_updater'] != null ? new RequestUpdater.fromJson(json['request_updater']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['request_updated_by'] = this.requestUpdatedBy;
    data['amount'] = this.amount;
    data['request_status'] = this.requestStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_paid'] = this.isPaid;
    data['note'] = this.note;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.requestUpdater != null) {
      data['request_updater'] = this.requestUpdater!.toJson();
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

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class RequestUpdater {
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
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Account? account;

  RequestUpdater(
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
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.account});

  RequestUpdater.fromJson(Map<String, dynamic> json) {
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
    deletedAt = json['deleted_at'];
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
    data['identification_type'] = this.identificationType;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_active'] = this.isActive;
    data['user_type'] = this.userType;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}


