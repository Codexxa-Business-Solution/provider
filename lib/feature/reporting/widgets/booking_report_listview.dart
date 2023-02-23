import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/booking_report_controller.dart';
import 'package:demandium_provider/feature/reporting/model/booking_report_model.dart';
import 'package:get/get.dart';

class BookingReportListView extends StatelessWidget {
  final List<BookingFilterData> bookingFilterData;
  const BookingReportListView({Key? key, required this.bookingFilterData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
        bookingFilterData.length>0?
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return Container(width: Get.width,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
                //boxShadow: shadow,
              ),
              padding:  EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_DEFAULT,
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text((index+1).toString()+".",
                        style: ubuntuMedium.copyWith(color: Theme.of(context).errorColor),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                      Text("${'booking_id'.tr} # ",
                        style: ubuntuMedium.copyWith(
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                      Text(bookingFilterData[index].readableId.toString(),
                        style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                  Column(children: [
                    Row(
                      children: [
                        Text("${'customer_name'.tr} : ",
                          style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                          ),
                        ),
                        Text("${bookingFilterData[index].customer?.firstName} ${bookingFilterData[index].customer?.lastName}" ,
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
                        Text("${'booking_amount'.tr} : ",
                          style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                          ),
                        ),
                        Text(PriceConverter.convertPrice(double.tryParse(bookingFilterData[index].totalBookingAmount.toString())),
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
                        Text("${'service_discount'.tr} : ",
                          style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                          ),
                        ),
                        Text(PriceConverter.convertPrice(double.tryParse(bookingFilterData[index].totalDiscountAmount.toString())),
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
                        Text(PriceConverter.convertPrice(double.tryParse(bookingFilterData[index].totalCouponDiscountAmount.toString())),
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
                        Text("${'VAT/Tax'.tr} : ",
                          style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                          ),
                        ),
                        Text(PriceConverter.convertPrice(double.tryParse(bookingFilterData[index].totalTaxAmount.toString())),
                          style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                          ),
                        )
                      ],
                    )

                  ],
                  ),
                ],
              ),
            );
          },
          itemCount: bookingFilterData.length,
        ) :
        SizedBox(height: Get.height*0.33,
          child: Center(
            child: Text('no_data_found'.tr,style: ubuntuRegular.copyWith(color:Theme.of(context).primaryColorLight)),
          ),),
        if(Get.find<BookingReportController>().isLoading)
          CircularProgressIndicator()
      ],
    );
  }
}
