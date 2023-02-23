import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/booking_details/widget/booking_item.dart';

class BookingInformationView extends StatelessWidget {
  const BookingInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<BookingDetailsController>(builder: (bookingDetailsController){
      final bookingDetails =bookingDetailsController.bookingDetailsContent;
      return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor),
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('${'booking'.tr} # ${bookingDetails!.readableId}',
                    overflow: TextOverflow.ellipsis,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).textTheme.bodyText1!.color, decoration: TextDecoration.none
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Get.isDarkMode?
                    Colors.grey.withOpacity(0.2):ColorResources.buttonBackgroundColorMap[bookingDetails.bookingStatus],
                  ),
                  child: Center(
                    child: Text(bookingDetails.bookingStatus!.tr,
                      style: ubuntuMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color:Get.isDarkMode?Theme.of(context).primaryColorLight : ColorResources.buttonTextColorMap[bookingDetails.bookingStatus]
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height:Dimensions.PADDING_SIZE_DEFAULT),
            BookingItem(
              img: Images.iconCalendar,
              title: '${'booking_date'.tr} : ',
              date: '${DateConverter.dateMonthYearTime(
                  DateConverter.isoUtcStringToLocalDate(bookingDetails.createdAt!))
              }',
            ),
            SizedBox(height:Dimensions.PADDING_SIZE_SMALL),

            BookingItem(
              img: Images.iconCalendar,
              title: '${'scheduled_date'.tr} : ',
              date: ' ${DateConverter.dateMonthYearTime(DateTime.tryParse(bookingDetails.serviceSchedule!))}',
            ),
            SizedBox(height:Dimensions.PADDING_SIZE_SMALL),

            BookingItem(
              img: Images.iconLocation,
              title: '${'service_address'.tr} : ${bookingDetails.serviceAddress !=null?''
                  '${bookingDetails.serviceAddress!.address}'
                  :'address_not_found'.tr
              }',
              date: '',
            ),
            SizedBox(height:Dimensions.PADDING_SIZE_DEFAULT),
            Text("payment_method".tr,
              style: ubuntuBold.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).textTheme.bodyText1!.color),
            ),
            SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(bookingDetails.paymentMethod!.tr,
                  style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                  ),
                ),
                RichText(
                  text: TextSpan(text: "${'payment_status'.tr}:",
                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: bookingDetails.isPaid == 0 ? "unpaid".tr : "paid".tr,
                        style: ubuntuBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: bookingDetails.isPaid == 0 ?
                          Theme.of(context).errorColor: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),

            bookingDetails.paymentMethod!="cash_after_service" ?
            Text("${'transaction_id'.tr} : ${bookingDetails.transactionId}",
              style: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).hintColor,
              ),
            ):SizedBox.shrink(),

            SizedBox(height:Dimensions.PADDING_SIZE_EXTRA_SMALL),

            Row(
              children: [
                Text("${'amount'.tr} : ",
                  style: ubuntuBold.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7),
                  ),
                ),

                Text("${PriceConverter.convertPrice(double.parse(bookingDetails.totalBookingAmount),isShowLongPrice:true)}",
                  style: ubuntuBold.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}