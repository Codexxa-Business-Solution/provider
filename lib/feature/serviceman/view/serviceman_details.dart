import 'package:demandium_provider/core/helper/help_me.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';
import 'package:demandium_provider/feature/serviceman/controller/serviceman_details_controller.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ServicemanDetails extends StatefulWidget {
  final String id;
  final bool fromDashboard;
  const ServicemanDetails({Key? key, required this.id,required this.fromDashboard}) : super(key: key);
  @override
  State<ServicemanDetails> createState() => _ServicemanDetailsState();
}
class _ServicemanDetailsState extends State<ServicemanDetails> {

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ServicemanSetupController(
        servicemanRepo: ServicemanRepo(apiClient: Get.find()))
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _appbar(fromDashboard: widget.fromDashboard,),
      body:  GetBuilder<ServicemanDetailsController>(
        initState: (_){
          Get.find<ServicemanDetailsController>().getServicemanDetails(widget.id);
        },
          builder: (servicemanDetailsController){
        if(!servicemanDetailsController.isLoading){
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CustomImage(
                    height: 100,
                    width: 100,
                    image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                        '${AppConstants.SERVICEMAN_PROFILE_IMAGE_PATH}'
                        '${servicemanDetailsController.servicemanModel!.user!.profileImage??""}',
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Text(servicemanDetailsController.servicemanModel!.user!.firstName! +" "+ servicemanDetailsController.servicemanModel!.user!.lastName!,
                    style: ubuntuBold.copyWith(fontSize: 17, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8))
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  width: Get.width,
                  color: Get.isDarkMode?Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1):Theme.of(context).primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ColumnText(
                          amount: servicemanDetailsController.servicemanModel?.bookingsCount?.ongoing.toString()??"",
                          title: "ongoing".tr
                      ),

                      Container(
                        width: 1,
                        height: 60,
                        color: Colors.grey,
                      ),

                      ColumnText(
                          amount: servicemanDetailsController.servicemanModel?.bookingsCount?.completed.toString()??"",
                          title: "completed".tr
                      ),
                      Container(
                        width: 1,
                        height: 60,
                        color: Colors.grey,
                      ),
                      ColumnText(
                          amount: servicemanDetailsController.servicemanModel?.bookingsCount?.canceled.toString()??"",
                          title: "canceled".tr
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                      boxShadow: shadow,
                      color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.phone,color: Theme.of(context).primaryColorLight,),
                        title: Text(
                          servicemanDetailsController.servicemanModel!.user!.phone??"",
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                        ),
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                      ),
                      Container(height: 1,width: double.maxFinite,color: Colors.grey.shade200,),
                      ListTile(
                        leading: Icon(Icons.email,color: Theme.of(context).primaryColorLight,),
                        title: Text(
                          servicemanDetailsController.servicemanModel!.user!.email??"",
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                        ),
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,

                      ),
                      Container(height: 1,width: double.maxFinite,color: Colors.grey.shade200,),
                      ListTile(
                        leading: Icon(Icons.people_outline_rounded,color: Theme.of(context).primaryColorLight,),
                        title: Text(
                          servicemanDetailsController.servicemanModel!.user!.identificationType.toString().tr +" - "
                          + servicemanDetailsController.servicemanModel!.user!.identificationNumber.toString(),
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                        ),
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                      )
                    ],
                  ),
                ),

                ListView.builder(
                  itemBuilder: (context,index){
                    return Container(
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      decoration: BoxDecoration(
                          boxShadow: shadow,
                          color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        child: CustomImage(fit: BoxFit.cover, height: 180,
                          image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                              '${AppConstants.SERVICEMAN_IDENTITY_IMAGE_PATH}'
                              '${servicemanDetailsController.servicemanModel!.user!.identificationImage![index]}',
                        ),
                      ),
                    );
                  },
                  itemCount: servicemanDetailsController.servicemanModel!.user!.identificationImage!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).hoverColor,),
          );
        }
      })
    );
  }
  
}

class _appbar extends StatelessWidget implements PreferredSizeWidget{
  final bool fromDashboard;
  const _appbar({
    Key? key,
    required this.fromDashboard
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServicemanDetailsController>(builder: (servicemanDetailsController){
      return AppBar(
        elevation: 5,
        titleSpacing: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
        title: Text("profile_details".tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColorLight),),
        leading: IconButton(onPressed: () =>Get.back(),
          icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight,size: 20,),
        ),
        actions: fromDashboard?[
          if(!servicemanDetailsController.isLoading)
          InkWell(
            onTap: (){
              if(isRedundentClick(DateTime.now())){
                return;
              }
              Get.find<ServicemanSetupController>().changeServicemanStatus(
                  -1,servicemanDetailsController.servicemanModel!.id!,fromDetailsPage: true
              );

              if(fromDashboard){
                Get.find<DashboardController>().getDashboardData();
              }else{
                Get.find<ServicemanSetupController>().getAllServicemanList(1,reload: true);
              }
            },
            child: Container(height: 25, width: 45,
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: servicemanDetailsController.servicemanModel!.user!.isActive==1?
                  Theme.of(context).primaryColor: Colors.grey.withOpacity(0.5)
              ),
              child: Row(
                mainAxisAlignment:  servicemanDetailsController.servicemanModel!.user!.isActive==0?
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
                      color: servicemanDetailsController.servicemanModel!.user!.isActive==0?
                      Theme.of(context).errorColor:Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert,color: Theme.of(context).primaryColorLight,),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'edit', 'delete'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice.tr),
                );
              }).toList();
            },
          )

        ]:[],
      );
    });
  }

  void handleClick(String value)  {
    switch (value) {
      case 'edit': {
        Get.find<ServicemanSetupController>().getSingleServicemanData(index :-1, fromPage: "detailsPage");
        Get.to(()=>AddNewServicemanScreen(isEditScreen: true,));
      }
        break;
      case 'delete': {
        Get.dialog(ConfirmationDialog(
            title: "delete_this_service_man".tr,
            icon: Images.servicemanImage,
            description: 'this_operation_cannot_be_undone'.tr,
            onYesPressed: () async => await Get.find<ServicemanSetupController>()
                .deleteServiceman(Get.find<ServicemanDetailsController>().servicemanModel!.id!
            ),
            onNoPressed: () {
              // servicemanController.updateIndex(-1);
              Get.back();
            }),
        );
      }
        break;
    }
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 55);
}
