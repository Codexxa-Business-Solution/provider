import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/serviceman/controller/serviceman_details_controller.dart';
import 'package:get/get.dart';

class ServicemanSetupBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ServicemanSetupController(
        servicemanRepo: ServicemanRepo(apiClient: Get.find()))
    );
    Get.lazyPut(() => ServicemanDetailsController(
        servicemanRepo: ServicemanRepo(apiClient: Get.find()))
    );
  }


}