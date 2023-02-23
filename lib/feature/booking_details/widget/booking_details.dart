import 'package:demandium_provider/components/custom_loader.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/booking_details/controller/invoice_controller.dart';
import 'package:demandium_provider/feature/booking_details/widget/booking_info_view.dart';
import 'package:demandium_provider/feature/booking_details/widget/booking_summery_widget.dart';
import 'package:demandium_provider/feature/booking_details/widget/customer_info.dart';
import 'package:demandium_provider/feature/booking_details/widget/srviceman_info.dart';

class BookingDetailsWidget extends StatelessWidget {
  final String bookingId;
  BookingDetailsWidget({Key? key, required this.bookingId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<BookingDetailsController>(
        builder: (bookingDetailsController) {
          if(bookingDetailsController.bookingDetailsContent==null){
            return Center(child: CustomShimmer());
          }else{
            final bookingDetails = bookingDetailsController.bookingDetailsContent;
            return Column(
              children: [
                Column(
                  children: [

                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    bookingDetails!.bookingStatus!='pending'?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width:Dimensions.PADDING_SIZE_DEFAULT),
                        Expanded(
                          flex: 3,
                          child: CustomButton(
                            height: 40,
                            btnTxt: bookingDetails.scheduleHistories!.length<=1? "change_schedule".tr
                                : bookingDetailsController.bookingDetailsContent!.serviceSchedule!,
                            onPressed: (){
                              if (bookingDetails.bookingStatus != 'accepted') {
                                showCustomSnackBar('${'service'.tr} ${bookingDetails.bookingStatus.toString().tr.toLowerCase()} '
                                    '${'cannot_change_schedule_right_now'.tr}');
                              } else {
                                bookingDetailsController.selectDate();
                              }
                            },
                          ),
                        ),

                        SizedBox(width:Dimensions.PADDING_SIZE_SMALL),

                        Expanded(
                          flex: 1,
                          child: CustomButton(
                            height: 40,
                            color: Colors.blue,
                            btnTxt: "invoice".tr,
                            onPressed: () async {
                              Get.dialog(CustomLoader(), barrierDismissible: false);
                              var pdfFile = await PdfInvoiceApi.generate(
                                  bookingDetails,bookingDetailsController.invoiceItems,
                                  bookingDetailsController
                              );
                              PdfApi.openFile(pdfFile);
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(width:Dimensions.PADDING_SIZE_DEFAULT),
                      ]
                    ) :SizedBox.shrink(),

                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                    BookingInformationView(),

                    SizedBox(height:Dimensions.PADDING_SIZE_DEFAULT),

                    BookingSummeryView(bookingDetailsContent: bookingDetailsController.bookingDetailsContent!,),

                    SizedBox(height:Dimensions.PADDING_SIZE_SMALL),

                    bookingDetails.bookingStatus=='accepted'&& bookingDetails.serviceman == null ?
                    GetBuilder<ServicemanSetupController>(builder: (servicemanSetupController){
                      return Padding(
                        padding:  EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE,
                          vertical: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        child: !servicemanSetupController.isLoading?CustomButton(
                          btnTxt: "Assign_service_man".tr,
                          onPressed: () => bookingDetailsController.showHideExpandView(350),
                        ):CircularProgressIndicator(color: Theme.of(context).hoverColor,),
                      );
                    }) :bookingDetails.bookingStatus !='pending'&& bookingDetails.serviceman != null
                        ? BookingDetailsServicemanInfo( bookingId: bookingId)
                        :SizedBox.shrink(),

                    BookingDetailsCustomerInfo(),

                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,)
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}



