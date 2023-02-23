import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class BankInfoRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  BankInfoRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> getBankInfoData() async {
    return await apiClient.getData(AppConstants.BANK_DETAILS_URL);
  }

  Future<Response> updateBankInfo(String bankName, String branchName, String accountNo, String accountHolderName,String routingNumber) async {
    return await apiClient.putData(
        AppConstants.UPDATE_BANK_DETAILS_URL,
        {'bank_name':bankName,
          'branch_name':branchName,
          'acc_no':accountNo,
          'acc_holder_name': accountHolderName,
          "routing_number": routingNumber
        });
  }
  Future<Response> withdrawRequest(String amount,String note) async {
    return await apiClient.postData( AppConstants.WITHDRAW_REQUEST,{'amount':amount,'note':note});
  }
}