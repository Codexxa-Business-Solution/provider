import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/auth/model/zone_model.dart';
import 'package:demandium_provider/feature/profile/model/provider_model.dart';


class UserProfileController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserProfileController({required this.userRepo});

  final GlobalKey<FormState> profileInformationFormKey = GlobalKey<FormState>();
  TextEditingController? companyNameController,companyPhoneController,companyAddressController,companyEmailController,
      personalNameController,personalPhoneController,personalEmailController,
      emailController, passwordController,confirmPasswordController;

  bool keepPersonalInfoAsCompanyInfo = false;

  String _providerId = '';
  String get providerId =>_providerId;

  var countryDialCode;

  String _selectedZoneID ='';
  String get selectedZoneID => _selectedZoneID;

  String _selectedZoneName ="";
  String get selectedZoneName => _selectedZoneName;

  String myZone='';
  String? myZoneId;

  List<ZoneData> zoneList=[];

  int _totalCompleteRequest= 0;
  int _totalCanceledRequest= 0;
  int _totalOngoingRequest= 0;
  int _totalAcceptedRequest= 0;

  int get totalCompletedRequest=> _totalCompleteRequest;
  int get totalCanceledRequest=> _totalCanceledRequest;
  int get totalOngoingRequest=> _totalOngoingRequest;
  int get totalAcceptedRequest=> _totalAcceptedRequest;


  @override
  void onInit() {
    super.onInit();
    getProviderInfo();
    companyNameController = TextEditingController();
    companyPhoneController = TextEditingController();
    companyAddressController = TextEditingController();
    companyEmailController = TextEditingController();

    personalNameController = TextEditingController();
    personalPhoneController = TextEditingController();
    personalEmailController = TextEditingController();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.content!.countryCode!).dialCode;
  }

  @override
  void onClose() {
    companyNameController!.dispose();
    companyPhoneController!.dispose();
    companyAddressController!.dispose();
    companyEmailController!.dispose();
    personalNameController!.dispose();
    personalPhoneController!.dispose();
    personalEmailController!.dispose();

    emailController!.dispose();
    passwordController!.dispose();
    confirmPasswordController!.dispose();
  }


  void togglePersonalInfoAsCompanyInfo(){
    keepPersonalInfoAsCompanyInfo =! keepPersonalInfoAsCompanyInfo;

    if(keepPersonalInfoAsCompanyInfo){
      personalNameController!.text = companyNameController!.text;
      personalPhoneController!.text = companyPhoneController!.text;
      personalEmailController!.text = companyEmailController!.text;
    }
    else{
        personalNameController!.text ="";
        personalPhoneController!.text ="";
        personalEmailController!.text="";
    }
    update();
  }

   ProviderModel? _providerModel;
   XFile? _pickedFile ;
   bool _isLoading = false;

  ProviderModel? get providerModel => _providerModel;
  XFile? get pickedFile => _pickedFile;
  bool get isLoading => _isLoading;

  Future<void> getProviderInfo({reload = false}) async {

    if(_providerModel==null || reload){
      Response response = await userRepo.getProviderInfo();
      if (response.statusCode == 200) {
        getZoneList();
        _providerModel = ProviderModel.fromJson(response.body);
        companyNameController!.text = _providerModel!.content!.providerInfo!.companyName??'';
        companyPhoneController!.text = _providerModel!.content!.providerInfo!.companyPhone??"".replaceFirst(countryDialCode, '');
        companyAddressController!.text = _providerModel!.content!.providerInfo!.companyAddress??"";
        companyEmailController!.text = _providerModel!.content!.providerInfo!.companyEmail??"";
        personalNameController!.text = _providerModel!.content!.providerInfo!.contactPersonName??"";
        personalPhoneController!.text = _providerModel!.content!.providerInfo!.contactPersonPhone??"".replaceFirst(countryDialCode, '');
        personalEmailController!.text = _providerModel!.content!.providerInfo!.contactPersonEmail??"";
        emailController!.text = _providerModel!.content!.providerInfo!.owner!.email??"";
        _totalCompleteRequest= 0;
        _totalCanceledRequest= 0;
        _totalOngoingRequest= 0;
        _totalAcceptedRequest= 0;

        _providerId = _providerModel!.content!.providerInfo!.id!;
        myZoneId =_providerModel!.content!.providerInfo!.zoneId!;
        _selectedZoneID = myZoneId!;
        if(companyNameController!.text==personalNameController!.text
            && companyPhoneController!.text==personalPhoneController!.text
            &&companyEmailController!.text==personalEmailController!.text){
          keepPersonalInfoAsCompanyInfo = true;
        }else{
          keepPersonalInfoAsCompanyInfo = false;
        }

        if(_providerModel!.content!.bookingOverview!=[] && _providerModel!.content!.bookingOverview!=null){
          _providerModel!.content!.bookingOverview!.forEach((element) {
            if(element.bookingStatus=='accepted'){
              _totalAcceptedRequest = element.total!;
            }else if(element.bookingStatus=="canceled"){
              _totalCanceledRequest = element.total!;
            }else if(element.bookingStatus=="completed"){
              _totalCompleteRequest = element.total!;
            }else if(element.bookingStatus=="ongoing"){
              _totalOngoingRequest = element.total!;
            }
          });
        }else{
          _totalCompleteRequest= 0;
          _totalCanceledRequest= 0;
          _totalOngoingRequest= 0;
          _totalAcceptedRequest= 0;
        }
        _isLoading= false;
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    }
    _isLoading = false;
    update();

  }

  Future<ResponseModel> updateProfile() async {
    _isLoading = true;
    update();

    Response response = await userRepo.updateProfile(
        companyNameController!.text.toString(),
        companyPhoneController!.text.toString(),
        companyAddressController!.text.toString(),
        companyEmailController!.text.toString(),
        personalNameController!.text.toString(),
        personalPhoneController!.text.toString(),
        personalEmailController!.text.toString(),
        _selectedZoneID,
        _pickedFile??null
    );
    if(response.statusCode==200){

      if(companyNameController!.text==personalNameController!.text
          && companyPhoneController!.text==personalPhoneController!.text
          &&companyEmailController!.text==personalEmailController!.text){
        keepPersonalInfoAsCompanyInfo = true;
      }else{
        keepPersonalInfoAsCompanyInfo = false;
      }

      _isLoading=false;
      update();
     return ResponseModel(true, response.body['message']);
    }
    else{
      _isLoading = false;
      update();
     return  ResponseModel(false, response.body['errors'][0]['message']);
    }
  }

  Future<ResponseModel> updateProfileWithPassword() async {
    _isLoading = true;
    update();

    Response response = await userRepo.updateProfileWithPassword(
      companyNameController!.text.toString(),
      companyPhoneController!.text.toString(),
      companyAddressController!.text.toString(),
      companyEmailController!.text.toString(),
      personalNameController!.text.toString(),
      personalPhoneController!.text.toString(),
      personalEmailController!.text.toString(),
      passwordController!.text,
      confirmPasswordController!.text,
      _selectedZoneID,
    );

    if(response.statusCode==200){
      _isLoading=false;
      update();
      return  ResponseModel(true, response.body['message']);

    }
    else{
      _isLoading = false;
      update();
      return  ResponseModel(false, response.body['errors'][0]['message']);
    }
  }

  Future<void> getZoneList() async {
    _selectedZoneName ='';
    if(zoneList.isEmpty){
      Response? response = await userRepo.getZonesDataList();
      if (response!.statusCode == 200)
      {
        zoneList=[];

        List<dynamic>? _zoneList = response.body['content']['data'];

        if(_zoneList!=null && _zoneList.isNotEmpty){
          _zoneList.forEach((element){
            zoneList.add(ZoneData.fromJson(element));
          });
        }

        if(zoneList.isNotEmpty && _providerModel!=null){
          zoneList.forEach((element) {
            if(element.id==_providerModel!.content!.providerInfo!.zoneId!){
              myZone = element.name!;
            }
          });
        }
      }
      else {
      }
      update();
    }

  }

  void setNewZoneValue(String zoneName,zoneId){
    _selectedZoneName =zoneName;
    _selectedZoneID = zoneId;
    update();
  }

  void pickImage() async {
    _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    update();
  }
}