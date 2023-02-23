import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class BookingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BookingDetailsController(bookingDetailsRepo: BookingDetailsRepo(apiClient: Get.find())));
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServicemanSetupController(servicemanRepo: ServicemanRepo(apiClient: Get.find())));
  }
}