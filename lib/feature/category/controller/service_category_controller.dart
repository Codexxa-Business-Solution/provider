import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class ServiceCategoryController extends GetxController implements GetxService{
  final ServiceRepo allServiceRepo;
  ServiceCategoryController({required this.allServiceRepo});

  int  _selectedCategoryIndex= 0;
  int _subscriptionIndex=-1;
  int get  selectedSubscriptionIndex => _subscriptionIndex;

  int get  selectedCategory => _selectedCategoryIndex;
  bool _isCategoryLoading= false;
  bool _isSubCategoryLoading = false;
  bool _isSubscriptionLoading = false;
  bool _isPaginationLoading = false;
  int? subscriptionStatus;

  bool get isLoading => _isCategoryLoading;
  bool get isSubCategoryLoading => _isSubCategoryLoading;
  bool get isSubscriptionLoading => _isSubscriptionLoading;
  bool get isPaginationLoading => _isPaginationLoading;

  List<ServiceCategoryModel> serviceCategoryList =[];
  List<ServiceSubCategoryModel> serviceSubCategoryList =[];

  int _offset = 1;
  int get offset => _offset;

  int _pageSize =1;
  int get pageSize => _pageSize;


  final ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    super.onInit();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if(_offset < _pageSize ) {
          if(serviceCategoryList.length>0) getSubCategoryList(offset: _offset+1,isFromPagination: true);
        }
      }
    });
  }
  
  Future<void> getCategoryList() async {
    _isCategoryLoading = true;
    update();
    Response response = await allServiceRepo.getCategoryList();
    if(response.statusCode == 200){

      serviceCategoryList = [];
      List<dynamic> _serviceCategoryList = response.body['content']['data'];
      _serviceCategoryList.forEach((category) =>serviceCategoryList.add(ServiceCategoryModel.fromJson(category)));

      if(serviceCategoryList.length>0)getSubCategoryList(offset: 1, isFromPagination: false);
    }
    else {
      ApiChecker.checkApi(response);
    }
    _isCategoryLoading = false;
    update();
  }

  Future<void> getSubCategoryList({required int offset, bool isFromPagination = false}) async {

    _offset = offset;
    if(!isFromPagination){
      serviceSubCategoryList = [];
      _isSubCategoryLoading = true;
      update();
    }
    _isPaginationLoading = true;
    update();

    Response response = await allServiceRepo.getSubCategoryList(serviceCategoryList[selectedCategory].id.toString(), offset);
    if(response.statusCode == 200){
      if(!isFromPagination){
        serviceSubCategoryList = [];
      }

      List<dynamic> _serviceSubCategoryList = response.body['content']['data'];
      _serviceSubCategoryList.forEach((subCategory) =>serviceSubCategoryList.add(ServiceSubCategoryModel.fromJson(subCategory)));
      _pageSize = response.body['content']['last_page'];
    }
    else {
      ApiChecker.checkApi(response);
    }
    _isSubCategoryLoading = false;
    _isPaginationLoading = false;
    update();
  }




  Future<void> changeSubscriptionStatus(String id, int index,bool isFromSubcategoryList) async {
      _isSubscriptionLoading = true;
      update();
      Response response  = await allServiceRepo.changeSubscriptionStatus(id);

      if(response.statusCode==200){
        if(isFromSubcategoryList){
          int statusValue = serviceSubCategoryList[index].isSubscribed == 1? 0 : 1;
          serviceSubCategoryList[index].isSubscribed = statusValue;
          Get.find<MySubscriptionController>().getMySubscriptionData(1,false);

        }
        else{
          int statusValue = Get.find<MySubscriptionController>().subscriptionList[index].isSubscribed == 1? 0 : 1;
          Get.find<MySubscriptionController>().subscriptionList[index].isSubscribed = statusValue;
          Get.find<MySubscriptionController>().getMySubscriptionData(1,false);
          Get.back();

        }
      }
      else{
        showCustomSnackBar(response.statusText);
      }
      changeSubscriptionIndex(-1);
      _isSubscriptionLoading = false;
      update();

  }


  void changeCategory(int categoryIndex){
    _selectedCategoryIndex = categoryIndex;
    update();
  }

  void changeSubscriptionIndex(int subscriptionIndex){
    _subscriptionIndex = subscriptionIndex;
    update();
  }

  void toggleSubscriptionStatus(int _subscriptionStatus){
    subscriptionStatus= _subscriptionStatus;
    update();
  }
}