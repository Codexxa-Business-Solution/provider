import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class  MySubscriptionController extends GetxController implements GetxService{
  final UserRepo userRepo;
  final MySubscriptionRepo mySubscriptionRepo;
  MySubscriptionController({required this.mySubscriptionRepo,required this.userRepo});

  bool _isLoading= false;
  bool get isLoading => _isLoading;

  bool _isPaginationLoading= false;
  bool get isPaginationLoading => _isPaginationLoading;

  bool _isSubscribeButtonLoading= false;
  bool get isSubscribeButtonLoading => _isSubscribeButtonLoading;

  int _subscriptionIndex=-1;
  int get  selectedSubscriptionIndex => _subscriptionIndex;

  List<SubscriptionModelData> _subscriptionList=[];
  List<SubscriptionModelData> get subscriptionList=> _subscriptionList;

  int? _pageSize;
  int? get pageSize => _pageSize;

  int _offset = 1;
  int get offset => _offset;

  int _totalSubscription = 0;
  int? get totalSubscription => _totalSubscription;

  ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    super.onInit();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if(_offset < _pageSize! ) {
          getMySubscriptionData(offset+1, true);
        }
      }
    });
  }

  Future<void> getMySubscriptionData(int offset, bool isFormPagination) async {
    _offset = offset;
    if(!isFormPagination){
      _subscriptionList =[];
      _isLoading = true;
      update();
    }
    else{
      _isPaginationLoading = true;
      update();
    }
      Response _response = await mySubscriptionRepo.getSubscriptionListData(offset);
      if(_response.statusCode==200){
        List<dynamic> _list =_response.body['content']['data'];
        //_list.forEach((element)=> _subscriptionList.add(SubscriptionModelData.fromJson(element)));
        _list.forEach((element){
          if(element['sub_category']!=null){
            _subscriptionList.add(SubscriptionModelData.fromJson(element));
          }
        });
        _pageSize  = _response.body['content']['last_page'];
        _totalSubscription = _response.body['content']['total'];
      }
      else{
        showCustomSnackBar(_response.statusText);
      }
    _isPaginationLoading = false;
    _isLoading = false;
    update();
  }

  Future<void> unsubscribeCategory(String id,int index) async {
    _isSubscribeButtonLoading = true;
    update();
    Response response = await mySubscriptionRepo.changeSubscriptionStatus(id);
    if(response.statusCode==200){
      subscriptionList.removeAt(index);
      _totalSubscription--;
    }
    _isSubscribeButtonLoading = false;
    update();
  }

  void changeSubscriptionIndex(int subscriptionIndex){
    _subscriptionIndex = subscriptionIndex;
    update();
  }
}