import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class NoDataScreen extends StatelessWidget {
  final NoDataType? type;
  final String? text;
  NoDataScreen({required this.text, this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          Container(
            child: Image.asset(
              (type == NoDataType.CONVERSATION || type == NoDataType.CONVERSATION)
                  ? Images.chatImage
                  : type == NoDataType.REQUEST
                  ? Images.noData
                  : type == NoDataType.NOTIFICATION
                  ? Images.emptyNotification
                  : type == NoDataType.TRANSACTION
                  ? Images.transaction
                  : type == NoDataType.SERVICE
                  ? Images.noService
                  : Images.help,
              width: MediaQuery.of(context).size.height * 0.13,
              height: MediaQuery.of(context).size.height * 0.13,
              color: Get.isDarkMode&&type!=NoDataType.TRANSACTION && type!=NoDataType.CONVERSATION?
              Theme.of(context).primaryColorLight:null,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text(
            type == NoDataType.OTHERS
                ? 'cart_is_empty'.tr
                : type == NoDataType.OTHERS
                ? 'sorry_your_order_history_is_Empty'.tr
                : type == NoDataType.CONVERSATION
                ? 'your_inbox_list_empty_right_now'.tr
                : type == NoDataType.NOTIFICATION
                ? 'empty_notifications'.tr
                : text!.tr,
            style: ubuntuMedium.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color:Get.isDarkMode? Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6):Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          //Text("There are no Services".tr),
        ]);
  }
}