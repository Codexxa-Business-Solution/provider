import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/booking_report_controller.dart';
import 'package:get/get.dart';
import 'package:graphic/graphic.dart';


class BookingReportBarChart extends StatelessWidget {
  const BookingReportBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
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
                  Text("booking_statistics".tr,
                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Chart(
                    data: Get.find<BookingReportController>().barChartData.length>0
                        ? Get.find<BookingReportController>().barChartData
                        : basicData,
                    variables: {
                      'Timeline': Variable(
                        accessor: (Map map) => map['timeline'] as String,
                      ),
                      'Amount': Variable(
                        accessor: (Map map) => map['Amount'] as num,
                      ),
                      'Tax amount': Variable(
                        accessor: (Map map) => map['tax'] as String,
                      ),
                      'Admin commission': Variable(
                        accessor: (Map map) => map['commission'] as String,
                      ),
                    },
                    elements: [
                      IntervalElement(
                        label: LabelAttr(
                          encoder: (tuple) => Label(
                            PriceConverter.convertPrice(double.tryParse(tuple['Amount'].toString())),
                            LabelStyle(style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).primaryColor
                            ))
                          ),
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
                      backgroundColor: Theme.of(context).cardColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            ],
          ),
        ),
      ],
    );
  }
}

const basicData = [
  {'timeline': '2022', 'Amount': 0,'tax':'0','commission':"0"},
  {'timeline': '2024', 'Amount': 0,'tax':'0','commission':"0"},
  {'timeline': '2026', 'Amount': 0,'tax':'0','commission':"0"},
  {'timeline': '2028', 'Amount': 0,'tax':'0','commission':"0"},
  {'timeline': '2030', 'Amount': 0,'tax':'0','commission':"0"},
];

