import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class MySubscriptionSection extends StatelessWidget {
  const MySubscriptionSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (dashboardController){
        return dashboardController.dashboardSubscriptionList.length==0 ?
        SizedBox() :
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT+3,
                vertical: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      Image.asset(Images.dashboardProfile,height: 15,width:15),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                      Text("mySubscription".tr,
                        style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: ()=> Get.toNamed(RouteHelper.mySubscription),
                    child: Text("view_all".tr,
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.tertiary
                      ),
                    ),
                 ),
               ],
             ),
            ),

            Container(
              height: 120,
              color: Theme.of(context).cardColor.withOpacity(0.2),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 100,
                child: ListView.builder(scrollDirection: Axis.horizontal,
                    itemBuilder:(context, index) {
                  if(dashboardController.dashboardSubscriptionList[index].subCategory!=null){
                    return SubscriptionCardItem(subscriptionModelData: dashboardController.dashboardSubscriptionList[index]);
                  }else{
                    return SizedBox();
                  }
                   },
                    itemCount: dashboardController.dashboardSubscriptionList.length
                ),
              ),
            ),
          ],
       );
    },);
  }
}
