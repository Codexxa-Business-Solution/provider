import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class TransactionRepo{
  final ApiClient apiClient;
  TransactionRepo({required this.apiClient});

  Future<Response> getTransactionsList(int offset) async {
    return await apiClient.getData(AppConstants.WITHDRAW_REQUEST+"?offset=$offset&limit=${Get.find<SplashController>()
        .configModel.content!.paginationLimit}");
  }


  Future<Response>  cashInApi({String? phoneNumber,double? amount,String? pin }) async {
    return await apiClient.postData(AppConstants.WITHDRAW_REQUEST, {'phone': phoneNumber, 'amount': amount, 'pin': pin});
  }

  Future<Response>  requestMoneyApi({double? amount}) async {
    return await apiClient.postData(AppConstants.WITHDRAW_REQUEST,  {'amount' : amount});
  }
  Future<Response>  cashOutApi({double? amount,String? pin}) async {
    return await apiClient.postData(AppConstants.WITHDRAW_REQUEST, {'amount' : amount, 'pin' : pin});
  }

  Future<Response>  checkCustomerNumber({String? phoneNumber}) async {
    return await apiClient.postData(AppConstants.WITHDRAW_REQUEST, {'phone' : phoneNumber});
  }
  Future<Response>  checkAgentNumber({String? phoneNumber}) async {
    return await apiClient.postData(AppConstants.WITHDRAW_REQUEST, {'phone' : phoneNumber});
  }

  Future<Response>  withdrawRequest({Map<String, String>? placeBody}) async {
    return await apiClient.postData(AppConstants.WITHDRAW_REQUEST, placeBody);
  }
  Future<Response> getWithdrawMethods() async {
    return await apiClient.getData(AppConstants.WITHDRAW_REQUEST_METHOD+"?limit=50&offset=1");
  }



  // List<ContactModel>  getSuggestList()  {
  //   List<String> suggests  = [];
  //   if(sharedPreferences.containsKey(AppConstants.SEND_MONEY_SUGGEST_LIST)){
  //     suggests =  sharedPreferences.getStringList(AppConstants.SEND_MONEY_SUGGEST_LIST);
  //
  //   }
  //   if(suggests != null){
  //     List<ContactModel> contactList = [];
  //     suggests.forEach((contact) => contactList.add(ContactModel.fromJson(jsonDecode(contact))));
  //     print('contact list : ==> $contactList');
  //     return  contactList;
  //
  //   }
  //   return null;
  //
  // }

  // void addToSuggestList(List<ContactModel> contactModelList,{@required String type}) async {
  //   List<String> suggests  = [];
  //   contactModelList.forEach((contactModel) => suggests.add(jsonEncode(contactModel)));
  //   if(type == 'send_money') {
  //     sharedPreferences.setStringList(AppConstants.SEND_MONEY_SUGGEST_LIST, suggests);
  //   }
  //   else if(type == 'request_money'){
  //     sharedPreferences.setStringList(AppConstants.REQUEST_MONEY_SUGGEST_LIST, suggests);
  //   }
  //   else if(type == "cash_out"){
  //     sharedPreferences.setStringList(AppConstants.RECENT_AGENT_LIST, suggests);
  //   }
  // }




}