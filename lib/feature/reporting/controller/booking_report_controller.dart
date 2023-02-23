import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/model/booking_report_model.dart';
import 'package:demandium_provider/feature/reporting/repository/report_repo.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class BookingReportController extends GetxController implements GetxService {
  final ReportRepo reportRepo;
  BookingReportController({required this.reportRepo});

  List<String> dateRangeDropdownValue = [
    'all_time','this_week',"last_week","last_15_days","this_month","last_month","this_year","last_year",
    "this_year_1st_quarter","this_year_2nd_quarter","this_year_3rd_quarter","this_year_4th_quarter","custom_date"
  ];

  int? _pageSize;
  int _offset = 1;

  int get offset => _offset;
  int? get pageSize => _pageSize;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _dateRange="all_time";
  String? get dateRange => _dateRange;

  List<String> bookingStatus =['all','accepted','ongoing','completed','canceled'];
  String? _selectedBookingStatus= "all";
  String? get selectedBookingStatus => _selectedBookingStatus;

  List<String> _zoneNameList= [];
  List<ZonesList> _zonesList =[];
  List<String> get zoneNameList=> _zoneNameList;
  String? _selectedZoneName;
  String? get selectedZoneName => _selectedZoneName;
  String? _selectedZoneId;
  String? get selectedZoneId => _selectedZoneId;


  List<String> _categoryNameList = [];
  List<Categories> _categoriesList =[];
  List<String> get categoryNameList => _categoryNameList ;
  String? _selectedCategoryName;
  String? get selectedCategoryName => _selectedCategoryName;
  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;

  List<String> _subcategoryNameList = [];
  List<SubCategories> _subcategoriesList =[];
  List<String> get subcategoryNameList => _subcategoryNameList ;
  String? _selectedSubcategoryName;
  String? get selectedSubcategoryName => _selectedSubcategoryName;
  String? _selectedSubcategoryId;
  String? get selectedSubcategoryId => _selectedSubcategoryId;


  BookingReportModel? _bookingReportModel;
  BookingReportModel? get bookingReportModel => _bookingReportModel;

  List<BookingFilterData>  _bookingReportFilterData=[];
  List<BookingFilterData> get bookingReportFilterData => _bookingReportFilterData;

  ScrollController scrollController = ScrollController();

  List<Map<String,dynamic>> barChartData =[];


  DateTime? _startDate;
  DateTime? _endDate;
  String? _fromDate;
  String? _toDate;
  DateFormat _dateFormat = DateFormat('yyyy-MM-d');
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  DateFormat get dateFormat => _dateFormat;


  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if(_offset < _pageSize! ) {
          getBookingReportData(
              offset+1,reload: true
          );
        }
      }
    });

  }

  Future<void> getBookingReportData(int offset,{bool reload =false}) async {
    _offset = offset;
    resetDropDownValue();
    if(reload){
      _isLoading=true;
      update();
    }


    Map<String, dynamic> _data = {
      "booking_status": _selectedBookingStatus,
      "date_range": _dateRange,
      "from": _fromDate,
      "to": _toDate
    };
    if(_selectedZoneId != null) {
      _data.addAll({"zone_ids": [_selectedZoneId]});
    }if(_selectedCategoryId!=null){
      _data.addAll({"category_ids": [_selectedCategoryId]});
    }if(_selectedSubcategoryId!=null){
      _data.addAll({"sub_category_ids": [_selectedSubcategoryId]});
    }

    Response response = await reportRepo.getBookingReportData(
        offset,_data
    );
    if(response.statusCode == 200){
      _bookingReportModel = BookingReportModel.fromJson(response.body);
      if(_bookingReportModel?.content!=null){
        _pageSize = _bookingReportModel?.content?.filterData?.lastPage;
        if(_zonesList.isEmpty){
          _zonesList.addAll(_bookingReportModel!.content!.zones!);
        }
        if(_categoriesList.isEmpty){
          _categoriesList.addAll(_bookingReportModel!.content!.categories!);
        }
        if(_subcategoriesList.isEmpty){
          _subcategoriesList.addAll(_bookingReportModel!.content!.subCategories!);
        }
        if(_offset==1){
          _bookingReportFilterData=[];
          _bookingReportFilterData.addAll(_bookingReportModel!.content!.filterData!.data!);
        }else{
          _bookingReportFilterData.addAll(_bookingReportModel!.content!.filterData!.data!);
        }

        if(_zoneNameList.isEmpty){
          _zonesList.forEach((element) {
            _zoneNameList.add(element.name!);
          });
        }
        if(_categoryNameList.isEmpty){
          _categoriesList.forEach((element) {
            _categoryNameList.add(element.name!);
          });
        }
        if(_subcategoryNameList.isEmpty){
          _subcategoriesList.forEach((element) {
            _subcategoryNameList.add(element.name!);
          });
        }
        barChartData =[];
        for(int i=0;i<_bookingReportModel!.content!.chartData!.timeline!.length;i++){
          String timeline = _bookingReportModel!.content!.chartData!.timeline![i].toString();
          String taxAmount = _bookingReportModel!.content!.chartData!.taxAmount![i].toString();
          String adminCommission = _bookingReportModel!.content!.chartData!.adminCommission![i].toString();
          double? bookingAmount = _bookingReportModel!.content!.chartData!.bookingAmount![i];

          if(bookingAmount>0){
            barChartData.add(
                {
                  'timeline': timeline,
                  'Amount': bookingAmount,
                  'tax': PriceConverter.convertPrice(double.tryParse(taxAmount)),
                  'commission': PriceConverter.convertPrice(double.tryParse(adminCommission)),
                }
            );
          }
        }

      }
    }else{
      _bookingReportModel = null;
      _bookingReportFilterData = [];
      barChartData =[];
    }
    _isLoading = false;
    update();
  }

  void selectDate(String type, BuildContext context){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    ).then((date) {
      if (type == 'start'){
        _startDate = date;
        _fromDate = _dateFormat.format(_startDate!).toString();
      }else{
        _endDate = date;
        _toDate = _dateFormat.format(_endDate!).toString();
      }
      if(date == null){
        print('Null');
      }
      update();
    });
  }

  void getSubcategoryList(){
    _subcategoryNameList=[];
    _subcategoriesList.forEach((element) {
      if(element.parentId==_selectedCategoryId){
        _subcategoryNameList.add(element.name!);
        _selectedSubcategoryName =element.name;
      }
    });

    if(_subcategoryNameList.length>1){
      _subcategoryNameList.insert(0, 'all');
      _selectedSubcategoryName = 'all';
    }else if(_subcategoryNameList.length==1){
      _selectedSubcategoryName = _subcategoryNameList[0];
    }
    update();
  }

  void setSelectedDropdownValue(String dropdownValue,{String? type}){

    if(type=='zone'){
      _zonesList.forEach((element) {
        if(element.name==dropdownValue){
          _selectedZoneId = element.id!;
        }
      });
    }else if(type=='category'){
      _categoriesList.forEach((element) {
        if(element.name==dropdownValue){
          _selectedCategoryId = element.id!;
        }
      });
    }else if(type=='subcategory'){
      _subcategoriesList.forEach((element) {
        if(element.name==dropdownValue){
          _selectedSubcategoryId = element.id!;
        }
      });
    }else if(type=='booking_status'){
      _selectedBookingStatus=dropdownValue;
    }else if(type=='date_range'){
      _dateRange = dropdownValue;
    }
    update();
  }

  void resetDropDownValue(){
    _zonesList =[];
    _categoriesList =[];
    _subcategoriesList=[];
  }

  void resetValue(){
    _toDate= null;
    _fromDate= null;
    _startDate= null;
    _endDate = null;
    _dateRange = 'all_time';
    _selectedCategoryId=null;
    _selectedCategoryName=null;
    _selectedSubcategoryId=null;
    _selectedSubcategoryName = null;
    _selectedZoneId = null;
    update();
  }

  void resetTabControllerAndFilterValue(){
    _toDate= null;
    _fromDate= null;
    _startDate= null;
    _endDate = null;
    update();
  }
}