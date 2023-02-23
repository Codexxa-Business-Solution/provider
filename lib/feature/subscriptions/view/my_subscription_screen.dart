import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(title: "mySubscription".tr,),
      body: GetBuilder<MySubscriptionController>(
        initState: (_){
          Get.find<MySubscriptionController>().getMySubscriptionData(1, false);
        },
        builder: (mySubscriptionController){
          return !mySubscriptionController.isLoading?
          CustomScrollView(
            controller: mySubscriptionController.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 36,
                  width: double.infinity,
                  child: Center(
                    child: RichText(
                      text:  TextSpan(
                        text: 'you_have'.tr,
                        style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: mySubscriptionController.totalSubscription.toString(),
                            style: ubuntuBold.copyWith(color: Theme.of(context).primaryColorLight),
                          ),
                          TextSpan(
                            text: mySubscriptionController.totalSubscription!>1
                                ? 'subscriptions'.tr:'subscription'.tr,
                            style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveHelper.isTab(context)?2:1,
                        mainAxisExtent: 175
                      ),
                      itemBuilder: (context,index){
                        if(mySubscriptionController.subscriptionList[index].subCategory!=null){
                          return SubscriptionItem(subscriptionModelData: mySubscriptionController.subscriptionList[index], index: index);
                        }else{
                          return SizedBox.shrink();
                        }
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: mySubscriptionController.subscriptionList.length,
                    ),
                    mySubscriptionController.isPaginationLoading?
                    CircularProgressIndicator(color: Theme.of(context).hoverColor,):SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ):Center(child: CircularProgressIndicator(color: Theme.of(context).hoverColor,),);
      })
    );
  }
}
