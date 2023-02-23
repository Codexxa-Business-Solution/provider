import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/helper/help_me.dart';

class AllServicesScreen extends StatelessWidget {
  AllServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MainAppBar(title: 'available_services',color:  Theme.of(context).primaryColor,),

      body: GetBuilder<ServiceCategoryController>(
        initState: (State) {
          Get.find<ServiceCategoryController>().getCategoryList();
          Get.find<ServiceCategoryController>().changeCategory(0);
        },
          builder: (allServiceController) {
        return  CustomScrollView(slivers: [

          SliverToBoxAdapter(
            child: allServiceController.isLoading && allServiceController.serviceCategoryList.length==0?
            CustomShimmer() : allServiceController.serviceCategoryList.length==0?

            SizedBox(height: Get.height*.8,
              child: Center(
                child: NoDataScreen(text: "no_available_service".tr,type: NoDataType.SERVICE),
              ),

            ): Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                  child: Text("categories".tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height - 180,
                      width: ResponsiveHelper.isTab(context)
                          ?MediaQuery.of(context).size.width/7
                          :MediaQuery.of(context).size.width/3.6,
                      child: ListView.builder(
                        itemCount:allServiceController.serviceCategoryList.length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            child: CategoryItem(
                              image: allServiceController.serviceCategoryList[index].image.toString(),
                              title: allServiceController.serviceCategoryList[index].name.toString(),
                              selectedCategory:  allServiceController.serviceCategoryList[allServiceController
                                  .selectedCategory].name.toString(),
                            ),
                            onTap: (){
                              if(isRedundentClick(DateTime.now())){
                                return;
                              }
                              allServiceController.changeCategory(index);
                              allServiceController.getSubCategoryList(offset: 1, isFromPagination: false);
                            },
                          );
                        },
                      ),
                    ),

                     Container(
                       height: Get.height - 180,
                       width: ResponsiveHelper.isTab(context)
                           ?MediaQuery.of(context).size.width/1.18
                           :MediaQuery.of(context).size.width/1.4,
                       child: SubCategoryView(subCategoryList: allServiceController.serviceSubCategoryList),
                     )
                  ],
                ),
              ],
            ),
          )
        ],
        );},
      ),
    );
  }
}
