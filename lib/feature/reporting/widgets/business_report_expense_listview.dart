import 'package:demandium_provider/components/custom_divider.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/business_report_controller.dart';
import 'package:demandium_provider/feature/reporting/model/business_report_expense_model.dart';
import 'package:get/get.dart';

class BusinessReportExpenseListView extends StatelessWidget {
  final  List<BusinessReportFilterData>  filterData;
  const BusinessReportExpenseListView({Key? key, required this.filterData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        filterData.length>0?
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            double normalDiscount =filterData[index].discountByProvider??0;
            double couponDiscount = filterData[index].couponDiscountByProvider??0;
            double campaignDiscount = filterData[index].campaignDiscountByProvider??0;

            double totalExpense =normalDiscount+couponDiscount+campaignDiscount;

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

                        Text("${'booking_id'.tr} # ",
                          style: ubuntuMedium.copyWith(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        Text(filterData[index].booking?.readableId.toString()??"",
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

                            Text("${'normal_discount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(double.tryParse(filterData[index].discountByProvider.toString())),
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
                            Text("${'coupon_discount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(double.tryParse(filterData[index].couponDiscountByProvider.toString())),
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

                            Text("${'campaign_discount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(double.tryParse(filterData[index].campaignDiscountByProvider.toString())),
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                          child: CustomDivider(color: Theme.of(context).hintColor),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${'total_expense'.tr} : ",
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
                      ],
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
