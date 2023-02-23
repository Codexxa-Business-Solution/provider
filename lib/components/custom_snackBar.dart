import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

void showCustomSnackBar(String? message, {bool isError = true, int duration =2}) {
  if(message != null && message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      message: message,
      maxWidth: Dimensions.WEB_MAX_WIDTH,
      duration: Duration(seconds: duration),
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      borderRadius: Dimensions.RADIUS_SMALL,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}