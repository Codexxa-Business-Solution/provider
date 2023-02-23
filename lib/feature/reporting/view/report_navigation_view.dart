import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/transaction_report_controller.dart';
import 'package:demandium_provider/feature/reporting/repository/report_repo.dart';
import 'package:demandium_provider/feature/reporting/view/booking_report.dart';
import 'package:demandium_provider/feature/reporting/view/business_report.dart';
import 'package:demandium_provider/feature/reporting/view/transaction_report.dart';
import 'package:get/get.dart';

class ReportNavigationView extends StatelessWidget {
  const ReportNavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TransactionReportController(reportRepo: ReportRepo(apiClient: Get.find())));
    return Scaffold(
      appBar: CustomAppBar(title: "reports".tr),
      
      body:  Column(
        children: [
         GetBuilder<TransactionReportController>(builder: (controller){
           return  _reportItem(
             icon: Images.reportOverview1,
             title: 'transactions_report',
             onTap: (){
               controller.resetFilterValue();
               Get.to(()=> TransactionReport());
             },
           );
         }),

          _reportItem(
            icon: Images.reportOverview2,
            title: 'business_report',
            onTap: (){
              Get.to(()=> BusinessReport());
            },
          ),

          _reportItem(
            icon: Images.reportOverview3,
            title: 'booking_report',
            onTap: (){
              Get.to(()=> BookingReport());
            },
          ),
        ],
      ),
    );
  }
  
}

class _reportItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String icon;
  const _reportItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_SMALL,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode?Theme.of(context).cardColor.withOpacity(0.5):Theme.of(context).cardColor,
          //boxShadow: shadow
        ),
        child: Column(
          children: [
            Image.asset(icon,width: 40,),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            Text(
              title.tr,
              style: ubuntuBold.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(context).primaryColorLight
              ),
            ),
          ],
        ),
      ),
    );
  }
}
