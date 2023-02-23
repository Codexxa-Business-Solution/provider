import 'package:get/get.dart';
import 'package:demandium_provider/components/dotted_border.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/auth/model/zone_model.dart';

class SignUpStep2 extends StatefulWidget {
  SignUpStep2({Key? key}) : super(key: key);

  @override
  State<SignUpStep2> createState() => _SignUpStep2State();
}

class _SignUpStep2State extends State<SignUpStep2> {

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
                    Text("business_information".tr,
                      style: ubuntuBold.copyWith(color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                TextFieldTitle(title: "identity_type".tr,requiredMark: true),
                Container(width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      border: Border.all(color: Theme.of(context).disabledColor,width: 1)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5),
                      elevation: 2,
                      hint: Text(signUpController.selectedIdentityType==''?
                        "select_identity_type".tr:signUpController.selectedIdentityType.tr,
                        style: ubuntuRegular.copyWith(
                            color: signUpController.selectedIdentityType==''?
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
                            Text(items.tr,
                              style: ubuntuRegular.copyWith(
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      );
                      }).toList(),
                      onChanged: (String? newValue) => signUpController.setIdentityType(newValue!)
                    ),
                  ),
                ),

                TextFieldTitle(title:"identity_number".tr,requiredMark: true),
                CustomTextFormField(
                  inputType: TextInputType.text,
                  controller: signUpController.identityNumberController,
                  hintText: "enter_identity_number".tr,
                  maxLines: 1,
                  isShowBorder: true,
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                SizedBox(
                  height: 100,
                  width: Get.width,
                  child: Row(
                    children: [
                    signUpController.selectedIdentityImageList.length>0?
                     ListView.builder(
                       itemBuilder: (context,index){
                       return  Padding(
                         padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                         child: Stack(
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                               child: Image.file(
                                 File(signUpController.selectedIdentityImageList[index].file.path),
                                 fit: BoxFit.cover,
                                 height: 120,
                                 width: 160,
                               ),
                             ),
                             Positioned(
                               top: -10,
                               right: -10,
                               child: IconButton(
                                 onPressed: ()=> signUpController.pickIdentityImage(true,index: index),
                                 icon: Icon(Icons.highlight_remove_rounded,color: Colors.red,size: 25),
                               ),
                             ),
                           ],
                         ),
                       );},
                       padding: EdgeInsets.zero,
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       itemCount: signUpController.selectedIdentityImageList.length,
                     ) :SizedBox.shrink(),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                      signUpController.selectedIdentityImageList.length<AppConstants.limitOfPickedIdentityImageNumber?
                      DottedBorderBox(
                        height: 120,
                        width: 120,
                        onTap: ()=> signUpController.pickIdentityImage(false),
                      ):SizedBox.shrink(),
                      signUpController.selectedIdentityImageList.length<1?
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Text("image_validation_text".tr,
                            style: ubuntuRegular.copyWith(fontSize: 12,
                              color: Theme.of(context).hintColor,
                            ),
                            maxLines: 5,
                          ),
                        ),
                      ):SizedBox.shrink(),
                    ],
                  ),
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                TextFieldTitle(title:"select_zone".tr,requiredMark: true),
                Container(width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      border: Border.all(color: Theme.of(context).disabledColor,width: 1),
                  ),

                   child: DropdownButtonHideUnderline(
                     child: DropdownButton(
                        menuMaxHeight: Get.height*.40,
                        dropdownColor: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        elevation: 8,
                        hint: Text(signUpController.selectedZoneName==""?"select_your_zone".tr:signUpController.selectedZoneName,
                          style: ubuntuRegular.copyWith(
                            color: signUpController.selectedZoneName=='1'?
                            Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6):
                            Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                          ),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: signUpController.zoneList.map((ZoneData zoneData) {
                          return DropdownMenuItem(
                            value: zoneData,
                            child: Text(zoneData.name!,
                              style: ubuntuRegular.copyWith(
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (ZoneData? zoneData) {
                          signUpController.setZoneData(zoneData!.name!,zoneData.id!);
                        },
                     ),
                   ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,)
              ],
            );},
          ),
        ),
      ),
    );
  }
}
