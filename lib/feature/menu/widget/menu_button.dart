import 'package:demandium_provider/feature/menu/widget/setting_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class MenuButton extends StatelessWidget {
  final MenuModel? menu;
  final bool? isLogout;
  MenuButton({this.menu,this.isLogout});

  @override
  Widget build(BuildContext context) {
    int _count = ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 7 : 4;
    double _size = ((context.width > Dimensions.WEB_MAX_WIDTH ?
    Dimensions.WEB_MAX_WIDTH : context.width)/_count)-Dimensions.PADDING_SIZE_DEFAULT;

    return InkWell(
      onTap: () async {
        print(menu!.route!);
        if(isLogout!) {
          Get.back();
          if(Get.find<AuthController>().isLoggedIn()) {
            Get.dialog(ConfirmationDialog(
                icon: Images.logout,
                title: 'are_you_sure_to_logout'.tr,
                onNoPressed: () {
                  Get.back();
                },
                onYesPressed: () {
                  Get.find<AuthController>().clearSharedData();
                  Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
            }, description: '',), useSafeArea: false);
          }
        }else if(menu!.route!.startsWith('http')) {
          if(await canLaunchUrl(Uri.parse(menu!.route!))) {
            launchUrl(Uri.parse(menu!.route!));
          }
        }else if(menu!.route!.contains('language')) {
          Get.back();
          Get.bottomSheet(SettingBottomSheet(), isScrollControlled: true);
        }else if(menu!.route!.contains("profile")){
          Get.offNamed(RouteHelper.getProfileRoute());
        }

        else if(menu!.route!.contains("chat")){
          Get.offNamed(RouteHelper.getInboxScreenRoute());
        }
        else {
          Get.offNamed(menu!.route!);
        }
      },

      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
            color: Get.isDarkMode?Colors.grey.withOpacity(0.2):Theme.of(context).primaryColor.withOpacity(0.05),
          ),
          height: _size-(_size*0.2),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          alignment: Alignment.center,
          child: Image.asset(menu!.icon!, width: _size, height: _size,fit:BoxFit.fill),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        Text(menu!.title!,
          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}

