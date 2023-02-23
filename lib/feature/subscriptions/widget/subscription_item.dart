import 'package:demandium_provider/feature/service_details/view/service/view/services_screen.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class SubscriptionItem extends StatelessWidget {
   final int index;
   final SubscriptionModelData subscriptionModelData;
   SubscriptionItem({Key? key,required this.subscriptionModelData, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int _totalNumberOfServices = 0;
    if(subscriptionModelData.subCategory!=null){
      subscriptionModelData.subCategory!.services!.forEach((element) {
        if(element.isActive==1){
          _totalNumberOfServices++;
        }
      });
    }


    return Container(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).cardColor),
            color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
          boxShadow: shadow
        ),
      child: Column(
        children: [
          SizedBox(height:Dimensions.PADDING_SIZE_DEFAULT),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomImage(
                    image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}${AppConstants
                        .CATEGORY_IMAGE_PATH}${subscriptionModelData.subCategory!=null?
                    subscriptionModelData.subCategory!.image:""}",
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
              subscriptionModelData.subCategory != null ?
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(subscriptionModelData.subCategory!.name??"",
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                    ),
                    SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container(child: Text(subscriptionModelData.subCategory!.description??"",
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ],
                ),
              )
              :SizedBox(),
              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,)
            ]
          ),
          Divider(),
          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,backgroundColor: Colors.transparent
                ),
                onPressed: () => Get.to(ServicesScreen(
                    serviceList: subscriptionModelData.subCategory!.services!,
                    subscriptionModelData: subscriptionModelData,
                    fromPage: 'mySubscription',
                    isFromCategory: false,index: index),
                ),
                child: subscriptionModelData.subCategory!=null?Text(
                  "${'see_services'.tr} (${_totalNumberOfServices})",
                  style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).primaryColorLight,
                    decoration: TextDecoration.underline,
                  ),
                ):SizedBox(),
              ),

              Expanded(flex: 1, child: SizedBox()),

               GetBuilder<MySubscriptionController>(builder: (mySubscriptionController){
                 return  mySubscriptionController.isSubscribeButtonLoading
                     && mySubscriptionController.selectedSubscriptionIndex==index ?
                 SizedBox(
                   height: 25,
                   width:100,
                   child: Center(
                     child: SizedBox(
                       height: 25,
                       width: 25,
                       child: CircularProgressIndicator(color: Theme.of(context).hoverColor)
                     )
                   ),
                 )
                 :CustomButton(
                   height: 30,
                   width: 100,
                   fontSize: Dimensions.fontSizeSmall,
                   color:  Theme.of(context).colorScheme.tertiary,
                   btnTxt: 'unsubscribe'.tr,

                   onPressed: ()=>Get.dialog(ConfirmationDialog(
                     imageBackgroundColor: Get.isDarkMode?Theme.of(context).primaryColorLight:null,
                     yesButtonColor: Theme.of(context).colorScheme.tertiary,
                     title: '${'are_you_want_to'.tr} ${'unsubscribe'.tr.toLowerCase()} ${'this_subcategory'.tr}',
                     icon: Images.noService,
                     description: ''.tr,
                     onYesPressed: (){
                       mySubscriptionController.changeSubscriptionIndex(index);
                       Get.find<MySubscriptionController>().unsubscribeCategory(subscriptionModelData.subCategoryId!,index);
                       Get.back();
                     },
                       onNoPressed: ()=> Get.back()
                     )
                   ),
                 );
                 },
               )
              ],
            ),
          ),
          SizedBox(height:Dimensions.PADDING_SIZE_SMALL),
        ],
      ),
    );
  }
}
