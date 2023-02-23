import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/booking_report_controller.dart';
import 'package:demandium_provider/feature/reporting/repository/report_repo.dart';
import 'package:demandium_provider/feature/reporting/widgets/booking_report_listview.dart';
import 'package:demandium_provider/feature/reporting/widgets/report_appbar.dart';
import 'package:demandium_provider/feature/reporting/widgets/booking_report_bar_chart.dart';
import 'package:demandium_provider/feature/reporting/widgets/booking_report_statistics.dart';
import 'package:get/get.dart';

class BookingReport extends StatelessWidget {
  const BookingReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BookingReportController(reportRepo: ReportRepo(apiClient: Get.find())));
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.97),
      appBar: ReportAppBarView(title: 'booking_report'.tr, fromPage: 'booking',),
      body: GetBuilder<BookingReportController>(
        initState: (_){
          Get.find<BookingReportController>().getBookingReportData(1);
        },
       builder: (bookingReportController){
       if(bookingReportController.bookingReportModel!=null){
         return CustomScrollView(
           controller: bookingReportController.scrollController,
           slivers: [

             SliverToBoxAdapter(child: BookingReportStatistics()),

             SliverToBoxAdapter(child: BookingReportBarChart()),

             SliverToBoxAdapter(child: BookingReportListView(
               bookingFilterData: bookingReportController.bookingReportFilterData,
             ))
           ],
         );
       }else{
         return Center(child: CircularProgressIndicator(),);
       }
      }),
    );
  }
}


