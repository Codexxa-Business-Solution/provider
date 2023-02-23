import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';


class BookingRequestController extends GetxController{
  final BookingRequestRepo bookingRequestRepo;
  BookingRequestController({required this.bookingRequestRepo});

  int _selectedIndex = 0;
  int get currentIndex =>_selectedIndex;

  bool _isLoading= false;
  bool get isLoading => _isLoading;

  int? _pageSize;
  int _offset = 1;

  int get offset => _offset;
  int? get pageSize => _pageSize;

  List <BookingRequestModel>? _bookingRequestList;
  List <BookingRequestModel>? get bookingRequestList=> _bookingRequestList;

  List<String> bookingRequestStatusList =["pending","accepted", "ongoing","completed","canceled"];
  String get bookingStatus => bookingRequestStatusList[_selectedIndex];

  final ScrollController scrollController = ScrollController();


  @override
  void onInit(){
    super.onInit();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if(_offset < _pageSize! ) {
          getBookingRequestList(bookingRequestStatusList[_selectedIndex],offset+1,true);
        }
      }

    });
  }


  Future<void> getBookingRequestList(String requestType,int offset,bool isFormPagination) async {
    _offset = offset;
    _isLoading = true;
    update();
    if(!isFormPagination){
      _bookingRequestList = [];
    }
    Response response = await bookingRequestRepo.getBookingRequestData(requestType.toLowerCase(), offset);
    if(response.statusCode == 200){
      if(!isFormPagination){
        _bookingRequestList = [];
      }
      List<dynamic> _bookingList = response.body['content']['data'];
      _bookingList.forEach((bookingRequest) => bookingRequestList!.add(BookingRequestModel.fromJson(bookingRequest)));
      _pageSize = response.body['content']['last_page'];
    }
    else{
      showCustomSnackBar(response.statusText);
    }
    _isLoading = false;
    update();
  }


  void updateBookingRequestIndex(int index){
    _selectedIndex = index;
    update();
  }

}