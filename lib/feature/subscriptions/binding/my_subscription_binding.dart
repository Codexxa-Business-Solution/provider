import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class MySubscriptionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MySubscriptionController(
        mySubscriptionRepo: MySubscriptionRepo(
            apiClient: Get.find(),sharedPreferences: Get.find()),
        userRepo:UserRepo(Get.find(), apiClient: Get.find())
    ));
  }

}