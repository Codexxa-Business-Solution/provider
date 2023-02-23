import 'dart:convert';
import 'package:demandium_provider/feature/review/controller/review_controller.dart';
import 'package:demandium_provider/feature/review/repository/review_repo.dart';
import 'package:get/get.dart';
import 'core_export.dart';

Future<Map<String, Map<String, String>>> init() async{

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ReviewController(reviewRepo: ReviewRepo(apiClient: Get.find())));
  Get.lazyPut(() => SplashController(splashRepo: SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
  Get.lazyPut(() => LocalizationController(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => NotificationController(notificationRepo: NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find())));


  Map<String, Map<String, String>> _languages = Map();
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return _languages;
}
