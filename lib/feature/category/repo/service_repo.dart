import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ServiceRepo{

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ServiceRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> getCategoryList() async {
    return await apiClient.getData(AppConstants.SERVICE_CATEGORY_URL+"?limit=100&offset=1");
  }

  Future<Response> getSubCategoryList(String id ,int offset) async {
    return await apiClient.getData(AppConstants.SERVICE_SUB_CATEGORY_URL+"?limit=${Get.find<SplashController>().configModel.content?.paginationLimit}&offset=$offset&id=${id}");
  }

  Future<Response> changeSubscriptionStatus(String id) async {
    return await apiClient.postData(AppConstants.CHANGE_SUBSCRIPTION_STATUS_URL, {'sub_category_id': [id]});
  }
}
