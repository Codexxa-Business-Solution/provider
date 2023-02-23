class ServicemanBody {

  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? confirmedPassword;
  String? identityType;
  String? identityNumber;
  String? identityImage;
  String? profileImage;


  ServicemanBody({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.confirmedPassword,
    this.identityType,
    this.identityNumber,
    this.identityImage,
    this.profileImage
  });

  // SignUpBody.fromJson(Map<String, dynamic> json) {
  //   fName = json['f_name'];
  //   lName = json['l_name'];
  //   phone = json['phone'];
  //   email = json['email'];
  //   password = json['password'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['identity_type'] = this.identityType;
    data['identity_number'] = this.identityNumber;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmedPassword;
    data['identity_image'] = this.identityImage;
    data['profile_image'] = this.profileImage;

    return data;
  }
}
