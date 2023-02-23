import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/booking_details/model/bookings_details_model.dart';

enum BookingDetailsTabControllerState {bookingDetails,status}

class BookingDetailsController extends GetxController with GetSingleTickerProviderStateMixin{
  final BookingDetailsRepo? bookingDetailsRepo;
  BookingDetailsController({required this.bookingDetailsRepo});


  final List<Tab> bookingDetailsTabs = <Tab>[
    Tab(text: 'booking_details'.tr),
    Tab(text: 'status'.tr),
  ];



  final List<String> statusTypeList = [
    "accepted",
    "ongoing",
    "completed",
    "canceled",
  ];

  String dropDownValue = '';

  bool _isLoading= false;
  bool get isLoading => _isLoading;

  bool _isAcceptButtonLoading = false;
  bool get isAcceptButtonLoading => _isAcceptButtonLoading;

  bool _isStatusUpdateLoading = false;
  bool get isStatusUpdateLoading => _isStatusUpdateLoading;

  TabController? controller;
  BookingDetailsContent? _bookingDetailsContent;
  BookingDetailsContent? get bookingDetailsContent => _bookingDetailsContent;

  bool _isExpand = true;
  bool get isExpand => _isExpand;

  double _bottomSheetHeight = 0;
  double get bottomSheetHeight => _bottomSheetHeight;

  var bookingPageCurrentState = BookingDetailsTabControllerState.bookingDetails;

  String initialBookingStatus = 'pending';
  bool isAssignedServiceman = false;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  TimeOfDay _selectedTimeOfDay = TimeOfDay.now();
  TimeOfDay get selectedTimeOfDay => _selectedTimeOfDay;


  String _schedule = '';
  String get schedule => _schedule;

  List<InvoiceItem> _invoiceItems =[];
  List<InvoiceItem> get invoiceItems => _invoiceItems;

  List<double> _unitTotalCost =[];
  double _allTotalCost = 0;
  double _totalDiscount =0;
  double _totalDiscountWithCoupon =0;
  List<double> get unitTotalCost => _unitTotalCost;
  double get allTotalCost => _allTotalCost;
  double get totalDiscount => _totalDiscount;
  double get totalDiscountWithCoupon => _totalDiscountWithCoupon;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: bookingDetailsTabs.length);
    if(Get.find<SplashController>().configModel.content!.providerCanCancelBooking.toString()=='0'){
      statusTypeList.remove('canceled');
    }
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }

  Future<void> getBookingDetailsData(String bookingID,{bool reload = true}) async {
     if(reload){
       _isLoading = true;
     }
    Response response = await bookingDetailsRepo!.getBookingDetailsData(bookingID);
    if(response.statusCode==200){
      _bookingDetailsContent = BookingDetailsContent.fromJson(response.body['content']);
      initialBookingStatus =_bookingDetailsContent!.bookingStatus!;
      if(_bookingDetailsContent!.serviceman!=null){
        isAssignedServiceman = true;
      }
      _unitTotalCost=[];
      _bookingDetailsContent?.detail!.forEach((element){
        _unitTotalCost.add( double.parse(element.serviceCost!)*element.quantity!);
      });
      _allTotalCost=0;
      _unitTotalCost.forEach((element) {
        _allTotalCost=_allTotalCost+element;
      });

      double? discount= double.tryParse(_bookingDetailsContent!.totalDiscountAmount);
      double? campaignDiscount= double.tryParse(_bookingDetailsContent!.totalCampaignDiscountAmount!);
      _totalDiscount = (discount!+campaignDiscount!);
      _totalDiscountWithCoupon = discount+campaignDiscount+(double.tryParse(_bookingDetailsContent!.totalCouponDiscountAmount!)!);

      _invoiceItems =[];
      _bookingDetailsContent!.detail!.forEach((element){
        double discountAmount = double.tryParse(element.discountAmount!)! +
            (double.tryParse(element.campaignDiscountAmount!)!)
            +(double.tryParse(element.overallCouponDiscountAmount!)!);
        _invoiceItems.add(
            InvoiceItem(
              discountAmount: discountAmount.toPrecision(2),
              tax: double. tryParse(element.taxAmount!)!.toPrecision(2),
              unitAllTotal: double.tryParse(element.totalCost!)!.toPrecision(2),
              quantity: element.quantity!,
              serviceName: "${element.serviceName?? 'service_deleted'.tr }"
                  "\n${element.variantKey?.replaceAll('-', ' ').capitalizeFirst ?? 'variantKey_not_available'.tr}" ,
              variationName: "${element.variantKey?.replaceAll('-', ' ').capitalizeFirst ?? 'variantKey_not_available'.tr}" ,
              unitPrice: double.tryParse(element.serviceCost!)!.toPrecision(2),
            )
        );
      });

     dropDownValue = _bookingDetailsContent!.bookingStatus!;
    }
    else{
      print(response.statusText.toString().tr);
    }
    _isLoading = false;
    update();
  }

  Future<void> acceptBookingRequest(String bookingId) async {
    _isAcceptButtonLoading = true;
    update();
    Response response = await bookingDetailsRepo!.acceptBookingRequest(bookingId);
    if(response.statusCode==200){
      await getBookingDetailsData(_bookingDetailsContent!.id!,reload: false);
    }
    else{
      showCustomSnackBar(response.statusText);
    }
    _isAcceptButtonLoading = false;
    update();
  }

  Future<void> changeSchedule() async {
    Response response = await bookingDetailsRepo!.changeSchedule(bookingDetailsContent!.id!,_schedule);
    if(response.statusCode==200){
      getBookingDetailsData(_bookingDetailsContent!.id!,reload: false);
      showCustomSnackBar("service_schedule_changed_successfully".tr,isError: false);
    }
    else{
      showCustomSnackBar(response.statusText.toString().tr);
    }
  }


   void changeBookingStatus(String bookingId,{String? bookingStatus}) async {
    _isStatusUpdateLoading = true;
    update();

    if(bookingStatus!=null && bookingStatus=='ongoing' && dropDownValue =='canceled'){
      showCustomSnackBar('service_ongoing_can_not_cancel_booking'.tr);
    }else{
      Response response = await bookingDetailsRepo!.changeBookingStatus(bookingId,dropDownValue);
      if(response.statusCode==200 ){
        getBookingDetailsData(bookingId,reload: false);
        if(bookingStatus!=null && dropDownValue =='ongoing'){
          showCustomSnackBar("status_updated_to_ongoing".tr,isError: false);
        }else if(bookingStatus!=null && dropDownValue =='completed'){
          showCustomSnackBar("order_completed_successfully".tr,isError: false);
        }else if(bookingStatus!=null && dropDownValue =='completed'){
          showCustomSnackBar("order_cancelled".tr,isError: false);
        }else{
          showCustomSnackBar("status_updated".tr,isError: false);
        }
      }
      else{
        showCustomSnackBar(response.statusText);
      }
    }
    _isStatusUpdateLoading = false;
    update();
  }
  

  void updateServicePageCurrentState(BookingDetailsTabControllerState bookingDetailsTabControllerState){
    bookingPageCurrentState = bookingDetailsTabControllerState;
    update();
  }
  
  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: _selectedDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary:Get.isDarkMode?Theme.of(context).cardColor: Theme.of(context).primaryColor,
                onPrimary: Get.isDarkMode?Theme.of(context).primaryColorLight: Theme.of(context).cardColor,
                onSurface: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8),
                background: Theme.of(context).cardColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor : Theme.of(context).primaryColorLight, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      _selectedDate = picked;

      update();
      selectTimeOfDay();
    }
  }

  Future<void> selectTimeOfDay() async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now());

    if (pickedTime != null && pickedTime != _selectedTimeOfDay) {
      _selectedTimeOfDay = pickedTime;
      update();
      buildSchedule();
    }
  }

  Future<void> buildSchedule() async {
    _schedule = "${DateConverter.dateTimeStringToDate(_selectedDate.toString())}"
        " ${selectedTimeOfDay.hour.toString()}:${selectedTimeOfDay.minute.toString()}:00";

    if(_schedule!=""){
      changeSchedule();
      update();
    }

  }
  void showHideExpandView(double bottomHeight){
    _isExpand = !_isExpand;
    _bottomSheetHeight = bottomHeight;
    update();
  }

  void changeBookingStatusDropDownValue(String status){
    dropDownValue = status;
    update();
  }
}