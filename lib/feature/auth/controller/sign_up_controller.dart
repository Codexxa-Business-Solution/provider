import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/helper/image_size_checker.dart';
import 'package:demandium_provider/feature/auth/model/zone_model.dart';


enum SignUpPageStep {step1, step2, step3}

class SignUpController extends GetxController{
  final AuthRepo authRepo;
  SignUpController({required this.authRepo}) {

  }

  bool? _isLoading = false;
  bool? _notification = true;
  bool? _acceptTerms = true;

  bool? get isLoading => _isLoading;
  bool? get notification => _notification;
  bool? get acceptTerms => _acceptTerms;

  double _identityImageSize=0;
  double get identityImageSize=> _identityImageSize;

  SignUpPageStep currentStep = SignUpPageStep.step1;



  List<XFile?>? _pickedIdentityImageList = [];
  List<XFile?>? get pickedIdentityImage => _pickedIdentityImageList;

  List<MultipartBody> _selectedIdentityImageList = [];
  List<MultipartBody> get selectedIdentityImageList => _selectedIdentityImageList;

  bool _keepPersonalInfoAsCompanyInfo = false;
  bool get keepPersonalInfoAsCompanyInfo => _keepPersonalInfoAsCompanyInfo;


  var companyNameController = TextEditingController();
  var companyPhoneController = TextEditingController();
  var companyAddressController = TextEditingController();
  var companyEmailController = TextEditingController();
  
  var contactPersonNameController = TextEditingController();
  var contactPersonPhoneController = TextEditingController();
  var contactPersonEmailController = TextEditingController();
  
  var  identityTypeController = TextEditingController();
  var identityNumberController = TextEditingController();
  
  var accountFirstNameController = TextEditingController();
  var accountLastNameController = TextEditingController();
  var accountEmailController = TextEditingController();
  var accountPhoneController = TextEditingController();
  var accountPasswordController = TextEditingController();
  var accountConfirmPasswordController = TextEditingController();

  String selectedIdentityType= "";
  String selectedZoneId = '';
  String selectedZoneName ="";

  List<ZoneData> zoneList=[];

  var countryDialCode;
  
  @override
  void onInit() {
    super.onInit();

    getZoneList();

    companyNameController.clear();
    companyPhoneController.clear();
    companyAddressController.clear();
    companyEmailController.clear();
    contactPersonNameController.clear();
    contactPersonPhoneController.clear();
    contactPersonEmailController.clear();
    identityTypeController.clear();
    identityNumberController.clear();
    accountFirstNameController.clear();
    accountLastNameController.clear();
    accountPhoneController.clear();
    accountEmailController.clear();
    accountPasswordController.clear();
    accountConfirmPasswordController.clear();
    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content!.countryCode!).dialCode;

  }

  Future<void> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.registration(signUpBody,_selectedIdentityImageList,_profileImageFile!);

    if (response!.statusCode == 200) {
      resetAllValue();
      Get.offNamed(RouteHelper.signIn);
      showCustomSnackBar("registered_successfully".tr,isError: false,duration: 5);
    } else if(response.statusCode== 400){
      if(response.body['errors'][0]['error_code']=='account_email'){
        showCustomSnackBar("the_account_email_has_already_been_taken".tr);
      }else if(response.body['errors'][0]['error_code']=='company_email'){
        showCustomSnackBar("the_company_email_has_already_been_taken".tr);
      } else if(response.body['errors'][0]['error_code']=='company_phone'){
        showCustomSnackBar("the_company_phone_has_already_been_taken".tr);
      } else if(response.body['errors'][0]['error_code']=='account_phone'){
        showCustomSnackBar("the_account_phone_has_already_been_taken".tr);
      }else{
        showCustomSnackBar("something_went_wrong".tr);
      }
    }
    _isLoading = false;
    update();
  }

  Future<void> getZoneList() async {
    Response? response = await authRepo.getZonesDataList();
    if (response!.statusCode == 200)
    {
      zoneList=[];
      response.body['content']['data'].forEach((element){
        zoneList.add(ZoneData.fromJson(element));
      });
    }
    else {
    }
    update();
  }
  XFile? _profileImageFile;
  XFile? get profileImageFile => _profileImageFile;

  void pickProfileImage(bool isRemove) async {
    if(isRemove){
      _profileImageFile =null;
    }
    else{
      _profileImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      double _imageSize = await ImageSize.getImageSize(_profileImageFile!);
      if(_imageSize >AppConstants.limitOfPickedImageSizeInMB){
        _profileImageFile =null;
        showCustomSnackBar("image_size_greater_than".tr);
      }
    }
    update();
  }
  XFile? pickedFile ;
  void pickImage() async {
    pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    update();
  }
    
  void pickIdentityImage(bool isRemove,{int? index}) async {
    if(isRemove) {
      if(index != null){
        _selectedIdentityImageList.removeAt(index);
        _pickedIdentityImageList =[];
      }
    }else{
      XFile pickedImage = (await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50))!;
      double _imageSize = await ImageSize.getImageSize(pickedImage);

      if(_imageSize > AppConstants.limitOfPickedImageSizeInMB){
        showCustomSnackBar("image_size_greater_than".tr);
      }else{
        print("Image path:- ${pickedImage.path}");
        if(pickedImage.path.contains('.gif')){
          showCustomSnackBar('can_not_upload_gif_file'.tr);
        }else{
          _selectedIdentityImageList.add(MultipartBody('identity_images[]',pickedImage));
        }
      }
      update();
    }
    update();
  }

  void resetAllValue(){
    companyNameController.clear();
    companyPhoneController.clear();
    companyEmailController.clear();
    companyAddressController.clear();
    contactPersonNameController.clear();
    contactPersonPhoneController.clear();
    contactPersonEmailController.clear();
    identityTypeController.clear();
    identityNumberController.clear();
    accountFirstNameController.clear();
    accountLastNameController.clear();
    accountPasswordController.clear();
    accountConfirmPasswordController.clear();
    accountEmailController.clear();
    accountPhoneController.clear();
    _profileImageFile=null;
    _pickedIdentityImageList= [];
    _keepPersonalInfoAsCompanyInfo =false;
    update();
  }

  void togglePersonalInfoAsCompanyInfo(){
    _keepPersonalInfoAsCompanyInfo =! _keepPersonalInfoAsCompanyInfo;

    if(keepPersonalInfoAsCompanyInfo){
      contactPersonNameController.text = companyNameController.text;
      contactPersonPhoneController.text = companyPhoneController.text;
      contactPersonEmailController.text = companyEmailController.text;
    }
    else{
      contactPersonNameController.text ="";
      contactPersonPhoneController.text ="";
      contactPersonEmailController.text ="";
    }
    update();
  }

  void setZoneData(String newZoneName,newZoneId){
    selectedZoneName =newZoneName;
    selectedZoneId = newZoneId;
    update();
  }

  void setIdentityType(String newIdentityType){
    selectedIdentityType =newIdentityType;
    update();
  }

  void updateRegistrationStep(SignUpPageStep _currentPage){
    currentStep=_currentPage;
    update();
  }

}