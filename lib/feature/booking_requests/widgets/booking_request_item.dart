import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
class BookingRequestItem extends StatelessWidget {
  final BookingRequestModel bookingRequestModel;

  const BookingRequestItem({
    Key? key, required this.bookingRequestModel,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>Get.toNamed(RouteHelper.getBookingDetailsRoute(bookingRequestModel.id!, bookingRequestModel.bookingStatus!,'others')),
      child: Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(Get.isDarkMode?0.5:1),
            boxShadow: shadow,
          ),
          padding:  EdgeInsets.symmetric( vertical: Dimensions.PADDING_SIZE_SMALL,
              horizontal: Dimensions.PADDING_SIZE_DEFAULT
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      Text("booking".tr,
                        style: ubuntuMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                        ),
                      ),
                      Text(" # ${bookingRequestModel.readableId}",
                        style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)),
                        overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Row(
                    children: [
                      Text("${'booking_date'.tr}: ",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,  color: Theme.of(context).secondaryHeaderColor)
                      ),
                      Text(" ${DateConverter.dateMonthYearTime(DateConverter
                          .isoUtcStringToLocalDate(bookingRequestModel.createdAt!))}",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,  color: Theme.of(context).secondaryHeaderColor),
                        textDirection: TextDirection.ltr
                      )
                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                  Row(
                    children: [
                      Text("${'scheduled_date'.tr}: ",
                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).secondaryHeaderColor)
                      ),
                      Text(DateConverter.dateMonthYearTime(DateTime.tryParse(bookingRequestModel.serviceSchedule!)),
                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).secondaryHeaderColor),
                          textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                  Row(
                    children: [
                      Text("${'total_amount'.tr}: ",
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColorLight),
                      ),
                      Text(PriceConverter.convertPrice(double.parse(bookingRequestModel.totalBookingAmount)),
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColorLight),
                      ),
                    ],
                  ),
                  ],
                ),
              ),

              Container(
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Get.isDarkMode?Colors.grey.withOpacity(0.2):
                          ColorResources.buttonBackgroundColorMap[bookingRequestModel.bookingStatus]
                      ),
                      child: Center(
                        child: Text('${bookingRequestModel.bookingStatus}'.tr,
                          style:ubuntuMedium.copyWith(fontWeight: FontWeight.w500, fontSize: 12,
                              color:ColorResources.buttonTextColorMap[bookingRequestModel.bookingStatus]
                          ),
                        ),
                      )
                    ),

                    Text("view_details".tr,style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColorLight,
                        fontSize: 12,decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
