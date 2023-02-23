import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class MySubscriptionRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  MySubscriptionRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> getSubscriptionListData(int offset) async {
    return await apiClient.getData(AppConstants.SUBSCRIPTION_LIST_URL+"?limit=${Get.find<SplashController>().configModel.content?.paginationLimit}&offset=$offset");
  }

  Future<Response> changeSubscriptionStatus(String id) async {
    return await apiClient.postData(AppConstants.CHANGE_SUBSCRIPTION_STATUS_URL, {'sub_category_id': [id]});
  }
}