import 'package:demandium_provider/feature/serviceman/controller/serviceman_details_controller.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/components/dotted_border.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';
import 'package:demandium_provider/feature/auth/widgets/code_picker_widget.dart';

class ServiceManGeneralInfo extends StatefulWidget {
  final bool isFromEditScreen;
  ServiceManGeneralInfo({Key? key, this.isFromEditScreen= false}) : super(key: key);

  @override
  State<ServiceManGeneralInfo> createState() => _ServiceManGeneralInfoState();
}

class _ServiceManGeneralInfoState extends State<ServiceManGeneralInfo> {
  final FocusNode _firstNameFocus= FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  GetBuilder<ServicemanSetupController>(
        builder: (servicemanSetupController) {
          return  Padding(padding: const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: Get.width),
                    servicemanSetupController.profileImage=='' && servicemanSetupController.pickedProfileImage==null?
                    DottedBorderBox(
                        onTap: ()=> servicemanSetupController.pickProfileImage(false)
                    )

                    :servicemanSetupController.profileImage!='' && servicemanSetupController.pickedProfileImage==null?
                    ClipRRect(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                       child: Stack(
                         alignment: Alignment.topRight,
                         children: [
                           CustomImage(height: 100,width: 100,
                               image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                   '${AppConstants.SERVICEMAN_PROFILE_IMAGE_PATH}${servicemanSetupController.profileImage}'
                           ),

                           Container(
                             width: 35,
                             height: 35,
                             padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                             decoration: BoxDecoration(
                               border: Border.all(color: Theme.of(context).disabledColor),
                               color: Colors.black.withOpacity(0.5),
                               borderRadius: BorderRadius.circular(50)
                             ),
                             child: IconButton(
                                     onPressed: ()=> servicemanSetupController.pickProfileImage(false),
                                     icon: Icon(Icons.edit,color: light.cardColor,size: 17,)),
                           )
                         ],
                       )
                    )

                    : Stack(children: [
                        ClipRRect(borderRadius: BorderRadius.circular(10),
                          child: Image.file(File(servicemanSetupController.pickedProfileImage!.path),
                            fit: BoxFit.cover, height: 100, width: 100)
                        ),

                        Positioned(top: -10, right: -10,
                          child: IconButton(
                            onPressed: ()=> servicemanSetupController.pickProfileImage(true),
                            icon: Icon(Icons.highlight_remove_rounded,color: Colors.red,size: 25,)
                          )
                        )

                    ]),

                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Container(width: 180,
                      child: Text("image_validation_text".tr, textAlign: TextAlign.justify,
                        style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeSmall),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                TextFieldTitle(title:"service_man_name".tr,requiredMark: true,),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                      inputType: TextInputType.text,
                      controller: servicemanSetupController.firstNameController,
                      focusNode: _firstNameFocus,
                      nextFocus: _lastNameFocus,
                      capitalization: TextCapitalization.words,
                      hintText: "serviceman_first_name".tr,
                      isShowBorder: true,
                      maxLines: 1,
                      ),
                    ),

                    SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                    Expanded(
                      child: CustomTextFormField(
                      inputType: TextInputType.text,
                      focusNode: _lastNameFocus,
                      nextFocus: _phoneFocus,
                      controller: servicemanSetupController.lastNameController,
                      hintText: "serviceman_last_name".tr,
                      capitalization: TextCapitalization.words,
                      isShowBorder: true,
                      maxLines: 1,
                      )
                    ),
                  ],
                ),

                TextFieldTitle(title: "serviceman_phone".tr,requiredMark:true),
                Container(
                  child: Row(
                    children: [
                      !widget.isFromEditScreen?
                      CodePickerWidget(
                        onChanged: (CountryCode countryCode) =>
                        servicemanSetupController.countryDialCode = countryCode.dialCode!,
                        initialSelection: servicemanSetupController.countryDialCode,
                        favorite: [servicemanSetupController.countryDialCode!],
                        showDropDownButton: true,
                        padding: EdgeInsets.zero,
                        showFlagMain: true,
                        dialogBackgroundColor: Theme.of(context).cardColor,
                        barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
                        textStyle: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ):SizedBox.shrink(),
                      Expanded(
                        child: CustomTextFormField(
                          hintText: 'serviceman_phone_number'.tr,
                          controller: servicemanSetupController.phoneController,
                          inputType: TextInputType.phone,
                          focusNode: _phoneFocus,
                        ),
                      )
                    ],
                  ),
                ),

                TextFieldTitle(title: "serviceman_identity_type".tr,requiredMark: true),
                Container(width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      border: Border.all(color: Theme.of(context).disabledColor,width: 1)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: Theme.of(context).focusColor,
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      elevation: 2,
                      hint: Text(servicemanSetupController.selectedIdentityType==''?"select_serviceman_identity".tr:
                      servicemanSetupController.selectedIdentityType.tr,
                        style: ubuntuRegular.copyWith(
                            color: servicemanSetupController.selectedIdentityType==''?
                            Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6):
                            Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: AppConstants.identityTypeList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Row(
                            children: [
                              Text(items.tr),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                          servicemanSetupController.setValue(newValue!);
                      },
                    ),
                  ),
                ),

                TextFieldTitle(title: "serviceman_identity".tr,requiredMark:true),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  hintText: "serviceman_identity_number".tr,
                  controller: servicemanSetupController.identityNumberController,
                  isShowBorder: true, maxLines: 1
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                servicemanSetupController.identificationImage.length>0?
                ListView.builder(itemBuilder: (context,index){
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                      child: CustomImage(
                        height: 180,
                        width: Get.width,
                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                            '${AppConstants.SERVICEMAN_IDENTITY_IMAGE_PATH}'
                            '${servicemanSetupController.identificationImage[index]}',
                      ),
                    ),
                  );
                },itemCount: servicemanSetupController.identificationImage.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ):SizedBox.shrink(),

                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return PickedIdentityImage(index: index);
                  },
                  itemCount:servicemanSetupController.selectedIdentityImageList.length,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                servicemanSetupController.selectedIdentityImageList.length<AppConstants.limitOfPickedIdentityImageNumber?
                DottedBorderBox(
                  height: 100,
                  width: Get.width,
                  onTap: () => servicemanSetupController.pickIdentityImage(false),
                ):SizedBox.shrink(),

                SizedBox(height: 20,),
                servicemanSetupController.isLoading && widget.isFromEditScreen?
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     CircularProgressIndicator(color: Theme.of(context).hoverColor),
                   ],
                 )
                : CustomButton(
                  fontSize: Dimensions.fontSizeDefault,
                  btnTxt: !widget.isFromEditScreen?"next_btn".tr:'save'.tr,
                  onPressed:(){
                    _validate(servicemanSetupController);

                  }
                ),
                 SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              ],
            ),
          );
        }
      ),
    );
  }

  void _validate(ServicemanSetupController servicemanSetupController) async {
    String _numberWithCountryCode = servicemanSetupController
        .countryDialCode! + servicemanSetupController.phoneController.value.text;

    bool _isValid = GetPlatform.isWeb ? true : false;
    if(!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode = '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
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
    else if(!widget.isFromEditScreen && !_isValid){
      showCustomSnackBar('invalid_phone_number'.tr);
    }
    else if(servicemanSetupController.selectedIdentityType == ''){
      showCustomSnackBar('select_serviceman_identity_type'.tr);
    }
    else if(servicemanSetupController.identityNumberController.text.isEmpty){
      showCustomSnackBar("enter_serviceman_identity_number".tr);
    }
    else if(servicemanSetupController.selectedIdentityImageList.length<1 && !widget.isFromEditScreen){
      showCustomSnackBar("enter_serviceman_identity_image".tr);
    }
    else{
      if(!widget.isFromEditScreen){
        servicemanSetupController.controller!.index =1;
        servicemanSetupController.updateTabControllerValue(ServicemanTabControllerState.accountIno);
      }else {
        ServicemanBody servicemanBody = ServicemanBody(
          firstName: servicemanSetupController.firstNameController.text,
          lastName: servicemanSetupController.lastNameController.text,
          email: servicemanSetupController.emailController.text,
          phone: servicemanSetupController.phoneController.value.text,
          identityNumber: servicemanSetupController.identityNumberController
              .text,
          identityType: servicemanSetupController.selectedIdentityType,
        );

        String servicemanId;

        if( servicemanSetupController.currentServicemanIndex!=null){
          servicemanId =  servicemanSetupController.servicemanList[servicemanSetupController
              .currentServicemanIndex!].serviceman!.id!;
        }else{
          servicemanId = Get.find<ServicemanDetailsController>().servicemanModel!.id!;
        }
        servicemanSetupController.editServicemanInfoWithoutPassword(
            servicemanBody,
            servicemanId
           );
        }
      }
    }
}

class PickedIdentityImage extends StatelessWidget {
  final int index;
  const PickedIdentityImage({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicemanSetupController>(builder: (servicemanSetupController){
      return Container(
        padding: EdgeInsets.symmetric(vertical: Dimensions.fontSizeExtraSmall),
        child: Stack(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(10),
              child: Image.file(File(servicemanSetupController.selectedIdentityImageList[index].file.path),
                fit: BoxFit.cover, height: 120, width: Get.width,
              ),
            ),

            Positioned(top: -10, right: -10,
              child: IconButton(
                onPressed: ()=> servicemanSetupController.pickIdentityImage(true,index: index),
                icon: Icon(Icons.highlight_remove_rounded,color: Colors.red,size: 25,),
              ),
            ),
          ],
        ),
      );
    });
  }
}



