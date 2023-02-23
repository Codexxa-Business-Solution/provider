import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/business_report_controller.dart';
import 'package:demandium_provider/feature/reporting/repository/report_repo.dart';
import 'package:demandium_provider/feature/reporting/widgets/business_report_view.dart';
import 'package:demandium_provider/feature/reporting/widgets/report_appbar.dart';
import 'package:get/get.dart';

class BusinessReport extends StatelessWidget {
  const BusinessReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   Get.lazyPut(() => BusinessReportController(reportRepo: ReportRepo(apiClient: Get.find())));
    return Scaffold(
      appBar: ReportAppBarView(title: 'business_report'.tr, fromPage: 'report',),
      body: GetBuilder<BusinessReportController>(builder: (reportController){
        return  DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.blue))),
                child: TabBar(
                  controller: reportController.businessReportTabController,
                  unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                  isScrollable: true,
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor:  Theme.of(context).primaryColor,
                  labelStyle: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  tabs:  [
                    SizedBox(height: 45, child:Center(child: Text("overview".tr))),
                    SizedBox(height: 45, child:  Center(child: Text("earning_report".tr))),
                    SizedBox(height: 45, child:  Center(child: Text("expense_report".tr))),
                  ],

                  onTap: (index)async {
                    if(index==0){
                      Get.find<BusinessReportController>().resetValue();
                    }else if(index==1){
                      Get.find<BusinessReportController>().resetValue();
                    }else{
                      Get.find<BusinessReportController>().resetValue();
                    }
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller:reportController.businessReportTabController,
                  children: [
                    BusinessReportView(fromPage: 'overview',),
                    BusinessReportView(fromPage: 'earning',),
                    BusinessReportView(fromPage: 'expense',),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
