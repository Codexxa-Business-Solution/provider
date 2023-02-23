import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class GraphSection extends GetView<DashboardController> {
  const GraphSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> previousYearsList =[];
    for(int i=4;i>=0;i--){
      previousYearsList.add((DateTime.now().year -i).toString());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT+3,
            vertical: Dimensions.PADDING_SIZE_DEFAULT),
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

        Container(
          width: context.width,
          color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
          padding: EdgeInsets.only(
            right: Dimensions.PADDING_SIZE_SMALL,
            top:Dimensions.PADDING_SIZE_DEFAULT,
            bottom: Dimensions.PADDING_SIZE_SMALL
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<DashboardController>(
                builder: (dashboardController){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      GestureDetector(
                        onTap: (){
                          Get.find<DashboardController>().getMonthlyBookingsDataForChart(DateConverter
                              .stringYear(DateTime.now()),DateTime.now().month.toString());
                          dashboardController.changeGraph(EarningType.monthly);},
                        child:  GraphCustomButton(buttonText: "monthly".tr,
                            isSelectedButton: dashboardController.getChartType == EarningType.monthly ? true: false
                        ),
                      ),

                      SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),

                      GestureDetector(
                        onTap: () => dashboardController.changeGraph(EarningType.yearly),
                        child:  GraphCustomButton(
                            buttonText: "yearly".tr,
                            isSelectedButton: dashboardController.getChartType == EarningType.yearly ? true: false
                        ),
                      ),
                    ],
                  );
                },

              ),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              GetBuilder<DashboardController>(
                builder:(dashboardController){
                  return dashboardController.getChartType == EarningType.monthly ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      CustomDropDownButton(title:"year".tr,type: "Year", itemList: previousYearsList,),
                      SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                      CustomDropDownButton(
                        title: "month".tr,
                        type: "Month",
                        itemList: ['January','February','March','April','May','June','July','August',
                          'September','October','November','December',],
                      ),
                    ],

                  ) : Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CustomDropDownButton(title:"year".tr,type: "Year",itemList: previousYearsList),
                    ],
                  );
                },
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

              GetBuilder<DashboardController>(
                builder: (controller){
                  return SizedBox(
                    width: context.width,
                    child: controller.getChartType == EarningType.monthly ?
                    MonthlyDashBoardChart() :
                    YearlyDashBoardChart(),
                  );
                },
              ),
              Text("total_earning".tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
            ],
          ),
        ),
      ],
    );
  }
}
