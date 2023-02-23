import 'package:demandium_provider/feature/serviceman/controller/serviceman_details_controller.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/image_size_checker.dart';
import 'package:demandium_provider/feature/serviceman/model/service_man_model.dart';
import '../../../core/helper/core_export.dart';

enum ServicemanTabControllerState {generalInfo,accountIno}

class ServicemanSetupController extends GetxController with GetSingleTickerProviderStateMixin {
  final ServicemanRepo servicemanRepo;
  ServicemanSetupController({required this.servicemanRepo});

  XFile? _pickedProfileImage;
  XFile? get pickedProfileImage => _pickedProfileImage;

  List<MultipartBody> _selectedIdentityImageList = [];
  List<MultipartBody> get selectedIdentityImageList => _selectedIdentityImageList;

  int selectedIndex =-1;
  int? currentServicemanIndex;

  bool _isLoading= false;
  bool get isLoading => _isLoading;

  bool _loading= false;
  bool get loading => _loading;

  String  selectedIdentityType = "";

  String _profileImage = '';
  String get profileImage => _profileImage;

  List<String> _identificationImage =[];
  List<String> get identificationImage => _identificationImage;

  List<ServicemanModel> _servicemanList =[];
  List<ServicemanModel> get servicemanList => _servicemanList;

  bool _isFromBookingDetailsPage = false;
  bool get isFromBookingDetailsPage => _isFromBookingDetailsPage;

  int _offset =1;
  int get offset => _offset;

  int _pageSize = 1;
  int get pageSize => _pageSize;

  int _totalServiceman=0;
  int get totalServiceman => _totalServiceman;


  var firstNameController = TextEditingController();
  var lastNameController= TextEditingController();
  var phoneController= TextEditingController();
  var identityNumberController= TextEditingController();
  var emailController= TextEditingController();
  var passController= TextEditingController();
  var confirmPasswordController= TextEditingController();
  String? countryDialCode="+880";


  var servicemanPageCurrentState = ServicemanTabControllerState.generalInfo;
  ScrollController scrollController = ScrollController();
  TabController? controller;

  List<Widget> servicemanDetailsTabs =[
    SizedBox(width: Get.width*.4,child: Tab(text: 'general_info'.tr)),
    SizedBox(width: Get.width*.4,child: Tab(text: 'account_info'.tr)),
  ];


  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      print("this is called");
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (_offset < _pageSize) {
          getAllServicemanList(_offset+1, reload: false);
        }
      }
    });
    controller = TabController(vsync: this, length: servicemanDetailsTabs.length,initialIndex: 0);
    selectedIndex = -1;
    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content!.countryCode!).dialCode??"+880";
  }


  Future<void> assignServiceman(String bookingId,String servicemanId,{bool reAssignServiceman = false}) async {
    _isLoading = true;
    update();
     Response response = await servicemanRepo.assignServiceman(bookingId, servicemanId);
     if(response.statusCode==200){
       Get.find<BookingDetailsController>().getBookingDetailsData(bookingId,reload: false);
       Get.find<BookingDetailsController>().showHideExpandView(0);
       if(_isFromBookingDetailsPage){
         showCustomSnackBar("service_man_re_assigned_successfully".tr,isError: false);
       }else{
         showCustomSnackBar("service_man_assigned_successfully".tr,isError: false);
       }
     }
     else{
       showCustomSnackBar(response.statusText);
     }

    _isLoading = false;
    update();
  }


  Future <void> addNewServiceman(ServicemanBody servicemanBody) async {
    _isLoading = true;
    update();
    Response? response = await servicemanRepo.addNewServiceman(
        servicemanBody,pickedProfileImage!=null?pickedProfileImage:null,
        _selectedIdentityImageList);
    if (response!.statusCode == 200) {
      _servicemanList =[];
      _selectedIdentityImageList=[];
      Get.back();
        showCustomSnackBar('serviceman_added_successfully'.tr,isError: false);
        clearAllData();
        if(_isFromBookingDetailsPage){
          getAllServicemanList(1, reload: true,status: "active");
        }else{
          getAllServicemanList(1, reload: true);
        }

    } else if(response.statusCode==400){
      showCustomSnackBar(response.body['errors'][0]['message']);
    }
    else {
      showCustomSnackBar(response.statusText);
    }

    _isLoading = false;
    update();
  }

  Future <void> editServicemanInfoWithPassword(ServicemanBody servicemanBody,String servicemanId) async {
    _isLoading = true;
    update();

    Response? response = await servicemanRepo.editServicemanInfoWithPassword(
        servicemanBody,pickedProfileImage??null, null,servicemanId);

    confirmPasswordController.text='';
    passController.text ='';
    
    if (response!.statusCode == 200) {
      selectedIndex=-1;
      Get.back();
      showCustomSnackBar('serviceman_password_updated'.tr,isError: false);
      getAllServicemanList(1, reload: true);
    } else if(response.statusCode==400){
      showCustomSnackBar('something_went_wrong'.tr);
    }
    else {
      showCustomSnackBar('something_went_wrong'.tr);
    }
    _isLoading = false;
    update();
  }

  Future <void> editServicemanInfoWithoutPassword(ServicemanBody servicemanBody,String servicemanId) async {
    _isLoading = true;
    update();

    Response? response = await servicemanRepo.editServicemanInfoWithoutPassword(
        servicemanBody, pickedProfileImage??null, _selectedIdentityImageList, servicemanId
    );
    _selectedIdentityImageList =[];
    if (response!.statusCode == 200) {

      selectedIndex=-1;
      getAllServicemanList(1,reload: true);
      Get.find<ServicemanDetailsController>().getServicemanDetails(servicemanId);
      Get.back();
      showCustomSnackBar('serviceman_info_updated'.tr,isError: false);
      
    } else if(response.statusCode==400){
      if(response.body['errors'][0]['error_code']=='email'){
        showCustomSnackBar("the_account_email_has_already_been_taken".tr);
      } else if(response.body['errors'][0]['error_code']=='phone'){
        showCustomSnackBar("the_account_phone_has_already_been_taken".tr);
      }else{
        showCustomSnackBar("something_went_wrong".tr);
      }
    }
    else {
      showCustomSnackBar('something_went_wrong'.tr);
    }
    _isLoading = false;
    update();
  }

  Future<void> getAllServicemanList(int offset, {bool reload = false,String status='all'}) async {
    _offset=offset;

    if(reload){
      _servicemanList =[];
      _isLoading= true;
    }
    update();
    Response response = await servicemanRepo.getAllServicemanData(offset,status);
    if(response.statusCode == 200){
       List<dynamic> _servicemanList = response.body['content']['data'];
       _servicemanList.forEach((serviceman) =>servicemanList.add(ServicemanModel.fromJson(serviceman)));
       _pageSize = response.body['content']['last_page'];
       _totalServiceman = response.body['content']['total'];
    }
    else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }



  Future<void> getSingleServicemanData({int? index,String? fromPage}) async {
    if(fromPage=='editPage'){

      firstNameController.text = servicemanList[index!].firstName!;
      lastNameController.text =  servicemanList[index].lastName!;
      phoneController.text = servicemanList[index].phone!;
      identityNumberController.text = servicemanList[index].identificationNumber!;
      selectedIdentityType = servicemanList[index].identificationType!;
      emailController.text = servicemanList[index].email!;
      _profileImage = servicemanList[index].profileImage!;
      _identificationImage = servicemanList[index].identificationImage!;
      updateIndex(-1);
      currentServicemanIndex = index;

    }else if(fromPage=='detailsPage'){
      firstNameController.text = Get.find<ServicemanDetailsController>().servicemanModel!.user!.firstName!;
      lastNameController.text =  Get.find<ServicemanDetailsController>().servicemanModel!.user!.lastName!;
      phoneController.text = Get.find<ServicemanDetailsController>().servicemanModel!.user!.phone!;
      identityNumberController.text = Get.find<ServicemanDetailsController>().servicemanModel!.user!.identificationNumber!;
      selectedIdentityType = Get.find<ServicemanDetailsController>().servicemanModel!.user!.identificationType!;
      emailController.text = Get.find<ServicemanDetailsController>().servicemanModel!.user!.email!;
      _profileImage = Get.find<ServicemanDetailsController>().servicemanModel!.user!.profileImage!;
      _identificationImage = Get.find<ServicemanDetailsController>().servicemanModel!.user!.identificationImage!;
    }

    else{
      firstNameController.clear();
      lastNameController.clear();
      phoneController.clear();
      identityNumberController.clear();
      emailController.clear();
      _profileImage ='';
      _pickedProfileImage =null;
      currentServicemanIndex = -1;
      _identificationImage =[];
      _selectedIdentityImageList=[];
      passController.clear();
      confirmPasswordController.clear();
      updateIndex(-1);
      selectedIdentityType ='';
    }
  }


  Future<void> deleteServiceman(String id) async {
    Response response = await servicemanRepo.deleteServiceman(id);
    if(response.statusCode==200 && response.body['response_code']=='default_delete_200'){
      _servicemanList =[];
        updateIndex(-1);
        Get.back();
        showCustomSnackBar('serviceman_delete'.tr,isError: false);
        getAllServicemanList(1, reload: true);
    }
    else{
      updateIndex(-1);
      Get.back();
      showCustomSnackBar(response.body['message']);
    }
  }


  Future<void> changeServicemanStatus(int index,String servicemanId,{bool fromDetailsPage = false}) async {
     if(fromDetailsPage){
        Get.find<ServicemanDetailsController>().updateActiveStatus();

     }else{
       int status = servicemanList[index].isActive==1?0:1;
       servicemanList[index].isActive=status;
       update();
     }
   Response response = await servicemanRepo.changeServicemanStatus(servicemanId);

   if(response.statusCode==200 && response.body['response_code']=='default_200'){
     updateIndex(-1);
   }
      update();
  }

  void pickProfileImage(bool isRemove) async {
    if(isRemove){
      _pickedProfileImage =null;
    }
    else{
      _pickedProfileImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      double _imageSize = await ImageSize.getImageSize(_pickedProfileImage!);
      if(_imageSize >AppConstants.limitOfPickedImageSizeInMB){
        _pickedProfileImage =null;
        showCustomSnackBar("image_size_greater_than".tr);
      }
    }
    update();
  }

  void pickIdentityImage(bool isRemove,{int? index}) async {
    if(isRemove) {
      if(index != null){
        _selectedIdentityImageList.removeAt(index);

      }
    }else{
      XFile pickedImage = (await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50))!;
      double _imageSize = await ImageSize.getImageSize(pickedImage);

      if(_imageSize > AppConstants.limitOfPickedImageSizeInMB){
        showCustomSnackBar("image_size_greater_than".tr);
      }else{
        if(pickedImage.path.contains('.gif')){
          showCustomSnackBar('can_not_upload_gif_file'.tr);
        }else {
          _selectedIdentityImageList.add(MultipartBody('identity_images[]', pickedImage));
        }
      }
      update();
    }
    update();
  }

  void updateTabControllerValue(ServicemanTabControllerState value){
    servicemanPageCurrentState = value;
    update();
  }

  void setValue(String value){
    selectedIdentityType =value;
    update();
  }
  void updateIndex(int index){
    selectedIndex = index;
    update();
  }

  void clearAllData(){
    _pickedProfileImage=null;
    passController.clear();
    confirmPasswordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    identityNumberController.clear();
    phoneController.clear();
    _selectedIdentityImageList=[];
  }

  void clearImageData(){
    _pickedProfileImage=null;
    _selectedIdentityImageList = [];
  }

  void fromBookingDetailsPage(bool fromBookingPage){
    _isFromBookingDetailsPage = fromBookingPage;
    update();
  }
}