import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class TopCardSection extends StatelessWidget {
  const TopCardSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DashboardController>(
      builder: (dashboardController) =>  dashboardController.dashboardTopCards==null?
      DashboardShimmer():
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT+3, vertical: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("business_summery".tr,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
              ),
            ),
          ),

          Container(
            padding:  EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL),
            width: Get.width, height: ResponsiveHelper.isTab(context)?210:280,
            color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
            child: Column(
              children:[
                Row(
                  children:[
                    TopCardItem(
                      height: 100,
                      curveColor: Colors.green,
                      cardColor: Colors.green,
                      amount: PriceConverter.convertPrice(
                          dashboardController.dashboardTopCards!=null?dashboardController.dashboardTopCards!.totalEarning:0,
                          isShowLongPrice: true
                      ),
                      title: "total_earning".tr,
                      iconData: Images.earning
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    TopCardItem(
                      height: 100,
                      curveColor: Theme.of(context).colorScheme.secondary,
                      cardColor: Theme.of(context).colorScheme.secondary,
                      amount: dashboardController.dashboardTopCards!=null && dashboardController.dashboardTopCards!.totalSubscribedServices!=null
                          ? dashboardController.dashboardTopCards!.totalSubscribedServices.toString()
                          :"0",
                      title: "total_subscribed_subcategories".tr,
                      iconData: Images.topCardService
                    )
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                Row(
                  children: [
                    TopCardItem(
                      height: 70,
                      cardColor:Theme.of(context).colorScheme.tertiary,
                      amount: dashboardController.dashboardTopCards!=null && dashboardController.dashboardTopCards!.totalServiceMan!=null
                          ? dashboardController.dashboardTopCards!.totalServiceMan.toString()
                          :"0",
                      title: "total_service_men".tr,
                      iconData: Images.serviceMan
                    ),
                    ResponsiveHelper.isTab(context)
                        ?SizedBox(width: Dimensions.PADDING_SIZE_SMALL)
                        :SizedBox.shrink(),

                    ResponsiveHelper.isTab(context)?
                    TopCardItem(
                        height: 70,
                        cardColor: Theme.of(context).colorScheme.onSecondary,
                        amount: dashboardController.dashboardTopCards!=null && dashboardController.dashboardTopCards!.totalBookingServed!=null
                            ? dashboardController.dashboardTopCards!.totalBookingServed.toString()
                            :"0",
                        title: "total_booking_served".tr,
                        iconData: Images.booking
                    ):SizedBox.shrink()
                  ],
                ),

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                ResponsiveHelper.isTab(context)?SizedBox.shrink():
                TopCardItem(
                  cardColor: Theme.of(context).colorScheme.onSecondary,
                  amount: dashboardController.dashboardTopCards!=null?dashboardController.dashboardTopCards!.totalBookingServed.toString():'0',
                  title: "total_booking_served".tr,
                  iconData: Images.booking
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
