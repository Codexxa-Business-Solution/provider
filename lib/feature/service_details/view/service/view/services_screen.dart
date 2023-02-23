import 'package:demandium_provider/feature/service_details/view/service/widgets/service_item.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';


class ServicesScreen extends StatelessWidget {
   final int index;
   final ServiceSubCategoryModel? subcategoryModel;
   final SubscriptionModelData? subscriptionModelData;
   final List<Service> serviceList;
   final String fromPage;
   final bool isFromCategory;
   ServicesScreen({
     Key? key,this.subcategoryModel,
     this.subscriptionModelData,
     required this.isFromCategory,
     required this.index,
     required this.serviceList,
     required this.fromPage,
     r
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Service> activeServiceList =[];
      serviceList.forEach((element) {
        if(element.isActive==1){
          activeServiceList.add(element);
        }
      });
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: "services".tr,),
      body: serviceList.length>0 ?
      GetBuilder<ServiceCategoryController>(
        builder: (allServiceController){
          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                children: [
                  Stack(children: [
                    Container(width: Get.width,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: activeServiceList.length.toString(),
                                  style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColor)),
                              TextSpan(text: 'services_available'.tr, style: ubuntuRegular),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],),

                  Expanded(
                    child: GridView.builder(
                      padding:EdgeInsets.zero,
                      itemCount: activeServiceList.length,
                      itemBuilder: (context,index)=> ServiceItem(service: activeServiceList[index]),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1,
                        crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 :
                        ResponsiveHelper.isTab(context) ? 4 : 2,
                      ),
                      physics: BouncingScrollPhysics(),

                    ),
                  ),

                  allServiceController.isSubscriptionLoading && isFromCategory?
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(height: 30,width: 30,
                          child: CircularProgressIndicator(color: Theme.of(context).hoverColor)
                      ),
                    ),
                  ) : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    height: 60,
                    width: Get.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        backgroundColor: isFromCategory ?
                        subcategoryModel!.isSubscribed==1 ? Colors.orangeAccent.shade400
                            : Theme.of(context).primaryColor :
                        subscriptionModelData!.isSubscribed==1 ? Colors.orangeAccent.shade400
                            : Theme.of(context).primaryColor,
                      ),

                      onPressed: ()=>Get.dialog(
                          ConfirmationDialog(
                              imageBackgroundColor: Get.isDarkMode?Theme.of(context).primaryColorLight:null,
                              yesButtonColor:  isFromCategory  &&  subcategoryModel!.isSubscribed==0?
                              Theme.of(context).primaryColor:Theme.of(context).colorScheme.tertiary,
                              title:
                              isFromCategory ? '${'are_you_want_to'.tr} ${subcategoryModel!.isSubscribed== 1?
                              'unsubscribe'.tr.toLowerCase():'subscribe'.tr.toLowerCase()} ${'this_subcategory'.tr}'
                                  :'${'are_you_want_to'.tr} ${subscriptionModelData!.isSubscribed== 1?
                              'unsubscribe'.tr.toLowerCase():'subscribe'.tr.toLowerCase()} ${'this_subcategory'.tr}',
                              icon: Images.noService,
                              description: ''.tr,
                              onYesPressed: (){
                                isFromCategory ?
                                allServiceController.changeSubscriptionStatus(subcategoryModel!.id!, index,true) :
                                allServiceController.changeSubscriptionStatus(
                                    subscriptionModelData!.subCategory!.id!,
                                    index, false
                                );
                                Get.back();
                              },
                              onNoPressed: () {
                                Get.back();
                              }
                          )
                      ),
                      child: Text(
                        isFromCategory ?
                        subcategoryModel!.isSubscribed==0 ? "subscribe_to_this_subcategory".tr
                            : "unsubscribe_to_this_subcategory".tr :
                        subscriptionModelData!.isSubscribed==0 ? "subscribe_to_this_subcategory".tr
                            :"unsubscribe_to_this_subcategory".tr,
                        style: ubuntuRegular.copyWith(
                            fontSize:Dimensions.fontSizeDefault,
                            color:light.cardColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
          :NoDataScreen(
          text: 'no_service_available'.tr,
        type: NoDataType.SERVICE,
      ),
    );
  }
}
