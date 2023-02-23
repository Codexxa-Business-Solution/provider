import 'package:demandium_provider/feature/review/controller/review_controller.dart';
import 'package:demandium_provider/feature/review/repository/review_repo.dart';
import 'package:demandium_provider/feature/serviceman/controller/serviceman_details_controller.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => AuthController(authRepo:AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
    Get.lazyPut(() => UserProfileController( userRepo: UserRepo(Get.find(), apiClient: Get.find())));
    Get.lazyPut(() => DashboardController(dashBoardRepo: DashBoardRepo(apiClient: Get.find(),sharedPreferences: Get.find())));
    Get.lazyPut(() => ServicemanSetupController(servicemanRepo: ServicemanRepo(apiClient: Get.find())));
    Get.lazyPut(() => ReviewController(reviewRepo: ReviewRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServicemanDetailsController(
        servicemanRepo: ServicemanRepo(apiClient: Get.find()))
    );

  }
}