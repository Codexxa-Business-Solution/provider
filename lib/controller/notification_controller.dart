// import 'package:get/get.dart';
// import 'package:demandium_provider/data/model/response/notification_model.dart';
// import 'package:demandium_provider/data/provider/checker_api.dart';
// import 'package:demandium_provider/data/repository/notification_repo.dart';
//
// class NotificationController extends GetxController implements GetxService {
//   final NotificationRepo notificationRepo;
//   NotificationController({required this.notificationRepo});
//
//   List<NotificationModel> _notificationList = [];
//   List<NotificationModel> get notificationList => _notificationList;
//
//   // Future<void> getNotificationList() async {
//   //   Response response = await notificationRepo.getNotificationList();
//   //   if (response.statusCode == 200) {
//   //     _notificationList = [];
//   //     List<dynamic> _notifications = response.body.reversed.toList();
//   //     _notifications.forEach((notification) {
//   //       NotificationModel _notification = NotificationModel.fromJson(notification);
//   //       _notification.title = notification['data']['title'];
//   //       _notification.description = notification['data']['description'];
//   //       _notification.image = notification['data']['image'];
//   //       _notificationList.add(_notification);
//   //     });
//   //   } else {
//   //     ApiChecker.checkApi(response);
//   //   }
//   //   update();
//   // }
//
//   void saveSeenNotificationCount(int count) {
//     notificationRepo.saveSeenNotificationCount(count);
//   }
//
//   int? getSeenNotificationCount() {
//     return notificationRepo.getSeenNotificationCount();
//   }
//
//   void clearNotification() {
//     _notificationList = [];
//   }
// }
