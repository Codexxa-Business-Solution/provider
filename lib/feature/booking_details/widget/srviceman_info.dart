import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/booking_details/widget/bottom_card.dart';

class BookingDetailsServicemanInfo extends StatelessWidget {
  final String bookingId;
  const BookingDetailsServicemanInfo({Key? key,required this.bookingId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsController>(
      builder: (bookingDetailsController){
        final bookingDetails =bookingDetailsController.bookingDetailsContent;
      return Column(
        children: [

          SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
          Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("Service_Man_Info".tr,
              style: ubuntuMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: Theme.of(context).primaryColor
              ),
            )
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          Stack(
            children: [
              bookingDetails!.serviceman!=null?
              BottomCard(
                name: bookingDetails.serviceman!.user!.firstName!+ " "+ bookingDetails.serviceman!.user!.lastName!,
                phone: bookingDetails.serviceman!.user!.phone!,
                image: "${Get.find<SplashController>().configModel.content!.imageBaseUrl}${AppConstants
                    .SERVICEMAN_PROFILE_IMAGE_PATH}""${bookingDetails.serviceman!.user!.profileImage!}",
              ):Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_LARGE,
                  vertical: Dimensions.PADDING_SIZE_LARGE,
                ),
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor.withOpacity(0.6),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 1,
                      color: Colors.black.withOpacity(0.1),
                    )]
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text('missing_serviceman_information'.tr,style: ubuntuRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)
                      ),),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                      Text('this_serviceman_may_deleted'.tr,style: ubuntuRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                        fontSize: Dimensions.fontSizeSmall,
                      )
                      ),
                    ],
                  ),
                ),
              ),

              bookingDetailsController.bookingDetailsContent!.bookingStatus=="accepted"||
              bookingDetailsController.bookingDetailsContent!.bookingStatus=="ongoing"?

              Positioned(
                top: Dimensions.PADDING_SIZE_DEFAULT,
                right: 35,
                child: InkWell(
                  child: Image.asset(Images.editIcon),
                  onTap: (){
                    Get.find<ServicemanSetupController>().fromBookingDetailsPage(true);
                    bookingDetailsController.showHideExpandView(350);
                  },
                ),
              )

               :SizedBox()
            ],
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,)
        ],
      );
    });
  }
}
