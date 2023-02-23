import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/business_report_controller.dart';
import 'package:demandium_provider/feature/reporting/model/business_report_overview_model.dart';
import 'package:get/get.dart';

class BusinessReportOverviewListView extends StatelessWidget {
  final  List<Amounts>  filterData;
  const BusinessReportOverviewListView({Key? key, required this.filterData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        filterData.length>0?
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){

            double totalEarning=0;
            double totalExpense=0;
            double netProfit=0;
            double netProfitRate=0;
            double tax =0;

            totalEarning = filterData[index].providerEarning??0;
            tax = filterData[index].serviceTax??0;

            totalExpense = filterData[index].campaignDiscountByProvider!
                + filterData[index].couponDiscountByProvider! + filterData[index].discountByProvider!;

            netProfit = totalEarning;
            netProfitRate =totalEarning!=0? (netProfit*100)/totalEarning  : netProfit*100;

            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              child: Container(width: Get.width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                ),
                padding:  EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_SMALL,
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text((index+1).toString()+".",
                          style: ubuntuMedium.copyWith(color: Theme.of(context).errorColor),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                        Text("${'net_profit_rate'.tr} : ",
                          style: ubuntuMedium.copyWith(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        Text(netProfitRate.toStringAsFixed(2)+" % ",
                          style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text("${'total_earning'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(totalEarning),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text("${'total_expenses'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(totalExpense),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text("${'tax'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(tax),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${'net_profit'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(netProfit),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        )],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: filterData.length,
        ):
        SizedBox(height: Get.height*0.33,
          child: Center(
           child: Text('no_data_found'.tr,style: ubuntuRegular.copyWith(color:Theme.of(context).primaryColorLight)),
        ),),

        if(Get.find<BusinessReportController>().isLoading)
          CircularProgressIndicator()
      ],
    );
  }
}
