class SignUpBody {
  String? contactPersonName;
  String? contactPersonPhone;
  String? contactPersonEmail;
  String? accountFirstName;
  String? accountLastName;
  String? accountEmail;
  String? accountPhone;
  String? password;
  String? confirmedPassword;
  String? companyName;
  String? companyPhone;
  String? companyAddress;
  String? companyEmail;
  String? logo;
  String? identityType;
  String? identityNumber;
  String? identityImage;
  String? zoneId;

  SignUpBody({
      this.contactPersonName,
      this.contactPersonPhone,
      this.contactPersonEmail,
      this.accountFirstName,
      this.accountLastName,
      this.accountEmail,
      this.accountPhone,
      this.password,
      this.confirmedPassword,
      this.companyName,
      this.companyPhone,
      this.companyAddress,
      this.companyEmail,
      this.logo,
      this.identityType,
      this.identityNumber,
      this.identityImage,
      this.zoneId
  });

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['contact_person_name'] = this.contactPersonName!;
    data['contact_person_phone'] = this.contactPersonPhone!;
    data['contact_person_email'] = this.contactPersonEmail!;
    data['account_first_name'] = this.accountFirstName!;
    data['account_last_name'] = this.accountLastName!;
    data['account_email'] = this.accountEmail!;
    data['account_phone'] = this.accountPhone!;
    data['company_name'] = this.companyName!;
    data['company_phone'] = this.companyPhone!;
    data['company_address'] = this.companyAddress!;
    data['company_email'] = this.companyEmail!;
    data['logo'] = this.logo!;
    data['identity_type'] = this.identityType!;
    data['identity_number'] = this.identityNumber!;
    data['password'] = this.password!;
    data['confirm_password'] = this.confirmedPassword!;
    data['identity_images'] = this.identityImage!;
    data['zone_id']= this.zoneId!;

    return data;
  }
}
