import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardController){
      return dashboardController.dashboardRecentActivityList.length==0?
      SizedBox()
      :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT+3,
            vertical: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Row(
              children: [
                Image.asset(Images.dashboardProfile,height: 15,width:15),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                Text("recent_booking_activities".tr,
                  style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top:Dimensions.PADDING_SIZE_SMALL),
            color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.isTab(context)?2:1,
                  mainAxisExtent: 95
                ),
                itemBuilder: (context, index) {
               return Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                    GestureDetector(
                      onTap:()=>Get.toNamed(RouteHelper.getBookingDetailsRoute(
                        dashboardController.dashboardRecentActivityList[index].id.toString(),
                          dashboardController.dashboardRecentActivityList[index].bookingStatus.toString(),
                        'others'
                      )),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                        child: RecentActivityCardItem(
                          dashboardRecentActivityModel: dashboardController.dashboardRecentActivityList[index]
                        )
                      ),
                    ),

                   if(index!=dashboardController.dashboardRecentActivityList.length-1) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Divider(height: 1,color: Colors.grey[Get.isDarkMode?700:400],),
                    ),
                 ],
               );
              },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: dashboardController.dashboardRecentActivityList.length,
            ),
          ),
        ],
      );
    });
  }
}
