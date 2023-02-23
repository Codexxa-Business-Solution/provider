import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class RecentActivityCardItem extends StatelessWidget {
  final DashboardRecentActivityModel dashboardRecentActivityModel;
  const RecentActivityCardItem({
    Key? key,
    required this.dashboardRecentActivityModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all( Dimensions.PADDING_SIZE_SMALL),

      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            child: CustomImage(
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}"
                  "${AppConstants.SERVICE_IMAGE_PATH}${dashboardRecentActivityModel
                  .detail![0].service!=null?dashboardRecentActivityModel.detail![0].service!.thumbnail:""}",
            )
          ),

          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
          Expanded(
            child: SizedBox(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                  Text("${'booking'.tr}#  ${dashboardRecentActivityModel.readableId}",
                    style: ubuntuBold.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)
                    )
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Text("${DateConverter.dateMonthYearTime(DateConverter
                      .isoUtcStringToLocalDate(dashboardRecentActivityModel.createdAt!))}",
                    style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),),
                      textDirection: TextDirection.ltr
                  )
                ]
              )
            )
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.fontSizeSmall,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:Get.isDarkMode?Colors.grey.withOpacity(0.2):
              ColorResources.buttonBackgroundColorMap[dashboardRecentActivityModel.bookingStatus],
            ),
            child: Text(
              dashboardRecentActivityModel.bookingStatus!.tr,
              style:ubuntuMedium.copyWith(fontWeight: FontWeight.w500, fontSize: Dimensions.fontSizeSmall,
                  color:Get.isDarkMode?Theme.of(context).primaryColorLight :ColorResources.buttonTextColorMap[dashboardRecentActivityModel.bookingStatus]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
