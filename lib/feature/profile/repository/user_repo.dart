import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserRepo(this.sharedPreferences, {required this.apiClient});

  Future<Response> getProviderInfo() async {
    return await apiClient.getData(AppConstants.PROVIDER_PROFILE_URL);
  }

  Future<Response?> getZonesDataList() async {
    return await apiClient.getData(AppConstants.ZONE_URI+'?limit=200&offset=1');
  }

  Future<Response> updateProfile(String companyName,String companyPhone,String companyAddress, String companyEmail,
      String contactPersonName,String contactPersonPhone, String contactPersonEmail,String zoneId,XFile? profileImage) async {
      return await apiClient.postMultipartData(AppConstants.PROVIDER_PROFILE_UPDATE_URL,
        {
          "company_name":companyName,
          "company_phone":contactPersonPhone,
          "company_address":companyAddress,
          "company_email":companyEmail,
          "contact_person_name":contactPersonName,
          "contact_person_phone":contactPersonPhone,
          "contact_person_email":contactPersonEmail,
          "zone_ids[]":zoneId,
          "_method": "put"
        },[],profileImage!=null?MultipartBody('logo', profileImage):null
    );
  }


  Future<Response> updateProfileWithPassword(String companyName,String companyPhone,String companyAddress, String companyEmail,
      String contactPersonName,String contactPersonPhone, String contactPersonEmail,String password,String confirmedPassword,String zoneId) async {
    return await apiClient.postMultipartData(AppConstants.PROVIDER_PROFILE_UPDATE_URL,
        {
          "company_name":companyName,
          "company_phone":contactPersonPhone,
          "company_address":companyAddress,
          "company_email":companyEmail,
          "contact_person_name":contactPersonName,
          "contact_person_phone":contactPersonPhone,
          "contact_person_email":contactPersonEmail,
          "password": password,
          "confirm_password":confirmedPassword,
          "zone_ids[]":zoneId,
          "_method": "put"
        },null,null
    );
  }


  Future<Response> getBookingRequestData(String requestType, int offset) async {
    return await apiClient.postData(AppConstants.BOOKING_LIST_URL,
        {"limit" : Get.find<SplashController>().configModel.content?.paginationLimit, "offset" : offset, "booking_status" : requestType});
  }
}