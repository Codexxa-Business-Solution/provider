import 'package:demandium_provider/data/model/response/api_response_model.dart';
import 'package:demandium_provider/feature/transaction/model/withdraw_model.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/transaction/model/transactions_model.dart';



class TransactionController extends GetxController implements GetxService{

  final TransactionRepo transactionRepo;
  TransactionController({required this.transactionRepo});

  int? _pageSize;
  int _offset = 1;

  int get offset => _offset;
  int? get pageSize => _pageSize;

  bool _isLoading= false;
  bool get isLoading => _isLoading;

  bool? _paginationLoading = false;
  bool? get paginationLoading => _paginationLoading;

  List<TransactionData>? _transactionsList =[];
  List<TransactionData>? get transactionsList => _transactionsList;

  String? _defaultPaymentMethodId;
  String? _defaultPaymentMethodName;

  String? get  defaultPaymentMethodId => _defaultPaymentMethodId;
  String? get  defaultPaymentMethodName => _defaultPaymentMethodName;

  WithdrawModel? _withdrawModel;
  WithdrawModel? get withdrawModel => _withdrawModel;

  List<WithdrawalMethod>? _withdrawalMethods;
  List<WithdrawalMethod>? get withdrawalMethods => _withdrawalMethods;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getTransactionList(1,false);
    super.onInit();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if(_offset < _pageSize! ) {
          getTransactionList(offset+1,true);
        }
      }
    });
  }

  Future<void> getTransactionList(int offset,bool isFormPagination) async {
    _offset = offset;
    update();
    if(!isFormPagination){
      _transactionsList = [];
      _isLoading = true;
    }else{
      _paginationLoading = true;
    }
    Response response = await transactionRepo.getTransactionsList(offset);
    if(response.statusCode==200){
      _pageSize =response.body['content']['withdraw_requests']['last_page'];
     List<dynamic> _transactionList = response.body['content']['withdraw_requests']['data'];
     _transactionList.forEach((element) {
         transactionsList!.add(TransactionData.fromJson(element));
     });
    }
    else{
      print(response.statusCode);
    }
    _paginationLoading = false;
    _isLoading = false;
    update();
  }

  Future<void> withDrawRequest({Map<String, String>? placeBody})async{
    _isLoading = true;
    update();
    Response response = await transactionRepo.withdrawRequest(placeBody: placeBody);
    ResponseModelApi _responseModelApi = ResponseModelApi.fromJson(response.body);
    if(response.statusCode == 200 && _responseModelApi.responseCode == 'default_200' ){
      await Get.find<UserProfileController>().getProviderInfo(reload: true);
      Get.find<TransactionController>().getTransactionList(1, false);
      Get.back();
      Get.back();
      showCustomSnackBar('withdraw_request_send_successful'.tr, isError: false);
    }else{
      Get.back();
      showCustomSnackBar(_responseModelApi.message ?? 'error', isError: true);

    }
    _isLoading = false;
    update();

  }


  Future<void> getWithdrawMethods({bool isReload = false}) async{
    if(_withdrawModel == null || isReload) {
      Response response = await transactionRepo.getWithdrawMethods();
      ResponseModelApi _responseApi = ResponseModelApi.fromJson(response.body);

      if(_responseApi.responseCode == 'default_200' && _responseApi.content != null) {
        _withdrawModel = WithdrawModel.fromJson(response.body);

        _withdrawModel?.withdrawalMethods?.forEach((element) {
          if(element.isDefault==1){
            _defaultPaymentMethodId = element.id;
            _defaultPaymentMethodName = element.methodName;
          }
        });
      }else{
        _withdrawModel = WithdrawModel(withdrawalMethods: [],);
        ApiChecker.checkApi(response);
      }
    }
    update();
  }
  String? _selectAmount;
  String? get selectAmount => _selectAmount;
  int _transactionTypeIndex = -1;
  int get transactionTypeIndex => _transactionTypeIndex;


  void setIndex(int index , String amount) {
    _transactionTypeIndex = index;
    _selectAmount = amount;
    update();
  }

  void selectAmountSet(String value) {
    _selectAmount = value;
    update(['inputAmountListController']);
  }
}