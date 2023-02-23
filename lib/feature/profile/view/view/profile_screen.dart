import 'package:demandium_provider/feature/profile/view/promotional_cost/promotional_cost_percentage.dart';
import 'package:demandium_provider/feature/review/view/provider_review_screen.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';
import 'package:demandium_provider/feature/profile/view/commission/commission_view_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GetBuilder<UserProfileController>(
        initState: (_) async {
          await Get.find<BankInfoController>().getBankInfoData();
          await Get.find<UserProfileController>().getProviderInfo(reload: true);
          await Get.find<TransactionController>().getWithdrawMethods();
        },
        builder: (userController) {
          if(userController.providerModel!=null){
            return  SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  profileHeaderSection(context,userController),

                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  GestureDetector(
                    onTap: () => Get.to(ProfileInformationScreen()),
                    child: ProfileCardItem(title: "edit_profile", leadingIcon: Images.profileInformation),
                  ),

                  GestureDetector(
                    onTap: ()=>Get.to(AccountInformation()),
                    child: ProfileCardItem(title: "account_information", leadingIcon: Images.accountInformation),
                  ),

                  GestureDetector(
                    onTap: () => Get.to(BusinessInformation()),
                    child: ProfileCardItem(title: "Business_Information", leadingIcon: Images.businessInformation),
                  ),

                  GestureDetector(
                    onTap: () => Get.to(ProviderReviewScreen()),
                    child: ProfileCardItem(title: "reviews", leadingIcon: Images.reviewIcon),
                  ),

                  GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.bankInfo),
                    child: ProfileCardItem(title: "bank_information", leadingIcon: Images.bankInformation),
                  ),

                  GestureDetector(
                      onTap: () => Get.to(CommissionViewScreen()),
                      child: ProfileCardItem(title: "commission", leadingIcon: Images.commission,isDarkItem: true,)
                  ),

                  GestureDetector(
                      onTap: () => Get.to(PromotionalCostPercentageScreen()),
                      child: ProfileCardItem(title: "promotional_cost", leadingIcon: Images.promotionalCostIcon,isDarkItem: true,)
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                ],
              ),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(color: Theme.of(context).hoverColor,),
            );
          }

        },
      ),
    );
  }

  Widget profileHeaderSection(context,UserProfileController userController) {
    return Container(
      height: 320,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        color: Get.isDarkMode?Theme.of(context).primaryColorDark:Theme.of(context).primaryColor),

      child: Stack(
        children: [
          Container(
            height: 250, 
            width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width/4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(300)
              ),
              color: Colors.white.withOpacity(.05),
              boxShadow:Get.isDarkMode? null: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 5,
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                )],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Padding(padding: EdgeInsets.only(
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                  right: Dimensions.PADDING_SIZE_SMALL,
                  left: Dimensions.PADDING_SIZE_SMALL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                           onPressed: ()=>Get.back(),
                           icon: Icon(Icons.arrow_back_ios,size: 16,color: light.cardColor)
                        ),
                        Text("my_profile".tr,style: ubuntuMedium.copyWith(fontSize: 16,
                           color: light.cardColor)
                        )
                      ],
                    ),

                    GetBuilder<ThemeController>(
                      builder: (themeController){
                        return GestureDetector(
                           onTap: ()=> themeController.toggleTheme(),
                           child: Container(height: 25, width: 45,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withOpacity(0.5)
                              ),
                             child: Row(
                               mainAxisAlignment: themeController.darkTheme?MainAxisAlignment.start:MainAxisAlignment.end,
                               children: [
                                 Container(
                                   height: 22,
                                   width: 22,
                                   margin: EdgeInsets.all(2),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(50),
                                     boxShadow: [
                                       BoxShadow(
                                         offset: Offset(0, 2),
                                         blurRadius: 5,
                                         color: Colors.black.withOpacity(0.3),
                                       )],
                                     color: light.cardColor,),
                                   child: Icon(themeController.darkTheme ?
                                     Icons.dark_mode_outlined : Icons.light_mode_outlined,
                                     size: 16,
                                     color: Theme.of(context).primaryColor,
                                   ),
                                 ),
                               ],
                             ),
                          ),
                        );
                      },
                    ),
                ],),
              ),

              SizedBox(height: 5),

              ClipRRect(borderRadius: BorderRadius.circular(50),
                child: CustomImage(
                  height: 100,
                  width: 100,
                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                      '${AppConstants.PROVIDER_PROFILE_IMAGE_PATH}'
                      '${userController.providerModel?.content?.providerInfo?.logo??""}'
                )
              ),

              Text(userController.providerModel!.content!.providerInfo!.companyName!,
                style: ubuntuBold.copyWith(fontSize: 17, color: Colors.white)
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: Get.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ColumnText(
                      amount: Get.find<DashboardController>().dashboardTopCards?.totalSubscribedServices.toString()??"",
                      title: "total_subscription".tr
                    ),

                    ColumnText(
                      amount: Get.find<DashboardController>().dashboardTopCards?.totalBookingServed.toString()??"",
                      title: "Booking_Served".tr
                    ),

                    ColumnText(
                      amount: DateTime.now().difference(DateConverter.isoStringToLocalDate(userController
                          .providerModel?.content?.providerInfo?.createdAt.toString()??DateTime.now().toString())).inDays.toString(),
                      title: "Days_Since_Joined".tr
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
