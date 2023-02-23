import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo}) {
  }

  bool? _isLoading = false;
  bool? _notification = true;

  bool? get isLoading => _isLoading;
  bool? get notification => _notification;

  bool? _isActiveRememberMe =false ;
  bool? get isActiveRememberMe => _isActiveRememberMe;

  Future<void> login(String email_or_phone, String password) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.login(email_or_phone: email_or_phone, password: password);
    if (response!.statusCode == 200) {
      if (isActiveRememberMe!) {
        authRepo.saveUserNumberAndPassword(email_or_phone, password);
      } else {
        authRepo.clearUserNumberAndPassword();
      }
      authRepo.saveUserToken(response.body['content']["token"]);
      authRepo.updateToken().then((value) => Get.find<UserProfileController>().getProviderInfo());
      Get.offNamed(RouteHelper.initial);
      showCustomSnackBar("successfully_logged_in".tr,isError: false);
    }
    else if(response.statusCode==1){
      showCustomSnackBar("no_internet_connection".tr);
    }
    else if(response.body['response_code']=='auth_login_401' && response.statusCode==401){
      showCustomSnackBar('auth_login_401'.tr);
    }else if(response.body['response_code']=='default_user_disabled_401' && response.statusCode==401){
      showCustomSnackBar('default_user_disabled_401'.tr,duration: 3);
    }else if(response.body['response_code']=='auth_login_404' && response.statusCode==404){
      showCustomSnackBar('auth_login_404'.tr);
    }
    else {
      showCustomSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel> forgetPassword(String phone) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.forgetPassword(phone);

    if (response!.statusCode == 200) {
      if(response.body["response_code"]=="default_200"){
        Get.toNamed(RouteHelper.getVerificationRoute(phone));
        _isLoading = false;
        update();
      }
      else{
        _isLoading = false;
        update();
        showCustomSnackBar("phone_not_found".tr);
      }

      return ResponseModel(true, "");
    } else {
        showCustomSnackBar(response.statusText);
        _isLoading = false;
        update();
        return ResponseModel(false, "");
    }
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<void> resetPassword(String phone, String otp, String password, String confirmPassword) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.resetPassword(phone, otp, password, confirmPassword);

    if (response!.statusCode == 200) {
      Get.offNamed(RouteHelper.signIn);
      showCustomSnackBar('password_changed_successfully'.tr,isError: false);
    } else {

    }
    _isLoading = false;
    update();
  }

  Future<ResponseModel>  otpVerification(String phone,String otp) async {
    _isLoading = true;
    update();
    Response? response = await authRepo.otpVerification(phone,otp);
    ResponseModel responseModel;
    if (response!.statusCode == 200 && response.body['response_code']=="default_verified_200") {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, "otp_does_not_match".tr);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  String _verificationCode = '';
  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }
  bool isNotificationActive() {
    return authRepo.isNotificationActive();

  }

  toggleNotificationSound(){
    authRepo.toggleNotificationSound(!isNotificationActive());
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe!;
    authRepo.setRememberMeValue(_isActiveRememberMe!);
    update();
  }

  bool? getRememberMeValue() {
    return authRepo.getRememberMeValue();
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }
}