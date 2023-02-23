import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class EmptyFAQWidget extends StatelessWidget {
  const EmptyFAQWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        constraints:  ResponsiveHelper.isDesktop(context) ? BoxConstraints(
          minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 550,
        ) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),
            Image.asset(
              Images.help,scale:Dimensions.PADDING_SIZE_SMALL,
              color: Get.isDarkMode ?  Theme.of(context).primaryColorLight: null,
              fit:BoxFit.cover,
              height: 60,
              width: 60,
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            Text("no_faq_found".tr,style: ubuntuMedium.copyWith(
                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)
            ),),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
          ],
        ),
      ),
    );
  }
}
