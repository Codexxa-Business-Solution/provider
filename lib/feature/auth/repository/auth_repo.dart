import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response?> registration(SignUpBody signUpBody,List<MultipartBody> identityImage,XFile profileImage) async {
    return await apiClient.postMultipartData(AppConstants.REGISTER_URI, signUpBody.toJson(), identityImage, MultipartBody('logo', profileImage),);
  }

  Future<Response?> login({required String email_or_phone, required String password}) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"email_or_phone": email_or_phone, "password": password});
  }

  Future<Response?> otpVerification(String? phone,String otp) async {
    return await apiClient.postData(AppConstants.OTP_VERIFICATION_URI, {"phone_or_email": phone,'otp':otp});
  }
  Future<Response?> updateToken() async {

    String? _deviceToken;
    if (GetPlatform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false,
        criticalAlert: false, provisional: false, sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
      }
    }else {
      _deviceToken = await _saveDeviceToken();
    }
    if(!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      FirebaseMessaging.instance.subscribeToTopic('${AppConstants.TOPIC}-${Get.find<UserProfileController>().myZoneId}');
    }
    return await apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "fcm_token": _deviceToken});
  }

  Future<String?> _saveDeviceToken() async {
    String? _deviceToken = '@';
    if(!GetPlatform.isWeb) {
      try {
        _deviceToken = await FirebaseMessaging.instance.getToken();
      }catch(e) {
        print('token error : $e');
      }
    }
    if (_deviceToken != null) {
      print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken;
  }

  Future<Response?> forgetPassword(String? phone) async {
    return await apiClient.postData(AppConstants.FORGET_PASSWORD_URI, {"phone_or_email": phone});
  }

  Future<Response?> verifyToken(String phone, String token) async {
    return await apiClient.postData(AppConstants.VERIFY_TOKEN_URI, {"phone": phone, "reset_token": token});
  }

  Future<Response?> resetPassword(String phone, String otp, String password, String confirmPassword) async {
    return await apiClient.putData(
      AppConstants.RESET_PASSWORD_URI,
      {"_method": "put", "phone_or_email": phone, "otp": otp, "password": password, "confirm_password": confirmPassword},
    );
  }

  Future<bool?> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token, sharedPreferences.getString(AppConstants.LANGUAGE_CODE));
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedData() {
    if(!GetPlatform.isWeb) {
      FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
      FirebaseMessaging.instance.unsubscribeFromTopic('${AppConstants.TOPIC}-${Get.find<UserProfileController>().myZoneId}');
    }
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
    apiClient.token = null;
    apiClient.updateHeader(null, null);
    return true;
  }
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
    } catch (e) {
      throw e;
    }
  }

  toggleNotificationSound(bool isNotification){
    sharedPreferences.setBool(AppConstants.NOTIFICATION, isNotification);
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }

  Future<Response?> getZonesDataList() async {
    return await apiClient.getData(AppConstants.ZONE_URI+'?limit=200&offset=1');
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  void setRememberMeValue(bool _rememberMeValue) {
    sharedPreferences.setBool(AppConstants.IS_REMEMBER_ACTIVE, _rememberMeValue);
  }
  bool? getRememberMeValue() {
    return sharedPreferences.getBool(AppConstants.IS_REMEMBER_ACTIVE);
  }
}
