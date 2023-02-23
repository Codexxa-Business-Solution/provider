import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class BookingRequestMenuBar extends SliverPersistentHeaderDelegate{

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color:  Theme.of(context).backgroundColor,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_SMALL),
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return GetBuilder<BookingRequestController>(builder: (controller){
            return InkWell(
              child: BookingRequestMenuItem(
                title: controller.bookingRequestStatusList[index].toLowerCase(),
                index: index,
              ),
              onTap: (){
                controller.updateBookingRequestIndex(index);
                controller.getBookingRequestList(controller.bookingRequestStatusList[index], 1, false);
              },
            );
          });
        }
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}