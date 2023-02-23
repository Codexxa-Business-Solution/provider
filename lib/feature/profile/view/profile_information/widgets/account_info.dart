import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<UserProfileController>(builder: (userProfileController){
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldTitle(title: "email".tr),

              NonEditableTextField(text: userProfileController.providerModel!.content!.providerInfo!.owner!.email??"",),

              TextFieldTitle(title: "phone_number".tr),

              NonEditableTextField(text: userProfileController.providerModel!.content!.providerInfo!.owner!.phone??"",),

              TextFieldTitle(title: "password".tr,requiredMark: true,),
               CustomTextFormField(
                 isShowSuffixIcon: true,
                 controller: userProfileController.passwordController,
                 hintText: "******",
                 isPassword: true,
                 focusNode: _passwordFocus,
                 nextFocus: _confirmPasswordFocus,
               ),

              TextFieldTitle(title:"confirm_password".tr,requiredMark: true,),
              CustomTextFormField(
                isShowSuffixIcon: true,
                controller: userProfileController.confirmPasswordController,
                hintText: "******",
                isPassword: true,
                focusNode: _confirmPasswordFocus,
                inputAction: TextInputAction.done,
              ),

              SizedBox(height: 20,),
              userProfileController.isLoading ?
              Center(child: CircularProgressIndicator(color: Theme.of(context).hoverColor)) :
              CustomButton(
                btnTxt: "save".tr,
                onPressed: (){
                  if(userProfileController.passwordController!.text.length<1){
                    showCustomSnackBar("enter_password".tr);
                  }else if(userProfileController.passwordController!.text.length<8){
                    showCustomSnackBar("password_should_be".tr);
                  }
                  else if(userProfileController.confirmPasswordController!.text.isEmpty){
                    showCustomSnackBar("enter_confirm_password".tr);
                  }
                  else if(userProfileController.confirmPasswordController!.text !=userProfileController.passwordController!.text){
                    showCustomSnackBar("confirm_password_does_not_matched".tr);
                  }else{
                    userProfileController.updateProfileWithPassword().then((status){
                      if(status.isSuccess!){
                        showCustomSnackBar("password_updated_successfully".tr,isError: false);
                      } else{
                        showCustomSnackBar(status.message);
                      }
                    });
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
