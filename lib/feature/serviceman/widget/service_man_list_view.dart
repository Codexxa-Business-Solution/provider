import 'package:demandium_provider/core/helper/help_me.dart';
import 'package:demandium_provider/feature/serviceman/view/serviceman_details.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';

class ServiceManListview extends StatelessWidget {
  const ServiceManListview({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicemanSetupController>(
      builder: (servicemanController) {
        return GridView.builder(shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 :
          ResponsiveHelper.isTab(context) ? 4 : 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 3, crossAxisSpacing: 3),
          itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              servicemanController.updateIndex(-1);
              Get.to(()=> ServicemanDetails(id: servicemanController.servicemanList[index].serviceman!.id!,fromDashboard: false,));
              },
            child: Container(
              margin: EdgeInsets.all(5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  color: servicemanController.servicemanList[index].isActive==1?
                  Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1):Colors.grey.withOpacity(0.2),
                  boxShadow: servicemanController.servicemanList[index].isActive==1?shadow:null
                ),

              child: Stack(alignment: Alignment.center,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Stack(
                          children: [
                            CustomImage(
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}''${AppConstants
                                  .SERVICEMAN_PROFILE_IMAGE_PATH}${servicemanController.servicemanList[index].profileImage}',
                            ),
                            if(servicemanController.servicemanList[index].isActive.toString()=='0')Container(
                              height: 60,
                              width: 60,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            if(servicemanController.servicemanList[index].isActive.toString()=='0')
                            Positioned(
                              top: 23,
                              left: 7,
                              child: Text(
                                'inactive'.tr,
                                style: ubuntuMedium.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: light.cardColor,
                                    letterSpacing: 0.5
                                ),
                              ),
                            )

                          ],
                        ),
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                        child: Text(
                          servicemanController.servicemanList[index].firstName!+" "
                              +servicemanController.servicemanList[index].lastName!,
                          style: ubuntuBold.copyWith(
                            color:servicemanController.servicemanList[index].isActive==1?
                            Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7):
                            Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.3),
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 2,
                        ),
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Text(servicemanController.servicemanList[index].phone!,
                        style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall-1,
                          color:servicemanController.servicemanList[index].isActive==1?
                          Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7):
                          Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.3),),
                      ),
                    ],
                  ),

                  servicemanController.selectedIndex == index ?
                  Positioned(top: 30, right: 30,
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      width:ResponsiveHelper.isTab(context)?
                      MediaQuery.of(context).size.width*0.18 : MediaQuery.of(context).size.width*0.35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.3),
                            )]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              servicemanController.clearImageData();
                              servicemanController.updateTabControllerValue(ServicemanTabControllerState.generalInfo);
                              servicemanController.controller!.index=0;
                              servicemanController.getSingleServicemanData(index:index, fromPage: 'editPage');
                              Get.to(AddNewServicemanScreen(isEditScreen: true));
                            },
                            child: Image.asset(Images.servicemanEdit,height: 25,width: 25),
                          ),

                          GestureDetector(
                            onTap: () =>
                              Get.dialog(ConfirmationDialog(
                              title: "delete_this_service_man".tr,
                                  icon: Images.servicemanImage,
                              description: 'this_operation_cannot_be_undone'.tr,
                              onYesPressed: ()=>servicemanController.deleteServiceman(servicemanController
                                  .servicemanList[index].serviceman!.id!
                              ),
                              onNoPressed: () {
                                servicemanController.updateIndex(-1);
                                Get.back();
                              }),
                            ),
                              child: Image.asset(Images.servicemanDelete,height: 25,width: 25)
                          ),

                          GestureDetector(
                            onTap: (){
                              if(isRedundentClick(DateTime.now())){
                                return;
                              }
                              servicemanController.changeServicemanStatus(
                                  index,servicemanController.servicemanList[index].serviceman!.id!
                              );

                              Get.find<DashboardController>().getDashboardData();
                            },
                            child: Container(height: 25, width: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: servicemanController.servicemanList[index].isActive==1?
                                  Theme.of(context).primaryColor: Colors.grey.withOpacity(0.5)
                              ),
                              child: Row(
                                mainAxisAlignment: servicemanController.servicemanList[index].isActive==0?
                                MainAxisAlignment.start:MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 22,
                                    width: 22,
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 5,
                                          color: Colors.black.withOpacity(0.3),
                                        )],
                                      borderRadius: BorderRadius.circular(50),
                                      color: light.cardColor,),
                                    child: Icon( Icons.person,
                                      size: 15,
                                      color: servicemanController.servicemanList[index].isActive==0?
                                      Theme.of(context).errorColor:Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  :SizedBox(),

                  Positioned(right: 10, top: 10,
                    child: GestureDetector(
                      onTap: () => servicemanController.updateIndex(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color:Get.isDarkMode ? Colors.grey.withOpacity(0.2) : Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Icon(Icons.more_horiz_rounded, color: Theme.of(context).primaryColorLight.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );},
          itemCount: servicemanController.servicemanList.length,
        );
      },
    );
  }
}
