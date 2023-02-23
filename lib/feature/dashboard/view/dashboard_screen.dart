import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}
class _DashBoardScreenState extends State<DashBoardScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar:  MainAppBar(
        color: Theme.of(context).primaryColor,
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColorLight,
        backgroundColor: Theme.of(context).cardColor,
        onRefresh: () async {
          Get.find<DashboardController>().getDashboardData();
          Get.find<DashboardController>().changeGraph(EarningType.monthly);
          Get.find<DashboardController>().getMonthlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()),
              DateTime.now().month.toString());
          Get.find<DashboardController>().getYearlyBookingsDataForChart(DateConverter.stringYear(DateTime.now()));
          Get.find<NotificationController>().getNotifications(1,saveNotificationCount: false);
        },
        child: SingleChildScrollView(
          child: Column(
            children:  [
              TopCardSection(),
              GraphSection(),
              RecentActivitySection(),
              MySubscriptionSection(),
              ServiceManSection(),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL)
            ],
          ),
        ),
      )
    );
  }
}
