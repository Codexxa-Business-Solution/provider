import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/auth/widgets/code_picker_widget.dart';

class SignUpStep3 extends StatefulWidget {
  SignUpStep3({Key? key}) : super(key: key);
  @override
  State<SignUpStep3> createState() => _SignUpStep3State();
}

class _SignUpStep3State extends State<SignUpStep3> {
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: GetBuilder<SignUpController>(builder: (signUpController) {

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("account_information".tr,
                      style: ubuntuBold.copyWith(color: Theme.of(context).secondaryHeaderColor)
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                TextFieldTitle(title:"account_name".tr,requiredMark: true),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: signUpController.accountFirstNameController,
                        hintText: "first_name".tr,
                        isShowBorder: true,
                        capitalization: TextCapitalization.words,
                      ),
                    ),

                    SizedBox(width: 20),

                    Expanded(
                      child: CustomTextFormField(
                        controller: signUpController.accountLastNameController,
                        capitalization: TextCapitalization.words,
                        hintText: "last_name".tr,
                        nextFocus: _emailFocus,
                        isShowBorder: true,
                      ),
                    ),
                  ],
                ),

                TextFieldTitle(title:"email".tr,requiredMark: true,),
                CustomTextFormField(
                  inputType: TextInputType.emailAddress,
                  controller: signUpController.accountEmailController,
                  hintText: "enter_email".tr,
                  nextFocus: _phoneFocus,
                  focusNode: _emailFocus,
                ),

                TextFieldTitle(title: "phone_number".tr,requiredMark: true),
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
                          hintText: 'phone_humber_hint'.tr,
                          controller: signUpController.accountPhoneController,
                          focusNode: _phoneFocus,
                          nextFocus: _passwordFocus,
                          inputType: TextInputType.phone,
                        ),
                      )
                    ],
                  ),
                ),

                TextFieldTitle(title: "password".tr,requiredMark: true),
                CustomTextFormField(
                  isShowSuffixIcon: true,
                  inputType: TextInputType.visiblePassword,
                  focusNode: _passwordFocus,
                  nextFocus: _confirmPasswordFocus,
                  inputAction: TextInputAction.next,
                  controller: signUpController.accountPasswordController,
                  hintText: "********",
                  isPassword: true,
                ),

                TextFieldTitle(title:"confirm_password".tr,requiredMark: true),
                CustomTextFormField(
                  isShowSuffixIcon: true,
                  focusNode: _confirmPasswordFocus,
                  inputType: TextInputType.visiblePassword,
                  controller: signUpController.accountConfirmPasswordController,
                  inputAction: TextInputAction.done,
                  hintText: "********",
                  isPassword: true,
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,)
              ],
            );
            },
          ),
        ),
      ),
    );
  }
}