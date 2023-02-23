import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {

   Get.lazyPut(() => DashboardController(dashBoardRepo: DashBoardRepo(apiClient: Get.find(),sharedPreferences: Get.find())));
   Get.lazyPut(() => BookingRequestController(bookingRequestRepo: BookingRequestRepo(apiClient: Get.find())));
   Get.lazyPut(() => ServiceCategoryController(allServiceRepo: ServiceRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
   Get.lazyPut(() => ServicemanSetupController(servicemanRepo: ServicemanRepo(apiClient: Get.find())));
   Get.lazyPut(() => MySubscriptionController(mySubscriptionRepo: MySubscriptionRepo(apiClient: Get.find(), sharedPreferences: Get.find()), userRepo:UserRepo(Get.find(), apiClient: Get.find()) ));

  }
}