import 'package:demandium_provider/components/custom_divider.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/transaction_report_controller.dart';
import 'package:demandium_provider/feature/reporting/model/transaction_report_model.dart';
import 'package:get/get.dart';

class TransactionReportListView extends StatelessWidget {
  final int tabIndex;
  final List<TransactionReportData> transactionReportList;
  const TransactionReportListView({
    Key? key,
    required this.tabIndex,
    required this.transactionReportList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionReportController>(
      builder: (reportController){
      return Column(
        children: [
          transactionReportList.length>0 ?
          Expanded(
            child: ListView.builder(
              controller: reportController.scrollController,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return Container(width: Get.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                    color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                  ),
                  margin: EdgeInsets.only(top: 10),
                  padding:  EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_DEFAULT,
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Column(
                    children: [
                      Column(children: [
                        ListTile(
                          horizontalTitleGap: 0,
                          contentPadding: EdgeInsets.all(0),
                          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          leading: Text('${index + 1}.', style: ubuntuRegular.copyWith(color: Theme.of(context).secondaryHeaderColor),),
                          title: Column( crossAxisAlignment: CrossAxisAlignment.start,children: [
                            Text('${'type'.tr} : ${transactionReportList[index].trxType.toString().tr}', style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColor),),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('debit'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                              Text(PriceConverter.convertPrice(transactionReportList[index].debit), style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                            ],),

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('credit'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                              Text(PriceConverter.convertPrice(transactionReportList[index].credit), style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                            ],),
                          ]),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          child: CustomDivider(color: Theme.of(context).hintColor),
                        ),

                        ListTile(
                          horizontalTitleGap: 0,
                          contentPadding: EdgeInsets.all(0),
                          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                          leading: SizedBox(),
                          title: Text('balance'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                          trailing: Text(PriceConverter.convertPrice(transactionReportList[index].balance), style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: 0),
                          child: Column(
                            children: [
                              Row(children: [
                                Text('${'transaction_to'.tr} : ',style: ubuntuRegular.copyWith(color:  Theme.of(context).hintColor)),
                                Text('${transactionReportList[index].toUser?.firstName??''} ${transactionReportList[index].toUser?.lastName??''}', style: ubuntuRegular.copyWith(color:  Theme.of(context).hintColor)),
                              ],),

                              Row(children: [
                                Text("${'date'.tr}: ",
                                  style: ubuntuRegular.copyWith(color:  Theme.of(context).hintColor),
                                ),
                                Text(" ${DateConverter.dateMonthYearTime(DateConverter.isoUtcStringToLocalDate(
                                    transactionReportList[index].createdAt??""))}",
                                    style: ubuntuRegular.copyWith(color:  Theme.of(context).hintColor),
                                    textDirection: TextDirection.ltr
                                )
                              ])
                            ],
                          ),
                        ),
                      ],),
                    ],
                  ),
                );
              },
              itemCount: transactionReportList.length,
            ),
          ):SizedBox(),
          if(transactionReportList.length==0 && !Get.find<TransactionReportController>().loading)
          Expanded(
            child: Center(
              child: Text('no_data_found'.tr,style: ubuntuRegular.copyWith(color:Theme.of(context).primaryColorLight)),
            ),
          ),
          if(Get.find<TransactionReportController>().isLoading)
            CircularProgressIndicator()
        ],
      );
    });
  }
}
