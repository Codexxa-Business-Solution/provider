import 'package:demandium_provider/feature/service_details/view/service/view/services_screen.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class SubCategoryView extends StatelessWidget {

  final List<ServiceSubCategoryModel> subCategoryList;
  const SubCategoryView({Key? key, required this.subCategoryList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return subCategoryList.length == 0 &&  !Get.find<ServiceCategoryController>().isSubCategoryLoading ?
    Center(
      child: Container(
        child: Text("no_sub_category_found".tr,
          style: ubuntuMedium.copyWith(
            fontSize: 16,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
    ) : Get.find<ServiceCategoryController>().isSubCategoryLoading ? CustomShimmer() :

    Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isTab(context)?2:1,
              mainAxisExtent: 150,
            ),
            controller: Get.find<ServiceCategoryController>().scrollController,
            itemCount: subCategoryList.length,
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              int totalService = 0;
              subCategoryList[index].services!.forEach((element) {
                if(element.isActive==1){
                  totalService ++;
                }
              });
              return GetBuilder<ServiceCategoryController>(
                builder: (allServiceController) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(5, 2, 10,8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                    boxShadow: shadow,
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL))),
                    child: Column(
                      children: [

                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width:Dimensions.PADDING_SIZE_DEFAULT),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CustomImage(
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                                image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                    '${AppConstants.CATEGORY_IMAGE_PATH}'
                                    '${subCategoryList[index].image}',
                              ),
                            ),

                           SizedBox(width:Dimensions.PADDING_SIZE_SMALL),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: 140,
                                  child: Text(subCategoryList[index].name.toString(),
                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ),
                                SizedBox(height:Dimensions.PADDING_SIZE_SMALL),
                                Container(width: 140,
                                  child: Text(subCategoryList[index].description.toString(),
                                    textAlign: TextAlign.justify,
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                                      color: Theme.of(context).hintColor),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(flex: 1,
                              child: TextButton(
                                style: TextButton.styleFrom(minimumSize: Size(1, 40),backgroundColor: Colors.transparent),
                                onPressed: () => Get.to(ServicesScreen(
                                    subcategoryModel: allServiceController.serviceSubCategoryList[index],
                                    fromPage: 'subcategory',
                                    serviceList: allServiceController.serviceSubCategoryList[index].services!,
                                    isFromCategory: true, index: index)),
                                child: Text("${'see_details'.tr} (${totalService})",
                                  style: ubuntuRegular.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      decoration: TextDecoration.underline, color: Theme.of(context).primaryColorLight
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: GetBuilder<ServiceCategoryController>(
                                builder: (_allService) {
                                  return _allService.isSubscriptionLoading==true
                                      && allServiceController.selectedSubscriptionIndex == index?
                                  Center(
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(color: Theme.of(context).hoverColor),
                                    ),
                                  ) :
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        backgroundColor: subCategoryList[index].isSubscribed == 1
                                            ? Theme.of(context).colorScheme.tertiary
                                            : Theme.of(context).primaryColor,),
                                      onPressed: ()=>Get.dialog(ConfirmationDialog(
                                          imageBackgroundColor: Get.isDarkMode
                                              ?Theme.of(context).primaryColorLight
                                              :null,
                                          yesButtonColor: subCategoryList[index].isSubscribed == 0
                                              ? Theme.of(context).primaryColor
                                              :Theme.of(context).colorScheme.tertiary,
                                          title: '${'are_you_want_to'.tr} ${subCategoryList[index].isSubscribed == 1
                                              ? 'unsubscribe'.tr.toLowerCase()
                                              :'subscribe'.tr.toLowerCase()} ${'this_subcategory'.tr}',
                                          icon: Images.noService,
                                          description: ''.tr,
                                        onYesPressed: (){
                                           allServiceController.changeSubscriptionIndex(index);
                                           allServiceController.changeSubscriptionStatus(
                                             subCategoryList[index].id.toString(),
                                             index,
                                             true,
                                           );
                                           Get.back();
                                        },
                                        onNoPressed: () => Get.back(),),
                                      ),
                                      child: Text(
                                        subCategoryList[index].isSubscribed == 1 ? "unsubscribe".tr : "subscribe".tr,
                                        style: ubuntuRegular.copyWith(
                                          color: Colors.white,
                                          fontSize:Dimensions.fontSizeSmall,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        Get.find<ServiceCategoryController>().isPaginationLoading?
        CircularProgressIndicator(color: Theme.of(context).hoverColor)
            :SizedBox.shrink()
      ],
   );
  }
}
