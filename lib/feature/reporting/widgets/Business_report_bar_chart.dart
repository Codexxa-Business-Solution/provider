import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/business_report_controller.dart';
import 'package:get/get.dart';
import 'package:graphic/graphic.dart';


class BusinessReportBarChart extends StatelessWidget {
  const BusinessReportBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 250,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Row(
            children: [
              Image.asset(Images.dashboardEarning,height: 15,width:15),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
              Text("expense_statistics".tr,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)),
              ),
            ],
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 250,
              color: Theme.of(context).cardColor,
              child: Chart(
                //data:basicData,
                data: Get.find<BusinessReportController>().barChartData.length>0?Get.find<BusinessReportController>().barChartData:basicData,
                variables: {
                  'Timeline': Variable(
                    accessor: (Map map) => map['timeline'] as String,
                  ),
                  'Amount': Variable(
                    accessor: (Map map) => map['Amount'] as num,
                  ),
                },
                elements: [
                  IntervalElement(
                    label: LabelAttr(
                        encoder: (tuple) => Label(
                          tuple['Amount'].toString(),
                        )
                    ),
                    elevation: ElevationAttr(value: 0, updaters: {
                      'tap': {true: (_) => 5}
                    }),
                    color: ColorAttr(value: Theme.of(context).primaryColor, updaters: {
                      'tap': {false: (color) => color.withAlpha(100)}
                    }),
                    //layer: 10

                  )
                ],
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
                selections: {'tap': PointSelection(dim: Dim.x)},
                tooltip: TooltipGuide(
                    backgroundColor: Theme.of(context).cardColor
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
        ],
      ),
    );
  }
}

const basicData = [
  {'timeline': '0', 'Amount': 0},
  {'timeline': '2', 'Amount': 0},
  {'timeline': '4', 'Amount': 0},
];

