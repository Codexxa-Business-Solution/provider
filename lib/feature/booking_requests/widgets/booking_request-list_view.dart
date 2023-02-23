import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class BookingRequestListview extends StatelessWidget {
  const BookingRequestListview({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingRequestController>(
      builder: (bookingRequestController) {
        return Column(
          children:[
            bookingRequestController.bookingRequestList?.length != 0 ?
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isTab(context)?2:1,
                mainAxisExtent: !Get.find<LocalizationController>().isLtr?140:120,
                crossAxisSpacing: 5
              ),
              shrinkWrap: true,
              itemCount: bookingRequestController.bookingRequestList?.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx,index)=>BookingRequestItem(
                  bookingRequestModel : bookingRequestController.bookingRequestList![index]
              ),
            ): SizedBox.shrink(),
            bookingRequestController.isLoading ? Center(child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: CircularProgressIndicator(color: Theme.of(context).hoverColor),
            ),) : SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
