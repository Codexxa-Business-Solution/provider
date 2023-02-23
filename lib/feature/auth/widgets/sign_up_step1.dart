import 'package:get/get.dart';
import 'package:demandium_provider/components/dotted_border.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/auth/widgets/code_picker_widget.dart';

class SignUpStep1 extends StatefulWidget {
  const SignUpStep1({Key? key}) : super(key: key);

  @override
  State<SignUpStep1> createState() => _SignUpStep1State();
}

class _SignUpStep1State extends State<SignUpStep1> {
  final FocusNode _companyNameFocus= FocusNode();
  final FocusNode _companyPhoneFocus = FocusNode();
  final FocusNode _companyEmailFocus = FocusNode();
  final FocusNode _companyAddressFocus = FocusNode();

  final FocusNode _contactPersonNameFocus= FocusNode();
  final FocusNode _contactPersonPhoneFocus = FocusNode();
  final FocusNode _contactPersonEmailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: GetBuilder<SignUpController>(builder: (signUpController) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("general_information".tr,
                        style: ubuntuBold.copyWith(color: Theme.of(context).secondaryHeaderColor)
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                TextFieldTitle(title:"company/individual_name".tr,requiredMark: true),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  controller: signUpController.companyNameController,
                  hintText: "company_name_hint".tr,
                  focusNode: _companyNameFocus,
                  nextFocus: _companyPhoneFocus,
                  capitalization: TextCapitalization.words,
                ),

                TextFieldTitle(title:"phone_number".tr,requiredMark: true),
                Container(
                  child: Row(
                    children: [
                      CodePickerWidget(
                        onChanged: (CountryCode countryCode) =>
                        signUpController.countryDialCode = countryCode.dialCode!,
                        initialSelection: signUpController.countryDialCode,
                        favorite: ['+91','IN'],
                        //favorite: [signUpController.countryDialCode],
                       // countryFilter: [_countryDialCode],
                        showDropDownButton: true,
                        enabled: false,
                        padding: EdgeInsets.zero,
                        showFlagMain: true,
                        dialogBackgroundColor: Theme.of(context).cardColor,
                        barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
                        textStyle: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                      Expanded(
                        child: CustomTextFormField(
                          hintText: 'enter_company_phone_number'.tr,
                          controller: signUpController.companyPhoneController,
                          inputType: TextInputType.phone,
                          focusNode: _companyPhoneFocus,
                          nextFocus: _companyEmailFocus,
                        ),
                      )
                    ],
                  ),
                ),

                TextFieldTitle(title:"email".tr,requiredMark: true,),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  controller: signUpController.companyEmailController,
                  hintText:'enter_company_email_address'.tr,
                  focusNode: _companyEmailFocus,
                  nextFocus: _companyAddressFocus,
                ),

                TextFieldTitle(title:"address".tr,requiredMark: true),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  controller: signUpController.companyAddressController,
                  hintText: "address_hint".tr,
                  focusNode: _companyAddressFocus,
                  capitalization: TextCapitalization.sentences,
                  inputAction: TextInputAction.done,
                  maxLines: 3,
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text("image_validation_text".tr,
                          style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).hintColor,
                          ),
                          maxLines: 5,
                        ),
                      ),
                      signUpController.profileImageFile!=null ?
                      Stack(
                        children: [
                          ClipRRect(borderRadius: BorderRadius.circular(10),
                            child: Image.file(File(signUpController.profileImageFile!.path),
                              fit: BoxFit.cover, height: 100, width: 100
                            ),
                          ),

                          Positioned(top: -10, right: -10,
                            child: IconButton(onPressed: ()=>signUpController.pickProfileImage(true),
                              icon: Icon(Icons.highlight_remove_rounded,color: Colors.red,size: 25)
                            )
                          ),
                        ],
                      ) : DottedBorderBox(
                        height: 100,
                        width: 100,
                        onTap: ()=> signUpController.pickProfileImage(false),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "contact_person_info_title".tr,
                      style: ubuntuBold.copyWith(color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: ()=> signUpController.togglePersonalInfoAsCompanyInfo(),
                      child: Container(height: 20, width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Theme.of(context).primaryColor, width: 1.2),
                        ),

                        child: Center(
                            child: signUpController.keepPersonalInfoAsCompanyInfo ?
                            Icon(Icons.check, color: Theme.of(context).primaryColor, size: Dimensions.fontSizeLarge,)
                                :SizedBox()
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Text("same_as_general_info".tr,
                        style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge)
                    ),

                  ],
                ),

                TextFieldTitle(title: "contact_person_name".tr,requiredMark: true),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  controller: signUpController.contactPersonNameController,
                  hintText: "enter_contact_person_name".tr,
                  capitalization: TextCapitalization.words,
                  focusNode: _contactPersonNameFocus,
                  nextFocus: _contactPersonPhoneFocus,

                ),

                TextFieldTitle(title:"contact_person_phone".tr,requiredMark: true),
                Container(
                  child: Row(
                    children: [
                      CodePickerWidget(
                        onChanged: (CountryCode countryCode) =>
                        signUpController.countryDialCode = countryCode.dialCode!,
                        initialSelection: signUpController.countryDialCode,
                        favorite: [signUpController.countryDialCode],
                        showDropDownButton: true,
                        padding: EdgeInsets.zero,
                        showFlagMain: true,
                        dialogBackgroundColor: Theme.of(context).cardColor,
                        barrierColor: Get.isDarkMode?Colors.black.withOpacity(0.4):null,
                        textStyle: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                      Expanded(
                        child: CustomTextFormField(
                          hintText: 'enter_contact_person_phone_number'.tr,
                          controller: signUpController.contactPersonPhoneController,
                          inputType: TextInputType.phone,
                          focusNode: _contactPersonPhoneFocus,
                          nextFocus: _contactPersonEmailFocus,
                        ),
                      )
                    ],
                  ),
                ),

                TextFieldTitle(title:"contact_person_email".tr,requiredMark: true),
                CustomTextFormField(
                  inputType: TextInputType.emailAddress,
                  controller: signUpController.contactPersonEmailController,
                  hintText: "enter_contact_person_email_address".tr,
                  focusNode: _contactPersonEmailFocus,
                  inputAction: TextInputAction.done,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE)
              ],
            );
          }),
        ),
      ),
    );
  }
}
