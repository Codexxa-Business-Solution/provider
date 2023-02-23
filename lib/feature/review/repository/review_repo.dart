import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ReviewRepo{
  final ApiClient apiClient;
  ReviewRepo({required this.apiClient});

  Future<Response> getProviderReviewList(int offset) async {
    return await apiClient.getData('${AppConstants.GET_PROVIDER_REVIEW_LIST}?offset=$offset&limit=10');
  }

  Future<Response> getServiceReviewList(String serviceID,int offset) async {
    return await apiClient.getData('${AppConstants.GET_SERVICE_REVIEW_LIST}/$serviceID?offset=$offset&limit=10&status=all');
  }

}