class BankInfoModel {
  String? responseCode;
  String? message;
  Content? content;


  BankInfoModel({this.responseCode, this.message, this.content});

  BankInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? providerId;
  String? bankName;
  String? branchName;
  String? accNo;
  String? accHolderName;
  String? routingNumber;
  String? createdAt;
  String? updatedAt;

  Content(
      {this.id,
        this.providerId,
        this.bankName,
        this.branchName,
        this.accNo,
        this.accHolderName,
        this.createdAt,
        this.updatedAt,
        this.routingNumber
      });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    accNo = json['acc_no'];
    accHolderName = json['acc_holder_name'];
    routingNumber = json['routing_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['acc_no'] = this.accNo;
    data['acc_holder_name'] = this.accHolderName;
    data['routing_number'] = this.routingNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}