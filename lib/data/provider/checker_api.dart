import 'package:get/get.dart';
import '../../core/helper/core_export.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      if(Get.currentRoute!=RouteHelper.getSignInRoute('splash')){
        Get.offAllNamed(RouteHelper.getSignInRoute('splash'));
      }
    }else {
      showCustomSnackBar(response.statusText);
    }
  }
}