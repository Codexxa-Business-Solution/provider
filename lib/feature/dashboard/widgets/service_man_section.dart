import 'package:demandium_provider/feature/serviceman/view/serviceman_details.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class ServiceManSection extends StatelessWidget {

  const ServiceManSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
     builder: (dashboardController){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE-2,
                vertical: Dimensions.PADDING_SIZE_DEFAULT
            ),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     Image.asset(Images.dashboardProfile,height: 15,width:15),
                     SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                     Text("service_man_list".tr,
                       style: ubuntuMedium.copyWith(
                         fontSize: Dimensions.fontSizeDefault,
                         color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                       ),
                     )
                   ],
                 ),

                 GestureDetector(
                    onTap: ()=>Get.toNamed(RouteHelper.serviceManSetup),
                    child: Text(
                      dashboardController.dashboardServicemanList.length ==0 ? "add_new_service_man".tr:"view_all".tr,
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.tertiary,
                      )
                    )
                  )
               ],
            ),
          ),

          dashboardController.dashboardServicemanList.length==0?
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT)

          :Container(padding: EdgeInsets.fromLTRB(8,0,8,8),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 :
                  ResponsiveHelper.isTab(context) ? 4 : 2,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3
              ),



              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    Get.to(()=> ServicemanDetails(id: dashboardController.dashboardServicemanList[index].id!,fromDashboard: true,));
                  },
                  child: Container(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                        boxShadow: shadow),

                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children:  [

                        ClipRRect(borderRadius: BorderRadius.circular(50),
                          child: CustomImage(fit: BoxFit.cover, height: 60, width: 60,
                            image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                '${AppConstants.SERVICEMAN_PROFILE_IMAGE_PATH}'
                                '${dashboardController.dashboardServicemanList[index].user!.profileImage}',
                          ),
                        ),

                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        Container(
                          child: Text(dashboardController.dashboardServicemanList[index].user!.firstName!
                              +' '+dashboardController.dashboardServicemanList[index].user!.lastName!,
                            style: ubuntuMedium.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)
                            ),
                            textAlign: TextAlign.center,overflow: TextOverflow.ellipsis
                          ),
                        ),

                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        Text(dashboardController.dashboardServicemanList[index].user!.phone!,
                          style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall,
                              color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: dashboardController.dashboardServicemanList.length,
            ),
          ),
        ],
      );
    });
  }
}
