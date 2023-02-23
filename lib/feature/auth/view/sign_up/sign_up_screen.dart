import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: GetBuilder<SignUpController>(
          builder: (signUpController){
            return Column(
              children: [
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        //boxShadow: shadow,
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child:IconButton(
                          onPressed: ()=> Get.back(),
                          icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,),
                        )
                      ),
                    ),
                    Image.asset(Images.logo, width: Dimensions.SIGN_UP_LOGO),
                    SizedBox(width: 75)
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                Text("registration_form".tr,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor),
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    vertical: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  child: GetBuilder<SignUpController>( builder: (controller) {
                    return Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomStepperCircle(isActiveColor:  true, stepNumber: "1"),

                          CustomStepperLine(
                            isActiveColor: signUpController.currentStep==SignUpPageStep.step2 ?
                            true:signUpController.currentStep==SignUpPageStep.step3? true:false,
                          ),

                          CustomStepperCircle(isActiveColor: signUpController.currentStep==SignUpPageStep.step2
                              ?true :signUpController.currentStep==SignUpPageStep.step3?true:false,stepNumber: "2"
                          ),

                          CustomStepperLine(isActiveColor: signUpController.currentStep==SignUpPageStep.step3? true:false),

                          CustomStepperCircle(
                            isActiveColor: signUpController.currentStep==SignUpPageStep.step3?
                            true:false, stepNumber: "3",
                          )
                        ]
                      ),
                    );}
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                        child: Text("step1".tr),
                      ),
                      Text("step2".tr),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                        child: Text("step3".tr),
                      )
                    ]
                  ),
                ),

                signUpController.currentStep == SignUpPageStep.step1?
                SignUpStep1() : signUpController.currentStep == SignUpPageStep.step2?
                SignUpStep2() :
                SignUpStep3(),

                Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(signUpController.currentStep==SignUpPageStep.step1) {
                          signUpController.resetAllValue();
                        }
                        signUpController.updateRegistrationStep(signUpController.currentStep == SignUpPageStep.step3 ? SignUpPageStep.step2
                            : signUpController.currentStep == SignUpPageStep.step2 ? SignUpPageStep.step1 : SignUpPageStep.step1);
                        },
                      child: Container(height: 35, width: 90,
                        decoration:  BoxDecoration(color: Theme.of(context).hintColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),),
                        child: Center(
                          child: Text(signUpController.currentStep==SignUpPageStep.step1?"reset".tr:'back'.tr,
                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall)
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: Dimensions.PADDING_SIZE_LARGE),

                    GestureDetector(
                      onTap: () {
                        if(signUpController.currentStep==SignUpPageStep.step1){
                            validateStep1(signUpController);
                        }else if(signUpController.currentStep==SignUpPageStep.step2){
                            validateStep2(signUpController);
                        } else{
                          validateStep3(signUpController);
                        }
                      },

                      child: signUpController.isLoading! ?
                      Container (width: 90,height: 30,
                        child: Center(
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(color: Theme.of(context).hoverColor),
                          ),
                        ),
                      ) :Container(height: 35, width: 90,
                        decoration:  BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        ),
                        child: Center(child: Text(
                          signUpController.currentStep==SignUpPageStep.step3?"register".tr:'next'.tr,
                          style: ubuntuMedium.copyWith(color: light.cardColor,fontSize: Dimensions.fontSizeSmall),),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              ],
            );
          },
        ),
      ),
    );
  }

  void validateStep1(SignUpController signUpController) async{
    String _companyNumberWithCountryCode = signUpController
        .countryDialCode + signUpController.companyPhoneController.value.text;
    bool _isValidCompanyPhone = GetPlatform.isWeb ? true : false;
    if(!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_companyNumberWithCountryCode);
        _companyNumberWithCountryCode = '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValidCompanyPhone = true;
      } catch (e) {}
    }

    String _contactPersonNumberWithCountryCode = signUpController
        .countryDialCode + signUpController.contactPersonPhoneController.value.text;

    bool _isValidContactPersonPhone = GetPlatform.isWeb ? true : false;
    if(!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_contactPersonNumberWithCountryCode);
        _contactPersonNumberWithCountryCode = '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValidContactPersonPhone = true;
      } catch (e) {}
    }

    if(signUpController.companyNameController.text.isEmpty){
      showCustomSnackBar("company_name_hint".tr);
    }
    else if(signUpController.companyPhoneController.text.isEmpty){
      showCustomSnackBar("enter_company_phone_number".tr);
    }
    else if(!_isValidCompanyPhone){
      showCustomSnackBar("invalid_phone_number".tr);
    }
    else if(signUpController.companyEmailController.text.isEmpty){
      showCustomSnackBar("enter_company_email_address".tr);
    }
    else if(!GetUtils.isEmail(signUpController.companyEmailController.text)){
      showCustomSnackBar("invalid_company_email_address".tr);
    }
    else if(signUpController.companyAddressController.text.isEmpty){
      showCustomSnackBar("enter_address".tr);
    }
    else if(signUpController.profileImageFile==null){
      showCustomSnackBar("provide_image_logo".tr);
    }
    else if(signUpController.contactPersonNameController.text.isEmpty){
      showCustomSnackBar("enter_contact_person_name".tr);
    }
    else if(signUpController.contactPersonPhoneController.text.isEmpty){
      showCustomSnackBar("enter_contact_person_phone_number".tr);
    }
    else if(!_isValidContactPersonPhone){
      showCustomSnackBar("invalid_phone_number".tr);
    }
    else if(signUpController.contactPersonEmailController.text.isEmpty){
      showCustomSnackBar("enter_contact_person_email_address".tr);
    }
    else if(!GetUtils.isEmail(signUpController.contactPersonEmailController.text)){
      showCustomSnackBar("invalid_contact_person_email_address".tr);
    }
    else{
      signUpController.updateRegistrationStep(SignUpPageStep.step2);
    }

  }


  void validateStep2(SignUpController signUpController) {

    if(signUpController.selectedIdentityType==''){
      showCustomSnackBar('select_identity_type'.tr);
    }
    else if(signUpController.identityNumberController.text.isEmpty){
      showCustomSnackBar('enter_identity_number'.tr);
    }
    else if(signUpController.selectedIdentityImageList.length<1){
      showCustomSnackBar("provide_identity_image".tr);
    }
    else if(signUpController.selectedZoneId==''){
      showCustomSnackBar("select_your_zone".tr);
    }
    else if(signUpController.identityImageSize>2){
      showCustomSnackBar("image_size_greater_than".tr);
    }
    else{
      signUpController.updateRegistrationStep(SignUpPageStep.step3);
    }
  }


  void validateStep3(SignUpController signUpController) async {

    String _numberWithCountryCode = signUpController
        .countryDialCode + signUpController.accountPhoneController.value.text;

    bool _isValid = GetPlatform.isWeb ? true : false;
    if(!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode = '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }

    if(signUpController.accountFirstNameController.text.isEmpty){
      showCustomSnackBar("enter_first_name".tr);
    }
    else if(signUpController.accountLastNameController.text.isEmpty){
      showCustomSnackBar("enter_last_name".tr);
    }
    else if(signUpController.accountEmailController.text.isEmpty){
      showCustomSnackBar("enter_email_address".tr);
    }
    else if(!GetUtils.isEmail(signUpController.accountEmailController.text)){
      showCustomSnackBar("enter_valid_email_address".tr);
    }
    else if(signUpController.accountPhoneController.text.isEmpty){
      showCustomSnackBar("enter_phone_number".tr);
    }
    else if(!_isValid){
      showCustomSnackBar("invalid_phone_number".tr);
    }
    else if(signUpController.accountPasswordController.text.isEmpty){
      showCustomSnackBar("enter_password".tr);
    }
    else if(signUpController.accountPasswordController.text.length<8){
      showCustomSnackBar("password_should_be".tr);
    }
    else if(signUpController.accountConfirmPasswordController.text.isEmpty){
      showCustomSnackBar("enter_confirm_password".tr);
    }
    else if(signUpController.accountConfirmPasswordController.text!=signUpController.accountPasswordController.text){
      showCustomSnackBar("confirm_password_does_not_matched".tr);
    }else{
      String _accountNumberWithCountryCode = signUpController
          .countryDialCode + signUpController.accountPhoneController.value.text;

      String _contactNumberWithCountryCode = signUpController
          .countryDialCode + signUpController.contactPersonPhoneController.value.text;

      String _companyNumberWithCountryCode = signUpController
          .countryDialCode + signUpController.companyPhoneController.value.text;

      SignUpBody signUpBody = SignUpBody(
          contactPersonEmail: signUpController.contactPersonEmailController.text,
          contactPersonName: signUpController.contactPersonNameController.text,
          contactPersonPhone: _contactNumberWithCountryCode,
          password: signUpController.accountPasswordController.text,
          confirmedPassword: signUpController.accountConfirmPasswordController.text,
          companyName: signUpController.companyNameController.text,
          companyAddress: signUpController.companyAddressController.text,
          companyEmail: signUpController.companyEmailController.text,
          companyPhone: _companyNumberWithCountryCode,
          accountEmail: signUpController.accountEmailController.text,
          accountFirstName: signUpController.accountFirstNameController.text,
          accountLastName: signUpController.accountLastNameController.text,
          accountPhone: _accountNumberWithCountryCode,
          logo: '',
          identityType: signUpController.selectedIdentityType,
          identityNumber: signUpController.identityNumberController.text,
          identityImage:'',
        zoneId: signUpController.selectedZoneId
      );

      signUpController.registration(signUpBody);
    }

  }
}
