import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/business_report_controller.dart';
import 'package:demandium_provider/feature/reporting/model/business_report_earning_model.dart';
import 'package:get/get.dart';

class BusinessReportEarningListView extends StatelessWidget {
  final  List<BusinessReportEarningFilterData>  filterData;
  const BusinessReportEarningListView({Key? key, required this.filterData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        filterData.length>0?
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){

            double  netProfit = filterData[index].bookingDetailsAmounts?.providerEarning??0;

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

                        Text("${'booking_id'.tr} : ",
                          style: ubuntuMedium.copyWith(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        Text(filterData[index].readableId.toString(),
                          style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                          overflow: TextOverflow.ellipsis,
                        ),
                        // Expanded(child: SizedBox()),
                        // IconButton(onPressed: (){
                        //   showDialog(
                        //     context: context,
                        //     builder: (ctx)=> ShowBusinessEarningDetails(filterData: filterData[index],),
                        //   );
                        // },
                        //     icon: Icon(Icons.info,color: Theme.of(context).primaryColorLight,),
                        //   padding:  EdgeInsets.zero,
                        // )
                      ],
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text("${'booking_amount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].totalBookingAmount),
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

                            Text("${'total_service_discount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].totalDiscountAmount),
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

                            Text("${'provider_paid_service_discount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].bookingDetailsAmounts?.discountByProvider??0),
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

                            Text("${'total_coupon_discount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].totalCouponDiscountAmount),
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

                            Text("${'provider_paid_coupon_discount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].bookingDetailsAmounts?.couponDiscountByProvider??0),
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

                            Text("${'total_campaign_discount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].totalCampaignDiscountAmount),
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

                            Text("${'provider_paid_campaign_discount'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].bookingDetailsAmounts?.campaignDiscountByProvider??0),
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

                            Text("${'sub_total'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].totalBookingAmount),
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

                            Text("${'admin_commission'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].bookingDetailsAmounts?.adminCommission??0),
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

                            Text("${'vat/tax'.tr} : ",
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                              ),
                            ),
                            Text(PriceConverter.convertPrice(filterData[index].totalTaxAmount),
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
                            Text("${'provider_net_income'.tr} : ",
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

