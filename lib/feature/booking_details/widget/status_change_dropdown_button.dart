import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';
import 'package:demandium_provider/feature/booking_details/model/bookings_details_model.dart';

class ChangeStatusDropdownButton extends StatelessWidget {
  final BookingDetailsContent bookingDetails;
  final BookingDetailsController bookingDetailsController;
  final String bookingId;
  const ChangeStatusDropdownButton({
    Key? key,
    required this.bookingDetails,
    required this.bookingDetailsController,
    required this.bookingId}) : super(key: key
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bookingDetails.bookingStatus == 'pending' && !bookingDetailsController.isAcceptButtonLoading ?
        Container(
          width: Get.width,
          height: 70,
          child: CustomButton(

            btnTxt: "Accept_Booking_Request".tr,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            color:Get.isDarkMode? Colors.green.withOpacity(0.5):Colors.green,
            onPressed: bookingDetails.customer!=null? ()=>Get.dialog(
             ConfirmationDialog(
                yesButtonColor: Theme.of(context).primaryColor,
                title: "want_accept_this_booking?".tr,
                icon: Images.servicemanImage,
                description: ''.tr,
                onYesPressed: (){
                  bookingDetailsController.acceptBookingRequest(bookingId);
                  Get.back();
                },
                onNoPressed: () {
                  Get.back();
                }
              )
             )
            :null,
          ),
        )

        : bookingDetailsController.isAcceptButtonLoading ?
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0,top: 5),
          child: Center(
              child: CircularProgressIndicator(color: Theme.of(context).hoverColor)
          ),
        ) : Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              vertical: Dimensions.PADDING_SIZE_SMALL),
          height: 70,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  height: 45,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: Get.isDarkMode?
                        light.cardColor.withOpacity(0.3):
                        Theme.of(context).primaryColor.withOpacity(0.30)
                    ),

                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5), elevation: 2,
                      hint: Text(bookingDetailsController
                          .dropDownValue.tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color)
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: bookingDetailsController.statusTypeList.
                      map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Row(
                            children: [
                              Text(items.tr),
                              // Icon(Icons.check)
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) => bookingDetailsController.changeBookingStatusDropDownValue(newValue!),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

              bookingDetailsController.isStatusUpdateLoading ?
              SizedBox(height: 45, width: 112,
                child: Center(
                    child: SizedBox( height: 30,width: 30,
                      child: CircularProgressIndicator(color: Theme.of(context).hoverColor),
                    )
                ),
              ) : CustomButton(
                color: Theme.of(context).primaryColor, height: 45, width: 112, btnTxt: "change".tr,
                onPressed: bookingDetails.bookingStatus=="completed"
                    || bookingDetailsController.dropDownValue==bookingDetails.bookingStatus
                    ||bookingDetails.bookingStatus=="canceled"? null:
                    ()=>bookingDetailsController.changeBookingStatus(bookingId,bookingStatus: bookingDetails.bookingStatus),
              )
            ],
          ),
        )
      ],
    );
  }
}
