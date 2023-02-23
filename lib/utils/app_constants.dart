import 'package:demandium_provider/data/model/response/language_model.dart';
import 'package:demandium_provider/utils/images.dart';

class AppConstants {
  static const String APP_NAME = 'Provider';
  static const String APP_USER = '';
  static const String APP_VERSION = '1.2';
  static const String BASE_URL = 'https://urbanclap.bizz-manager.com';
  static const String CONFIG_URI = '/api/v1/provider/config';
  static const String FORGET_PASSWORD_URI = '/api/v1/provider/forgot-password';
  static const String VERIFY_TOKEN_URI = '/api/v1/auth/verify-token';
  static const String RESET_PASSWORD_URI = '/api/v1/provider/reset-password';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';
  static const String REGISTER_URI = '/api/v1/provider/auth/registration';
  static const String LOGIN_URI = '/api/v1/provider/auth/login';
  static const String DASHBOARD_URI = '/api/v1/provider/dashboard';
  static const String SERVICEMAN_LIST_URI = '/api/v1/provider/serviceman';
  static const String SERVICEMAN_DETAILS_URI = '/api/v1/provider/serviceman';
  static const String SERVICEMAN_DELETE_URI = '/api/v1/provider/serviceman/delete';
  static const String NEW_SERVICEMAN_Add_URI = '/api/v1/provider/serviceman';
  static const String SERVICEMAN_UPDATE_URI = '/api/v1/provider/serviceman';
  static const String SERVICEMAN_ASSIGN_URI = '/api/v1/provider/booking/assign-serviceman';
  static const String SERVICEMAN_CHANGE_STATUS = '/api/v1/provider/serviceman/status/update';
  static const String PROVIDER_PROFILE_URL = '/api/v1/provider/account/overview';
  static const String PROVIDER_PROFILE_UPDATE_URL = '/api/v1/provider/update/profile';
  static const String BOOKING_LIST_URL = '/api/v1/provider/booking';
  static const String BOOKING_DETAILS_URL = '/api/v1/provider/booking';
  static const String BOOKING_ACCEPT_STATUS_URL = '/api/v1/provider/booking/request-accept';
  static const String CHANGE_BOOKING_STATUS_URL = '/api/v1/provider/booking/status-update';
  static const String BANK_DETAILS_URL = '/api/v1/provider/get-bank-details';
  static const String UPDATE_BANK_DETAILS_URL = '/api/v1/provider/update-bank-details';
  static const String SERVICE_CATEGORY_URL = '/api/v1/provider/category';
  static const String SERVICE_SUB_CATEGORY_URL = '/api/v1/provider/category/childes';
  static const String SERVICE_DETAILS_URL = '/api/v1/provider/service';
  static const String SERVICE_FAQ_URL = '/api/v1/provider/faq';
  static const String CHANGE_SUBSCRIPTION_STATUS_URL = '/api/v1/provider/service/update-subscription';
  static const String CHANGE_SCHEDULE_URL = '/api/v1/provider/booking/schedule-update';
  static const String SUBSCRIPTION_LIST_URL = '/api/v1/provider/subscribed/sub-categories';
  static const String OTP_VERIFICATION_URI = '/api/v1/provider/otp-verification';
  static const String NOTIFICATION_URI = '/api/v1/provider/notifications';
  static const String ZONE_URI = '/api/v1/zones';
  static const String TOKEN_URI = '/api/v1/provider/update/fcm-token';
  static const String WITHDRAW_REQUEST = '/api/v1/provider/withdraw';
  static const String WITHDRAW_REQUEST_METHOD = '/api/v1/provider/withdraw/methods';
  static const String CREATE_CHANNEL = '/api/v1/provider/chat/create-channel';
  static const String GET_CHANNEL_LIST = '/api/v1/provider/chat/channel-list';
  static const String GET_CONVERSATION = '/api/v1/provider/chat/conversation';
  static const String SEND_MESSAGE = '/api/v1/provider/chat/send-message';
  static const String GET_SERVICE_REVIEW_LIST = '/api/v1/provider/service/review';
  static const String GET_PROVIDER_REVIEW_LIST = '/api/v1/provider/review';
  static const String PAGES = '/api/v1/customer/config/pages';
  static const String GET_TRANSACTION_REPORT_DATA = '/api/v1/provider/report/transaction';
  static const String GET_BOOKING_REPORT_DATA = '/api/v1/provider/report/booking';
  static const String GET_BUSINESS_EXPENSE_DATA = '/api/v1/provider/report/business/expense';
  static const String GET_BUSINESS_EARNING_DATA = '/api/v1/provider/report/business/earning';
  static const String GET_BUSINESS_OVERVIEW_DATA = '/api/v1/provider/report/business/overview';


  static const String BUSINESS_LOGO_PATH = '/business/';
  static const String CATEGORY_IMAGE_PATH = '/category/';
  static const String PUSH_NOTIFICATION_IMAGE_PATH = '/push-notification/';
  static const String SERVICE_IMAGE_PATH = '/service/';

  static const String CUSTOMER_PROFILE_IMAGE_PATH = '/user/profile_image/';
  static const String PROVIDER_PROFILE_IMAGE_PATH = '/provider/logo/';
  static const String PROVIDER_IDENTITY_IMAGE_PATH = '/provider/identity/';
  static const String SERVICEMAN_PROFILE_IMAGE_PATH = '/serviceman/profile/';
  static const String SERVICEMAN_IDENTITY_IMAGE_PATH = '/serviceman/identity/';
  static const String ADMIN_PROFILE_IMAGE_PATH = '/user/profile_image/';
  static const String CONVERSATION_IMAGE_PATH = '/conversation/';

  static const String THEME = 'demand_theme';
  static const String TOKEN = 'demand_token';
  static const String COUNTRY_CODE = 'demand_country_code';
  static const String LANGUAGE_CODE = 'demand_language_code';
  static const String USER_PASSWORD = 'demand_user_password';
  static const String USER_ADDRESS = 'demand_user_address';
  static const String USER_NUMBER = 'demand_user_number';
  static const String NOTIFICATION = 'demand_notification';
  static const String IS_REMEMBER_ACTIVE = 'is_remember_active';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String INTRO = 'intro';
  static const String TOPIC = 'provider-admin';
  static const String LOCALIZATION_KEY = 'X-localization';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.us, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.ar, languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
  ];
  static const List<String> inputAmountList =  [ '500', '1,000', '2,000', '5,000', '10,000', '57,0059'];
  static const  List<String> identityTypeList = [
    "passport",
    "nid",
    "trade_license",
    "driving_license",
    "company_id"
  ];
  static const int limitOfPickedIdentityImageNumber = 2;
  static const double limitOfPickedImageSizeInMB = 2;
  static const double BALANCE_INPUT_LEN = 10;
}
