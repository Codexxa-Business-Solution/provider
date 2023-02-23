import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/helper/help_me.dart';
import 'package:demandium_provider/feature/reporting/model/transaction_report_model.dart';
import 'package:demandium_provider/feature/reporting/widgets/report_appbar.dart';
import 'package:demandium_provider/feature/reporting/widgets/transaction_report_listview.dart';
import 'package:demandium_provider/feature/reporting/widgets/trnsaction_report_statistics.dart';
import 'package:get/get.dart';
import '../controller/transaction_report_controller.dart';

class TransactionReport extends StatefulWidget {
  const TransactionReport({Key? key}) : super(key: key);

  @override
  State<TransactionReport> createState() => _TransactionReportState();
}
class _TransactionReportState extends State<TransactionReport> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReportAppBarView(title: 'transactions_report'.tr, fromPage: 'transaction',),
      body: GetBuilder<TransactionReportController>(
        initState: (_){
          Get.find<TransactionReportController>().getAllTransactionReportData(1);
        },
        builder: (transactionReportController){
        if(transactionReportController.transactionReportModel!=null){
          return Column(
            children: [
              TransactionReportStatistics(
                 accountInfo:  transactionReportController.accountInfo??
                     TransactionReportAccountInfo(
                      balancePending: 0,
                      receivedBalance: 0,
                      accountPayable: 0,
                      accountReceivable: 0,
                      totalWithdrawn: 0
                    ),
              ),

              Stack(
                children: [
                  Container(
                    color: Theme.of(context).cardColor,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.blue
                          ),
                        ),
                        color: Theme.of(context).cardColor
                    ),
                    child: TabBar(
                      controller:transactionReportController.tabController,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor:  Theme.of(context).primaryColor,
                      labelStyle: ubuntuMedium,
                      tabs:  [
                        SizedBox(
                          height: 40,
                          child:Center(
                            child: Text("all".tr),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child:  Center(
                            child: Text("debit".tr),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child:  Center(
                            child: Text("credit".tr),
                          ),
                        ),
                      ],
                      onTap: (index)async {
                        if(isRedundentClick(DateTime.now())){
                          return;
                        }
                        if(index==0){
                          Get.find<TransactionReportController>().getAllTransactionReportData(1);
                        }else if(index==1){
                          Get.find<TransactionReportController>().getDebitTransactionReportData(1);
                        }else{
                          Get.find<TransactionReportController>().getCreditTransactionReportData(1);
                        }
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller:transactionReportController.tabController,
                  children: [
                    TransactionReportListView(
                      tabIndex:0,
                      transactionReportList: transactionReportController.allTransactionList,
                    ),
                    TransactionReportListView(
                      tabIndex:1,
                      transactionReportList: transactionReportController.debitTransactionList,
                    ),
                    TransactionReportListView(
                      tabIndex:2,
                      transactionReportList: transactionReportController.creditTransactionList,
                    ),
                  ],
                ),
              )
            ],
          );
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}
