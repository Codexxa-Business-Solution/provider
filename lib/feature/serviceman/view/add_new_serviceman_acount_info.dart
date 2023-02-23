import 'package:demandium_provider/feature/serviceman/controller/serviceman_details_controller.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ServicemanAccountInfo extends StatefulWidget {
  final bool isFromEditScreen;
  const ServicemanAccountInfo({Key? key,this.isFromEditScreen= false}) : super(key: key);

  @override
  State<ServicemanAccountInfo> createState() => _ServicemanAccountInfoState();
}
class _ServicemanAccountInfoState extends State<ServicemanAccountInfo> {
  final FocusNode _emailFocus= FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicemanSetupController>(
      builder: (servicemanSetupController){
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldTitle(title:"email".tr,requiredMark: true,),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  hintText: "serviceman_email_address".tr,
                  focusNode: _emailFocus,
                  nextFocus: _passwordFocus,
                  maxLines: 1,
                  controller: servicemanSetupController.emailController,
                ),

                TextFieldTitle(title: "password".tr,requiredMark: true,),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  hintText: "********",
                  focusNode: _passwordFocus,
                  nextFocus: _confirmPasswordFocus,
                  maxLines: 1,
                  isPassword: true,
                  isShowSuffixIcon: true,
                  controller: servicemanSetupController.passController,
                ),

                TextFieldTitle(title: "confirm_password".tr,requiredMark: true,),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  hintText: "********",
                  focusNode: _confirmPasswordFocus,
                  maxLines: 1,
                  isPassword: true,
                  isShowSuffixIcon: true,
                  controller: servicemanSetupController.confirmPasswordController,
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                servicemanSetupController.isLoading ?
                Center(child: CircularProgressIndicator(color: Theme.of(context).hoverColor))
                :CustomButton(
                  btnTxt: "save".tr,
                  onPressed:() =>  saveServicemanData(servicemanSetupController),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void saveServicemanData(ServicemanSetupController servicemanSetupController) async {

    String _numberWithCountryCode;
    bool _isValid = GetPlatform.isWeb ? true : false;
    if(!widget.isFromEditScreen){
      _numberWithCountryCode = servicemanSetupController
          .countryDialCode! + servicemanSetupController.phoneController.value.text;

      if(!GetPlatform.isWeb) {
        try {
          PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_numberWithCountryCode);
          _numberWithCountryCode = '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
          _isValid = true;
        } catch (e) {}
      }
    }else{
      _numberWithCountryCode = servicemanSetupController.phoneController.value.text;
    }

    if(servicemanSetupController.pickedProfileImage==null && servicemanSetupController.profileImage==''){
      showCustomSnackBar("enter_serviceman_profile_image".tr);
    }
    else if(servicemanSetupController.firstNameController.text.isEmpty){
      showCustomSnackBar("serviceman_first_name".tr);
    }
    else if(servicemanSetupController.lastNameController.text.isEmpty){
      showCustomSnackBar("serviceman_last_name".tr);
    }
    else if(servicemanSetupController.phoneController.text.isEmpty){
      showCustomSnackBar("serviceman_phone_number".tr);
    }
    else if(widget.isFromEditScreen && !servicemanSetupController.phoneController.text.contains('+')){
      showCustomSnackBar("country_code_required".tr);
    }
    else if(!widget.isFromEditScreen && ! _isValid){
      showCustomSnackBar('invalid_phone_number'.tr);
    }
    else if(servicemanSetupController.identityNumberController.text.isEmpty){
      showCustomSnackBar("enter_serviceman_identity_number".tr);
    }
    else if(servicemanSetupController.selectedIdentityImageList.length<1
        && servicemanSetupController.identificationImage=='')
    {
      showCustomSnackBar("enter_serviceman_identity_image".tr);
    }
    else if(servicemanSetupController.emailController.text.isEmpty){
      showCustomSnackBar("serviceman_email_address".tr);
    }
    else if(!GetUtils.isEmail(servicemanSetupController.emailController.text)){
      showCustomSnackBar("invalid_serviceman_email".tr);
    }
    else if(servicemanSetupController.passController.text.isEmpty){
      showCustomSnackBar("enter_serviceman_password".tr);
    }
    else if(servicemanSetupController.passController.text.length<8){
      showCustomSnackBar("password_should_be".tr);
    }
    else if(servicemanSetupController.confirmPasswordController.text.isEmpty){
      showCustomSnackBar("enter_serviceman_confirm_password".tr);
    }
    else if(servicemanSetupController.passController.text.length<8){
      showCustomSnackBar("confirm_password_should_be".tr);
    }
    else if(servicemanSetupController.passController.text!=servicemanSetupController.confirmPasswordController.text){
      showCustomSnackBar("confirm_password_does_not_matched".tr);
    }
    else{
        ServicemanBody servicemanBody = ServicemanBody(
          firstName: servicemanSetupController.firstNameController.text,
          lastName: servicemanSetupController.lastNameController.text,
          email: servicemanSetupController.emailController.text,
          phone: _numberWithCountryCode,
          password: servicemanSetupController.passController.text,
          confirmedPassword: servicemanSetupController.confirmPasswordController.text,
          identityNumber: servicemanSetupController.identityNumberController.text,
          identityType: servicemanSetupController.selectedIdentityType,
        );

        String servicemanId;

        if(widget.isFromEditScreen){
          if( servicemanSetupController.currentServicemanIndex!=null){
            servicemanId =  servicemanSetupController.servicemanList[servicemanSetupController
                .currentServicemanIndex!].serviceman!.id!;
          }else{
            servicemanId = Get.find<ServicemanDetailsController>().servicemanModel!.id!;
          }
          servicemanSetupController.editServicemanInfoWithPassword( servicemanBody,
              servicemanId);
        }
        else{
          servicemanSetupController.addNewServiceman(servicemanBody);
        }
      }
    }
}
