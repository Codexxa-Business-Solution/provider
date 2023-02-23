import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/dashboard/model/dashboard_subscription_Model.dart';


class SubscriptionCardItem extends StatelessWidget {
  final DashboardSubscriptionModel subscriptionModelData;

  const SubscriptionCardItem({Key? key, required this.subscriptionModelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.isDesktop(context)? Get.width*.2:ResponsiveHelper.isTab(context)?Get.width*.4:Get.width*.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
          boxShadow: shadow
      ),
      margin:  EdgeInsets.only(top: 4,bottom:4,left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [

          SizedBox(width: 10),
          ClipRRect(borderRadius: BorderRadius.circular(5),
            child: CustomImage(height: 70, width: 70,
              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}${AppConstants.CATEGORY_IMAGE_PATH}'
                  '${subscriptionModelData.subCategory!=null?subscriptionModelData.subCategory!.image:""}',
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

          Expanded(
            child: SizedBox(

              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [


                  Text(subscriptionModelData.subCategory!=null?subscriptionModelData.subCategory!.name!:"",
                    style: ubuntuBold.copyWith( color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),overflow: TextOverflow.ellipsis,),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),


                  Text('${subscriptionModelData.servicesCount.toString()} ${'services'.tr}',
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),


                  Text('${subscriptionModelData.completedBookingCount.toString()} ${'bookings_completed'.tr}',
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),),
                ],
              ),
            ),
          ),
        const SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
        ],
      ),
    );
  }
}