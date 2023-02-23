import 'dart:convert';

import 'package:demandium_provider/data/model/response/notification_body.dart';
import 'package:demandium_provider/feature/reporting/view/report_navigation_view.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/components/update_screen.dart';
import 'package:demandium_provider/feature/auth/binding/signup_binding.dart';
import 'package:demandium_provider/feature/service_details/model/service_details_model.dart';
import 'core_export.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String update = '/update';
  static const String profile = '/profile';
  static const String bankInfo = '/bank-info';
  static const String mySubscription = '/my-subscription';
  static const String html = '/html';
  static const String allServices = '/all-services';
  static const String serviceDetails = '/service-details';
  static const String bookingDetails = '/booking-details';
  static const String serviceManSetup = '/serviceManSetup';
  static const String addNewServicemanScreen = '/addNewServicemanScreen';
  static const String chatScreen = '/chat-screen';
  static const String chatInbox = '/chat-inbox';
  static const String serviceScreen = '/service-screen';
  static const String verificationScreen = '/otp-verification';
  static const String changePassword = '/change-password';
  static const String notification = '/notification';
  static const String profileInformation = '/profile-information';
  static const String transactions = '/transactions';
  static const String reporting = '/reporting';


  static String getInitialRoute() => initial;
  static String getSplashRoute(NotificationBody? body) {
    String _data = 'null';
    if(body != null) {
      List<int> _encoded = utf8.encode(jsonEncode(body));
      _data = base64Encode(_encoded);
    }
    return '$splash?data=$_data';
  }
  static String getLanguageRoute(String page) => '$language?page=$page';
  static String getReportingPageRoute(String page) => '$reporting?page=$page';
  static String getSignInRoute(String page) => '$signIn?page=$page';
  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';
  static String getVerificationRoute(String phone) => '$verificationScreen?phone=$phone';
  static String getChangePasswordRoute(String phone,String otp) => '$changePassword?phone=$phone&otp=$otp';
  static String getProfileRoute() => profile;
  static String getBankInfoRoute() => bankInfo;
  static String getMySubscriptionRoute() => mySubscription;
  static String getHtmlRoute({String? page,String? fromPage}) => '$html?page=$page&fromPage=$fromPage';
  static String getAllServicesRoute() => allServices;
  static String getServiceDetailsRoute(String serviceId,Discount discount) => '$serviceDetails?service_id=$serviceId';
  static String getBookingDetailsRoute(String bookingId, String bookingStatus, String fromPage) =>
      '$bookingDetails?booking_id=$bookingId&booking_status=$bookingStatus&fromPage=$fromPage';
  static String getChatScreenRoute(String channelId,String name,String image,String userType) =>
      '$chatScreen?channelID=$channelId&name=$name&image=$image&userType=$userType';

  static String getInboxScreenRoute() => '$chatInbox';
  static String getNotificationRoute({String? fromPage}) => '$notification?page=$fromPage';

  static List<GetPage> routes = [
    GetPage(binding: DashboardBinding(), name: initial, page: () => getRoute(HomeScreen(pageIndex: 0))),
    GetPage(name: splash, page: () {
      NotificationBody? _data;
      if(Get.parameters['data'] != 'null') {
        List<int> _decode = base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
        _data = NotificationBody.fromJson(jsonDecode(utf8.decode(_decode)));
      }
      return SplashScreen(body: _data != null ? _data:null);
    }),
    GetPage(name: profile, page: () => ProfileScreen(),binding: UserBinding()),
    GetPage(binding: ServicemanSetupBinding(), name: serviceManSetup, page: () => ServicemanSetupScreen()),
    GetPage(name: addNewServicemanScreen, page: () => AddNewServicemanScreen(),),
    GetPage(binding: BankInfoBinding(),name: profile, page: () => ProfileScreen()),
    GetPage(name: allServices, page: () => getRoute(AllServicesScreen())),

    GetPage(name: bookingDetails, binding: BookingBinding(),
        page: () => getRoute(BookingDetails(
            bookingStatus: Get.parameters['booking_status'].toString(),
            bookingId: Get.parameters['booking_id'].toString(),
            fromPage: Get.parameters['fromPage'],
        ))
    ),
    GetPage(name: notification, page: () => NotificationScreen(
        fromNotificationPage: Get.parameters['fromPage'].toString()
    )),
    GetPage(binding: MySubscriptionBinding(), name: mySubscription, page: () => SubscriptionScreen()),
    GetPage(name: signIn, page: () => SignInScreen(exitFromApp: false,)),
    GetPage(binding: SignupBinding(),name: signUp, page: () => SignUpScreen()),

    GetPage(binding: HtmlBindings(),name: html, page: () => HtmlViewerScreen(
      htmlType: Get.parameters['page'] == 'terms-and-condition' ? HtmlType.TERMS_AND_CONDITION
              : Get.parameters['page'] == 'privacy-policy' ? HtmlType.PRIVACY_POLICY
              : Get.parameters['page'] == 'refund-policy' ? HtmlType.REFUND_POLICY
              : Get.parameters['page'] == 'return-policy' ? HtmlType.RETURN_POLICY
              : Get.parameters['page'] == 'cancellation-policy' ? HtmlType.CANCELLATION_POLICY
              : HtmlType.ABOUT_US,
      fromNotificationPage: Get.parameters['fromPage'].toString()
    ),

    ),
    GetPage( name: chatScreen, page: () => getRoute(ConversationScreen(
        channelID: Get.parameters['channelID']!,
        name: Get.parameters['name']!,
        userType: Get.parameters['userType']!,
        image: Get.parameters['image']!)
    )),

    GetPage(name: chatInbox,binding: ConversationBinding(), page: () => InboxScreen()),
    GetPage(name: language, page: () => ChooseLanguageBottomSheet()),
    GetPage(name: reporting, page: () => ReportNavigationView()),
    GetPage(name: bankInfo,binding: BankInfoBinding(), page: () => BankInformation()),
    GetPage(name: verificationScreen, page:() => getRoute(VerificationScreen(number: Get.parameters['phone'].toString(),)),),
    GetPage(name: changePassword, page:() => getRoute(NewPassScreen(
            number: Get.parameters['phone'].toString(),
            otp: Get.parameters['otp'].toString()))
    ),

    GetPage(name: profileInformation, page:() => getRoute(ProfileInformationScreen(),)),
    GetPage(binding: TransactionBinding(),name:transactions, page:() => getRoute(TransactionScreen(),)),
    GetPage(name: update, page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
  ];
  static getRoute(Widget navigateTo) {
    // double _minimumVersion = 1.0;
    // if(GetPlatform.isAndroid) {
    //   if(Get.find<SplashController>().configModel.content!.minimumVersion!=null){
    //     _minimumVersion = double.parse(Get.find<SplashController>()
    //         .configModel.content!.minimumVersion!.minVersionForAndroid!.toString());
    //   }
    // }else if(GetPlatform.isIOS) {
    //   if(Get.find<SplashController>().configModel.content!.minimumVersion!=null){
    //     _minimumVersion = double.parse(Get.find<SplashController>().configModel.content!.minimumVersion!.minVersionForIos!.toString());
    //   }
    // }
    return  navigateTo;
  }
}