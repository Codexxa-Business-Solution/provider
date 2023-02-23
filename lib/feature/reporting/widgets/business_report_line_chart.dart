import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/business_report_controller.dart';
import 'package:demandium_provider/feature/reporting/model/chart_model.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BusinessReportLineChart extends StatefulWidget {
  final String fromPage;
  const BusinessReportLineChart({Key? key, required this.fromPage}) : super(key: key);

  @override
  _BusinessReportLineChartState createState() => _BusinessReportLineChartState();
}

class _BusinessReportLineChartState extends State<BusinessReportLineChart> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState(){
    _tooltipBehavior =  TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.asset(Images.dashboardEarning,height: 15,width:15),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                Text("earning_statistics".tr,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          if(widget.fromPage == 'overview')
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.circle,size: 12,color: Theme.of(context).primaryColor,),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                  Text(
                    'earning'.tr,
                    style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7)
                    ),
                  )
                ],
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
              Row(
                children: [
                  Icon(Icons.circle,size: 12,color: Theme.of(context).errorColor,),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                  Text(
                    'expense'.tr,
                    style: ubuntuMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7)
                    ),
                  )
                ],
              )
            ],
          ),

          if(widget.fromPage == 'earning')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Row(
                  children: [
                    Icon(Icons.circle,size: 12,color: Colors.green,),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                    Text(
                      'net_profit'.tr,
                      style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7)
                      ),
                    )
                  ],
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

                Row(
                  children: [
                    Icon(Icons.circle,size: 12,color: Theme.of(context).primaryColor,),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                    Text(
                      'total_earning'.tr,
                      style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7)
                      ),
                    )
                  ],
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                Row(
                  children: [
                    Icon(Icons.circle,size: 12,color: Theme.of(context).errorColor,),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                    Text(
                      'total_expense'.tr,
                      style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7)
                      ),
                    )
                  ],
                ),


              ],
            ),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          SizedBox(
            height: 200,
            child: Center(
                child: Container(
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        onDataLabelTapped: (DataLabelTapDetails data){

                        },
                        tooltipBehavior: _tooltipBehavior,
                        enableMultiSelection: true,
                        series: <ChartSeries>[
                          if(widget.fromPage=='overview')
                          SplineSeries<ChartDataModel, String>(
                              color: Theme.of(context).errorColor,
                              width: 3,
                              enableTooltip: true,
                              name: "expense".tr,
                              dataSource: Get.find<BusinessReportController>().overviewExpenseChart,
                              xValueMapper: (ChartDataModel data, _) => data.x,
                              yValueMapper: (ChartDataModel data, _) => data.y,

                          ),
                          if(widget.fromPage=='overview')
                          SplineSeries<ChartDataModel, String>(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                              enableTooltip: true,
                              name: "earning".tr,
                              dataSource:  Get.find<BusinessReportController>().overviewEarningChart,
                              xValueMapper: (ChartDataModel data, _) => data.x,
                              yValueMapper: (ChartDataModel data, _) => data.y,

                          ),

                          if(widget.fromPage=='earning')
                            SplineSeries<ChartDataModel, String>(
                                color: Theme.of(context).primaryColor,
                                width: 3,
                                enableTooltip: true,
                                name: "total_earning".tr,
                                dataSource:  Get.find<BusinessReportController>().earningTotalEarningChart,
                                xValueMapper: (ChartDataModel data, _) => data.x,
                                yValueMapper: (ChartDataModel data, _) => data.y,

                            ),


                          if(widget.fromPage=='earning')
                            SplineSeries<ChartDataModel, String>(
                                color: Theme.of(context).errorColor,
                                width: 3,
                                enableTooltip: true,
                                name: "total_expense".tr,
                                dataSource:  Get.find<BusinessReportController>().earningExpenseChart,
                                xValueMapper: (ChartDataModel data, _) => data.x,
                                yValueMapper: (ChartDataModel data, _) => data.y,

                            ),

                          if(widget.fromPage=='earning')
                            SplineSeries<ChartDataModel, String>(
                                color: Colors.green,
                                width: 3,
                                enableTooltip: true,
                                name: "net_profit".tr,
                                dataSource:  Get.find<BusinessReportController>().earningNetProfitChart,
                                xValueMapper: (ChartDataModel data, _) => data.x,
                                yValueMapper: (ChartDataModel data, _) => data.y,

                            ),




                        ]
                    )
                )
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final int? y;
}

