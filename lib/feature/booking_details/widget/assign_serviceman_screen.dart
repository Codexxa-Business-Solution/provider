import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/serviceman/model/service_man_model.dart';

class AssignServicemanScreen extends StatelessWidget {
  final List<ServicemanModel> servicemanList;
  final String bookingId;
  final bool? reAssignServiceman;

  const AssignServicemanScreen({
    Key? key,
    required this.servicemanList,
    required this.bookingId,
    this.reAssignServiceman
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicemanSetupController>(builder: (servicemanSetupController){
      return GetBuilder<BookingDetailsController>(
        builder: (bookingDetailsController) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                color: Theme.of(context).backgroundColor,
              ),
            child: Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_LARGE),
              width: context.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                color:Get.isDarkMode?
                Theme.of(context).primaryColorDark.withOpacity(0.3)
                    :Theme.of(context).primaryColorDark.withOpacity(0.2),

              ),

              child: Column(
                children: [
                  InkWell(
                    onTap: () => bookingDetailsController.showHideExpandView(0),
                    child: Icon(Icons.keyboard_arrow_down_rounded, size: 30),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  servicemanList.length==0 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "no_serviceman_available".tr,
                        style: ubuntuMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),

                      CustomButton(
                        width: 200,
                        height: 35,
                        fontSize: Dimensions.fontSizeSmall,
                        btnTxt: "add_new_service_man".tr,
                        onPressed: ()
                        {
                          bookingDetailsController.showHideExpandView(0);
                          Get.find<ServicemanSetupController>().fromBookingDetailsPage(true);
                          Get.to(()=>AddNewServicemanScreen(isEditScreen: false));
                        },
                      ),
                    ],
                  ) : GridView.builder(
                    controller: Get.find<ServicemanSetupController>().scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 :
                        ResponsiveHelper.isTab(context) ? 4 : 2,
                        childAspectRatio: 1.0,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0
                    ),
                    itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          Get.dialog(
                          ConfirmationDialog(
                            icon: Images.servicemanImage,
                            description: '',
                            title: "${"are_you_want_to_assign".tr} "
                                "${servicemanList[index].firstName??""} "
                                "${servicemanList[index].lastName??""} "
                                "${'for_this_booking'.tr}?",
                            yesButtonColor: Theme.of(context).primaryColor,
                            onYesPressed: () { servicemanSetupController.assignServiceman(
                              bookingId,
                              servicemanList[index].serviceman!.id!,
                            );
                            Get.back();
                            }
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                            color: Theme.of(context).cardColor,
                            boxShadow: shadow
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CustomImage(
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,
                                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}${AppConstants
                                      .SERVICEMAN_PROFILE_IMAGE_PATH}${servicemanSetupController.servicemanList[index].profileImage}',
                                ),
                              ),

                              SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL,
                              ),
                              Container(
                                child: Text(servicemanSetupController.servicemanList[index].firstName!
                                    +' '+servicemanSetupController.servicemanList[index].lastName!,
                                  style: ubuntuMedium.copyWith(
                                      fontSize: 12
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL,
                              ),
                              Text(
                                servicemanList[index].phone!=null?servicemanList[index].phone!:"Phone: NULL",
                                style: ubuntuMedium.copyWith(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: servicemanList.length,
                  )
                ],
              ),
            ),
          );
        }
      );
    });
  }
}
