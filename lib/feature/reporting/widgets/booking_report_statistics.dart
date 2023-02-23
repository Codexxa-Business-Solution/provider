import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/booking_report_controller.dart';
import 'package:demandium_provider/feature/reporting/widgets/business_report_statistics_card2.dart';
import 'package:get/get.dart';

class BookingReportStatistics extends StatelessWidget {

  const BookingReportStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<BookingReportController>(builder: (bookingReportController){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        child: SizedBox(
          height: 120,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                if(bookingReportController.bookingReportModel?.content?.bookingsCount!=null)
                BusinessReportStatisticsCard2(
                  withCurrencySymbol: false,
                  icon: Images.bookingReport1,
                  titleAmount: bookingReportController.bookingReportModel?.content?.bookingsCount?.totalBookings.toString()??"",
                  title: 'total_booking',
                  subtitle1: 'canceled',
                  subtitleAmount1: bookingReportController.bookingReportModel?.content?.bookingsCount?.canceled.toString()??"",
                  subtitle2: 'accepted',
                  subtitleAmount2:bookingReportController.bookingReportModel?.content?.bookingsCount?.accepted.toString()??"" ,
                  subtitle3: 'ongoing',
                  subtitleAmount3: bookingReportController.bookingReportModel?.content?.bookingsCount?.ongoing.toString()??"",
                  subtitle4: 'completed',
                  subtitleAmount4: bookingReportController.bookingReportModel?.content?.bookingsCount?.completed.toString()??"",
                ),

                BusinessReportStatisticsCard2(
                  withCurrencySymbol: true,
                  icon: Images.bookingReport2,
                  titleAmount: bookingReportController.bookingReportModel?.content?.bookingAmount?.totalBookingAmount.toString()??"",
                  title: 'total_booking_amount',
                  subtitle1: 'due_amount',
                  subtitleAmount1: bookingReportController.bookingReportModel?.content?.bookingAmount?.totalUnpaidBookingAmount.toString()??"",
                  subtitle2: 'already_settled',
                  subtitleAmount2: bookingReportController.bookingReportModel?.content?.bookingAmount?.totalPaidBookingAmount.toString()??"" ,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
