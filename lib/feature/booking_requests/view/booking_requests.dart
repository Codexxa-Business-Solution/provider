import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ServiceRequestScreen extends StatefulWidget {
  const ServiceRequestScreen({Key? key}) : super(key: key);
  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MainAppBar(title: 'booking_requests'.tr,color: Theme.of(context).primaryColor,),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColorLight,
        backgroundColor: Theme.of(context).cardColor,
        onRefresh: () async {
          Get.find<BookingRequestController>().getBookingRequestList(Get.find<BookingRequestController>()
              .bookingRequestStatusList[Get.find<BookingRequestController>().currentIndex],1,false,
          );
        },
        child: GetBuilder<BookingRequestController>(
          initState: (_){
            Get.find<BookingRequestController>().getBookingRequestList('pending',1,false,);
            Get.find<BookingRequestController>().updateBookingRequestIndex(0);
          },
          builder:(bookingRequestController){
          return CustomScrollView(
            controller: bookingRequestController.scrollController,
            slivers: [
              SliverPersistentHeader(delegate: BookingRequestMenuBar(), pinned: true, floating: false),
              bookingRequestController.isLoading && bookingRequestController.bookingRequestList!.length==0 ?
              SliverToBoxAdapter(child: CustomShimmer(),):
              bookingRequestController.bookingRequestList!.length==0 ?
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(height: Get.height * 0.7,
                    child: NoDataScreen(
                        text: '${'no'.tr} ${bookingRequestController.bookingStatus.tr.toLowerCase()} ${"request_right_now".tr}',
                        type: NoDataType.REQUEST
                    ),
                  ),
                )
              ) : SliverToBoxAdapter(child: BookingRequestListview())
            ],
          );
        }),
      )
    );
  }
}
