import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';
import 'package:demandium_provider/feature/auth/model/zone_model.dart';

class GeneralInfo extends StatefulWidget {
  const GeneralInfo({Key? key}) : super(key: key);
  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}
class _GeneralInfoState extends State<GeneralInfo> {

  final FocusNode _companyNameFocus= FocusNode();
  final FocusNode _companyPhoneFocus = FocusNode();
  final FocusNode _companyAddressFocus = FocusNode();
  final FocusNode _companyEmailFocus = FocusNode();

  final FocusNode _contactPersonNameFocus= FocusNode();
  final FocusNode _contactPersonPhoneFocus = FocusNode();
  final FocusNode _contactPersonEmailFocus = FocusNode();
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GetBuilder<UserProfileController>(builder: (userProfileController) {
          return Column(
            children: [

              profileImageSection(userProfileController),

              companyOrIndividualInfoSection(userProfileController,context),

              sameAsGeneralInfoSection(context),

              personalInfoSection(userProfileController,context),

              SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),

              userProfileController.isLoading ?
              CircularProgressIndicator(color: Theme.of(context).hoverColor)

              : CustomButton(
                btnTxt: "save".tr,
                onPressed: ()=> _updateProfile(context,userProfileController)

              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            ],
          );
          },
        )
      ),
    );
  }

  Widget profileImageSection(UserProfileController userProfileController) {
    return Container(
      height: 120,
      width: Get.width,
      margin:
          const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Center(
        child: Stack(alignment: AlignmentDirectional.center,
          children: [
            userProfileController.pickedFile==null?
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(''
                  '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                  '${AppConstants.PROVIDER_PROFILE_IMAGE_PATH}'
                  '${userProfileController.providerModel!.content!.providerInfo!.logo}'
              ),
            )

            :CircleAvatar(radius: 50, backgroundImage:FileImage(File(userProfileController.pickedFile!.path))),

            IconButton( onPressed: ()=>userProfileController.pickImage(),
              icon: Icon(Icons.camera_enhance_rounded, color: light.cardColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget companyOrIndividualInfoSection(UserProfileController userProfileController,BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextFieldTitle(title:"company/individual_name".tr,requiredMark: true,),
        CustomTextFormField(
          controller: userProfileController.companyNameController,
          hintText: "company_name_hint".tr,
          maxLines: 1,
          capitalization: TextCapitalization.words,
          inputAction: TextInputAction.next,
          focusNode: _companyNameFocus,
          nextFocus: _companyPhoneFocus,
        ),

        TextFieldTitle(title:"phone_number".tr,requiredMark: true,),

        CustomTextFormField(
          hintText: 'enter_company_phone_number'.tr,
          controller: userProfileController.companyPhoneController,
          inputType: TextInputType.phone,
          inputAction: TextInputAction.next,
          focusNode: _companyPhoneFocus,
          nextFocus: _companyAddressFocus,
        ),
        
        TextFieldTitle(title:"email".tr,requiredMark: true,),
        CustomTextFormField(
          inputType: TextInputType.text,
          controller: userProfileController.companyEmailController,
          hintText:'enter_company_email_address'.tr,
          focusNode: _companyEmailFocus,
          nextFocus: _companyAddressFocus,
        ),


        TextFieldTitle(title: "address".tr,requiredMark: true),
        CustomTextFormField(
          controller: userProfileController.companyAddressController,
          hintText: "address_hint".tr,
          maxLines: 3,
          capitalization: TextCapitalization.sentences,
          inputAction: TextInputAction.next,
          focusNode: _companyAddressFocus,
        ),


        TextFieldTitle(title:"select_zone".tr,requiredMark: true),
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
              border: Border.all(color: Theme.of(context).disabledColor,width: 1)),
          child: DropdownButtonHideUnderline(

            child: DropdownButton(

              menuMaxHeight: Get.height*.40,
              dropdownColor: Theme.of(context).focusColor,
              borderRadius: BorderRadius.circular(5),
              elevation: 8,
              hint: Text(
                userProfileController.selectedZoneName==""? userProfileController.myZone:userProfileController.selectedZoneName,
                style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)),
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: userProfileController.zoneList.map((ZoneData zoneData) {
                return DropdownMenuItem(
                  value: zoneData,
                  child: Text(zoneData.name!,
                      style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6))
                  ),
                );
              }).toList(),
              onChanged: (ZoneData? zoneData) {
                userProfileController.setNewZoneValue(zoneData!.name!,zoneData.id!);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget personalInfoSection(UserProfileController userProfileController,BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextFieldTitle(title: "contact_person_name".tr,requiredMark: true,),
        CustomTextFormField(
          controller: userProfileController.personalNameController,
          hintText: "enter_contact_person_name".tr,
          maxLines: 1,
          capitalization: TextCapitalization.words,
          inputAction: TextInputAction.next,
          focusNode: _contactPersonNameFocus,
          nextFocus: _contactPersonPhoneFocus,
        ),

        TextFieldTitle(title: "contact_person_phone".tr,requiredMark: true,),

        CustomTextFormField(
          hintText: 'enter_contact_person_phone_number'.tr,
          controller: userProfileController.personalPhoneController,
          inputType: TextInputType.phone,
          inputAction: TextInputAction.next,
          focusNode: _contactPersonPhoneFocus,
          nextFocus: _contactPersonEmailFocus,
        ),


        TextFieldTitle(title: "contact_person_email".tr,requiredMark: true,),
        CustomTextFormField(
          controller: userProfileController.personalEmailController,
          hintText: "enter_contact_person_email_address".tr,
          maxLines: 1,
          focusNode: _contactPersonEmailFocus,
          inputAction: TextInputAction.done,
        ),
    ]);
  }

  Widget sameAsGeneralInfoSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT,bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: GetBuilder<UserProfileController>(builder: (userProfileController){
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("contact_personal_information".tr,
                  style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color)
                ),
              ],
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: ()=> userProfileController.togglePersonalInfoAsCompanyInfo(),
                  child: Container(height: 20, width: 20,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Theme.of(context).primaryColor, width: 1.2),
                    ),
                    child:  Center(
                      child: userProfileController.keepPersonalInfoAsCompanyInfo ?
                      Icon(Icons.check, color: Theme.of(context).primaryColor,size: Dimensions.fontSizeLarge,) :
                      SizedBox(),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                Text("same_as_general_info".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColor),),
              ],
            ),
          ],
        );
      }),
    );
  }

  _updateProfile(BuildContext context, UserProfileController userProfileController) {
    if(userProfileController.companyNameController!.text.isEmpty){
      showCustomSnackBar('company_name_hint'.tr);
    }
    else if(userProfileController.companyAddressController!.text.isEmpty){
      showCustomSnackBar("enter_address".tr);
    }
    else if(userProfileController.companyPhoneController!.text.isEmpty){
      showCustomSnackBar("enter_company_phone_number".tr);
    }
    else if(!userProfileController.companyPhoneController!.text.contains('+')){
      showCustomSnackBar("country_code_required".tr);
    }
    else if(userProfileController.personalNameController!.text.isEmpty){
      showCustomSnackBar("enter_contact_person_name".tr);
    }
    else if(userProfileController.personalPhoneController!.text.isEmpty){
      showCustomSnackBar("enter_contact_person_phone_number".tr);
    }
    else if(!userProfileController.personalPhoneController!.text.contains('+')){
      showCustomSnackBar("country_code_required".tr);
    }
    else if(userProfileController.personalEmailController!.text.isEmpty){
      showCustomSnackBar("enter_contact_person_email_address".tr);
    }
    else{
      userProfileController.updateProfile().then((status){

        if(status.isSuccess!){
          Get.find<AuthController>().updateToken();
          Get.find<MySubscriptionController>().getMySubscriptionData(1,false);
          showCustomSnackBar("profile_updated_successfully".tr,isError: false);
        }
        else{showCustomSnackBar(status.message);}
      });
    }
  }
}
