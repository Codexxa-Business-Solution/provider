import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class SettingBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    List<Widget> settingsItems = [

      Container(
        decoration: BoxDecoration(
            color: Get.isDarkMode?Colors.grey.withOpacity(0.2): Theme.of(context).cardColor,
            boxShadow:Get.isDarkMode ? null: shadow,
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))
        ),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<AuthController>(builder: (authController){
                return CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor,
                    value: authController.isNotificationActive(), onChanged: (value){
                  authController.toggleNotificationSound();
                });
              }),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              Text(
                'notification_sound'.tr,
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                textAlign: TextAlign.center,

              ),
            ],
          ),
        ),),
      InkWell(
        onTap: (){
          Get.back();
          Get.bottomSheet(ChooseLanguageBottomSheet(), backgroundColor: Colors.transparent, isScrollControlled: true);
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Get.isDarkMode?Colors.grey.withOpacity(0.2): Theme.of(context).cardColor,
                  boxShadow:Get.isDarkMode ? null: shadow,
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Images.translate,width: 40,height: 40,),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                    Text('language'.tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),
                  ],
                ),
              ),),
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Image.asset(Images.editPen,
                width: 20,
                height:20,
              ),
            ),
          ],
        ),
      ),
    ];

    return PointerInterceptor(
      child:Container(
        width: Dimensions.WEB_MAX_WIDTH,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Get.isDarkMode?Theme.of(context).cardColor:Theme.of(context).backgroundColor,
        ),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            InkWell(
              onTap: () => Get.back(),
              child: Icon(Icons.keyboard_arrow_down_rounded, size: 30),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_LARGE*2),



                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTab(context) ? 4 : 2,
                    childAspectRatio: (1/1),
                    crossAxisSpacing: 10
                  ),
                  itemCount: settingsItems.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return settingsItems.elementAt(index);
                  },
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE*3),
              ],
            ),

            SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.PADDING_SIZE_SMALL : 0),
          ]),
        ),
      )
    );
  }
}
