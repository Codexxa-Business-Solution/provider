import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/booking_details/model/bookings_details_model.dart';

class BookingSummeryView extends StatelessWidget{
  final BookingDetailsContent bookingDetailsContent;
  const BookingSummeryView({Key? key, required this.bookingDetailsContent}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GetBuilder<BookingDetailsController>(builder:(bookingDetailsController){
       return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

          Padding(padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("booking_summary".tr,
              style:ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyText1!.color),
            ),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_SMALL),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              height: 40,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("service_info".tr, style:ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyText1!.color!,decoration: TextDecoration.none)
                  ),
                  Text("service_cost".tr,style:ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyText1!.color!,decoration: TextDecoration.none)
                  ),
                ],
              ),
            ),
          ),

          ListView.builder(
            itemBuilder: (context,index){
              return ServiceInfoItem(
                bookingService:bookingDetailsController.bookingDetailsContent!.detail![index],
                bookingDetailsController: bookingDetailsController,
                index: index,
              );
            },
            itemCount: bookingDetailsController.bookingDetailsContent!.detail!.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Divider(height: 2, color: Colors.grey,),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("subtotal_vat_ex".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color),overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("${PriceConverter.convertPrice(bookingDetailsController.allTotalCost, isShowLongPrice:true)}",
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("service_discount".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color),overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("(-) ${PriceConverter.convertPrice(
                    bookingDetailsController.totalDiscount,
                    isShowLongPrice:true)}",
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("coupon_discount".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color),overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("(-) ${PriceConverter.convertPrice(
                    double.tryParse(bookingDetailsController.bookingDetailsContent!.totalCouponDiscountAmount!),
                    isShowLongPrice:true)}",
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("service_tax".tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color),overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("(+) ${PriceConverter.convertPrice(
                    double.tryParse(bookingDetailsController.bookingDetailsContent!.totalTaxAmount),
                    isShowLongPrice:true)}",
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color
                  ),
                ),
              ],
            ),
          ),


          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Divider(),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text("grand_total".tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color),overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("${PriceConverter.convertPrice(double.tryParse(
                    bookingDetailsController.bookingDetailsContent!.totalBookingAmount,),
                    isShowLongPrice:true)}",
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            ],
          );
       },
    );
  }
}


class ServiceInfoItem extends StatelessWidget {
  final int index;
  final BookingDetailsController bookingDetailsController;
  final BookingService bookingService;
  const ServiceInfoItem({
    Key? key,required this.bookingService,
    required this.bookingDetailsController,
    required this.index}) : super(key: key
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          SizedBox(height:Dimensions.PADDING_SIZE_SMALL),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              Flexible(
                child: Text(bookingService.serviceName??"",
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              ),
              Flexible(
                child: Text("${PriceConverter.convertPrice(bookingDetailsController.unitTotalCost[index],
                    isShowLongPrice:true
                )}",
                style: ubuntuRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                ),
              ),
            ],
          ),
          SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),

          Text("${bookingService.variantKey}",
            style: ubuntuRegular.copyWith(
              fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor
            ),
          ),
          SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),

          PriceText("unit_price".tr, double.tryParse(bookingService.serviceCost!), context),

          Text("quantity".tr + " :${bookingService.quantity}",
            style: ubuntuRegular.copyWith(
              fontSize: Dimensions.fontSizeExtraSmall,
              color: Theme.of(context).hintColor,
            ),
          ),


          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
          double.tryParse(bookingService.discountAmount!)! > 0
            ? PriceText("discount".tr,
            double.tryParse(bookingService.discountAmount!), context)
            : SizedBox(),

          double.tryParse(bookingService.campaignDiscountAmount!)! > 0
            ? PriceText("campaign".tr,
            double.tryParse(bookingService.campaignDiscountAmount!),
            context)
            : SizedBox(),

          double.tryParse(bookingService.overallCouponDiscountAmount!)! >
            0
            ? PriceText("coupon".tr, double.tryParse(
            bookingService.overallCouponDiscountAmount!), context)
            : SizedBox(),

          bookingService.service != null && bookingService.service!.tax! > 0
            ? PriceText(
            "tax".tr, double.tryParse(bookingService.taxAmount!), context)
           : SizedBox(),
        ],
      ),);
  }

}


Widget PriceText(String title,var amount,context){
  return Column(children: [
    Row(
      children: [
        Text(title+" : ",
          style: ubuntuRegular.copyWith(
              fontSize: Dimensions.fontSizeExtraSmall,color: Theme.of(context).hintColor
          ),
        ),
        Text("${PriceConverter.convertPrice(amount,isShowLongPrice:true)}",
          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,color: Theme.of(context).hintColor),
        ),
      ],
    ),
    SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),
    ],
  );
}
