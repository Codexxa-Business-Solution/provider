import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    String _aboutUs = Get.find<SplashController>().configModel.content!.aboutUs!;
    String _privacyPolicy = Get.find<SplashController>().configModel.content!.privacyPolicy!;
    String _termsAndCondition = Get.find<SplashController>().configModel.content!.termsAndConditions!;
    String _refundPolicy = Get.find<SplashController>().configModel.content!.refundPolicy!;
    String _cancellationPolicy = Get.find<SplashController>().configModel.content!.cancellationPolicy!;

    //double _ratio = ResponsiveHelper.isDesktop(context) ? 1 : ResponsiveHelper.isTab(context) ? 1.2 : 1.2;
    final List<MenuModel> _menuList = [
      MenuModel(icon: Images.profileIcon, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      MenuModel(icon: Images.reportOverview2, title: 'reports'.tr, route: RouteHelper.getReportingPageRoute('menu')),
      MenuModel(icon: Images.chatImage, title: 'chat'.tr, route: RouteHelper.getInboxScreenRoute()),
      MenuModel(icon: Images.settings, title: 'settings'.tr, route: RouteHelper.getLanguageRoute('menu')),
      MenuModel(icon: Images.mySubscriptions, title: 'mySubscription'.tr, route: RouteHelper.getMySubscriptionRoute()),
      MenuModel(icon: Images.transaction, title: 'transactions'.tr, route: RouteHelper.transactions),

      if(_aboutUs!='') MenuModel(icon: Images.aboutUs, title: 'about_us'.tr, route: RouteHelper.getHtmlRoute(page:'about_us',fromPage: "djfghdjf")),
      if(_privacyPolicy!='') MenuModel(icon: Images.privacyPolicyIcon, title: 'privacy_policy'.tr, route: RouteHelper.getHtmlRoute(page:'privacy-policy')),
      if(_termsAndCondition!='')MenuModel(icon: Images.termsConditionIcon, title: 'terms_and_condition'.tr, route: RouteHelper.getHtmlRoute(page:'terms-and-condition')),
      if(_refundPolicy!='')MenuModel(icon: Images.refund, title: 'refund_policy'.tr, route: RouteHelper.getHtmlRoute(page:'refund-policy')),
      if(_cancellationPolicy!='')MenuModel(icon: Images.cancellation, title: 'cancellation_policy'.tr, route: RouteHelper.getHtmlRoute(page:'cancellation-policy')),
      MenuModel(icon: Images.logout, title: _isLoggedIn ? 'log_out'.tr : 'sign_in'.tr, route: RouteHelper.getSignInRoute("menu"))
    ];


    return PointerInterceptor(
      child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Theme.of(context).cardColor,
        ),
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.keyboard_arrow_down_rounded, size: 30),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 7 : 4,
                mainAxisExtent: 120,
                crossAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL
              ),
              itemCount: _menuList.length,
              itemBuilder: (context, index) {
                return MenuButton(menu: _menuList[index], isLogout: index == _menuList.length-1);
              },
            ),
            SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.PADDING_SIZE_SMALL : 0),
            SafeArea(
              child: RichText(
                text: TextSpan(
                    text: "app_version".tr,
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: Theme.of(context).primaryColorLight),
                    children: <TextSpan>[
                      TextSpan(
                        text: " ${AppConstants.APP_VERSION} ",
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                      )
                    ]
                ),
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT)
          ]),
        ),
      ),
    );
  }
}
