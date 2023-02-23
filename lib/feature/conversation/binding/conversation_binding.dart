import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';



class ConversationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ConversationController(conversationRepo: ConversationRepo(apiClient: Get.find())));
  }
}