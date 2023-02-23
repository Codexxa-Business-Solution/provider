import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/core/theme/light_theme.dart';
import 'package:demandium_provider/feature/booking_details/widget/assign_serviceman_screen.dart';
import 'package:demandium_provider/feature/booking_details/widget/status_change_dropdown_button.dart';
import 'package:demandium_provider/feature/conversation/widgets/create_channel_dialog.dart';


class BookingDetails extends StatefulWidget {
  final String bookingId;
  final String bookingStatus;
  final String? fromPage;
  const BookingDetails( {
    Key? key,required this.bookingId,
    required this.bookingStatus,
    this.fromPage}) : super(key: key);
  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}
class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.fromPage == 'fromNotification') {
           Get.offAllNamed(RouteHelper.getInitialRoute());
           return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar:AppBar(
          elevation: 5,
          titleSpacing: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          shadowColor: Get.isDarkMode?Theme.of(context).primaryColor.withOpacity(0.5):Theme.of(context).primaryColor.withOpacity(0.1),
          title: Text('booking_details'.tr,
            style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColorLight),
          ),
          leading: IconButton(onPressed: (){
            if(widget.fromPage == 'fromNotification'){
              Get.offAllNamed(RouteHelper.getInitialRoute());
            }else{
              Get.back();
            }
            },
            icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight,size: 20,),
          ),
        ),


        body: GetBuilder<BookingDetailsController>(
          initState: (_){
            Get.find<ServicemanSetupController>().getAllServicemanList(1,reload: true,status: 'active');
            print('serviceman list called');
            Get.find<BookingDetailsController>().getBookingDetailsData(widget.bookingId);
          },
          builder: (bookingController) {
            return ExpandableBottomSheet(
              expandableContent: bookingController.bottomSheetHeight == 0?
              SizedBox() :
              AssignServicemanScreen(
                servicemanList: Get.find<ServicemanSetupController>().servicemanList,
                bookingId: widget.bookingId,
              ),
              persistentContentHeight: bookingController.bottomSheetHeight,
              background: GetBuilder<BookingDetailsController>(
                builder: (bookingDetailsController){
                  return Scaffold(
                    backgroundColor: Theme.of(context).backgroundColor,
                    body:Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverPersistentHeader(pinned: true, floating: false, delegate: BookingTabBarDelegate()),
                              bookingDetailsController.bookingPageCurrentState == BookingDetailsTabControllerState.bookingDetails ?
                              BookingDetailsWidget(bookingId: widget.bookingId,) :
                              BookingStatus(),
                            ],
                          ),
                        ),
                        if(bookingDetailsController.bookingDetailsContent != null &&
                            bookingDetailsController.bookingPageCurrentState == BookingDetailsTabControllerState.bookingDetails
                        )ChangeStatusDropdownButton(
                          bookingDetails: bookingDetailsController.bookingDetailsContent!,
                          bookingDetailsController: bookingDetailsController,
                          bookingId: widget.bookingId,
                        ),
                      ],
                    ),
                    floatingActionButton:bookingDetailsController.initialBookingStatus != 'pending'
                        && bookingDetailsController.isAssignedServiceman
                        && bookingDetailsController.bookingPageCurrentState == BookingDetailsTabControllerState.bookingDetails?
                    Container(
                      padding: EdgeInsets.only(bottom: 50),
                      child: FloatingActionButton(
                        elevation: 0.0,
                        child: new Icon(Icons.message_rounded,color: light.cardColor,),
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: ()=> Get.bottomSheet( CreateChannelDialog(
                          customerID: bookingDetailsController.bookingDetailsContent!.customerId,
                          providerId: bookingDetailsController.bookingDetailsContent!.provider!.userId,
                          serviceManId: bookingDetailsController.bookingDetailsContent!.serviceman!.userId,
                          referenceId: bookingDetailsController.bookingDetailsContent!.id!,),
                        ),
                      ),
                    ): null,
                  );
                },
              ),
            );
          }
        ),
      ),
    );
  }
}
class BookingTabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Container(
      child: GetBuilder<BookingDetailsController>(
        builder: (bookingTabController){
          return  Container(
            height: 45,
            width: Get.width,
            color: Theme.of(context).backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
                border:  Border(
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.7), width: 0.5),
                ),
              ),
              child: Center(
                child: TabBar(
                  unselectedLabelColor:Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
                  indicatorColor: Theme.of(context).primaryColor,
                  controller: bookingTabController.controller!,
                  labelColor: Theme.of(context).primaryColorLight,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  onTap: (int? index) {
                    switch (index) {
                      case 0:
                        bookingTabController.updateServicePageCurrentState(BookingDetailsTabControllerState.bookingDetails);
                        break;
                      case 1:
                        bookingTabController.updateServicePageCurrentState(BookingDetailsTabControllerState.status);
                        bookingTabController.showHideExpandView(0);
                        break;
                    }
                  },
                  tabs: bookingTabController.bookingDetailsTabs,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  @override
  double get maxExtent => 45;

  @override
  double get minExtent => 45;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
