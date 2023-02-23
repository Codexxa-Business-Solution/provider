import 'package:demandium_provider/components/custom_date_picker.dart';
import 'package:demandium_provider/core/helper/core_export.dart';
import 'package:demandium_provider/feature/reporting/controller/booking_report_controller.dart';
import 'package:demandium_provider/feature/reporting/controller/business_report_controller.dart';
import 'package:demandium_provider/feature/reporting/controller/transaction_report_controller.dart';
import 'package:demandium_provider/feature/reporting/widgets/custom_dropdown_button.dart';
import 'package:get/get.dart';

class ReportSearchFilter extends StatelessWidget {
  final String fromPage;
  const ReportSearchFilter({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: CustomAppBar(title: "filter".tr),
      body: 
      fromPage=="transaction" ?
      GetBuilder<TransactionReportController>(builder: (transactionReportController){
         return Container(
           padding: EdgeInsets.symmetric(
             vertical: Dimensions.PADDING_SIZE_SMALL,
             horizontal: Dimensions.PADDING_SIZE_DEFAULT,
           ),
           decoration: BoxDecoration(
             color: Get.isDarkMode?Theme.of(context).cardColor.withOpacity(0.5) :Theme.of(context).cardColor,
           ),
           child: Column(
             children: [

               ReportCustomDropdownButton(
                 label: 'select_date'.tr,
                 value: transactionReportController.dateRange,
                 items: transactionReportController.dateRangeDropdownValue,
                 onChanged: (newValue){
                   transactionReportController.setSelectedDropdownValue(newValue!,type: 'date_range');
                 },
               ),
               if(transactionReportController.dateRange=="custom_date")
                 Row(crossAxisAlignment: CrossAxisAlignment.end,children: [
                   Expanded(
                     child: CustomDatePicker(
                       title: 'from'.tr,
                       text: transactionReportController.startDate != null ?
                       transactionReportController.dateFormat.format(transactionReportController.startDate!).toString() : 'from_date'.tr,
                       image: Images.calender,
                       requiredField: false,
                       selectDate: () => transactionReportController.selectDate("start", context),
                     ),
                   ),
                   SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                   Expanded(
                     child: CustomDatePicker(
                       title: 'to'.tr,
                       text: transactionReportController.endDate != null ?
                       transactionReportController.dateFormat.format(transactionReportController.endDate!).toString() : 'to_date'.tr,
                       image: Images.calender,
                       requiredField: false,
                       selectDate: () => transactionReportController.selectDate("end", context),
                     ),
                   ),
                 ],),
               SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   transactionReportController.isLoading ?
                   SizedBox(
                     height: 35,
                     width: 100,
                     child: Center(child: CircularProgressIndicator()),) :
                   CustomButton(
                     btnTxt: 'filter'.tr,
                     height: 35,
                     width: 100,
                     onPressed: () async{
                       int tabIndex = transactionReportController.tabController?.index??0;

                       if(tabIndex==0){
                         await transactionReportController.getAllTransactionReportData(1,reload: true);
                       }else if(tabIndex==1){
                         await transactionReportController.getDebitTransactionReportData(1,reload: true);
                       }else{
                       await transactionReportController.getCreditTransactionReportData(1,reload: true);
                       }
                       //transactionReportController.resetValue();
                       Get.back();
                     },
                   ),
                 ],
               )
             ],
           ),
         );
      }) :
          
      fromPage=='booking'?
      GetBuilder<BookingReportController>(builder: (bookingReportController){
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_SMALL,
            horizontal: Get.width*.04,
          ),
          decoration: BoxDecoration(
            color: Get.isDarkMode?Theme.of(context).cardColor.withOpacity(0.5) :Theme.of(context).cardColor,
          ),
          child: Column(
            children: [

              if(bookingReportController.zoneNameList.length>1)
                ReportCustomDropdownButton(
                  label: 'select_zone'.tr,
                  value: bookingReportController.selectedZoneName,
                  items: bookingReportController.zoneNameList,
                  onChanged: (newValue){
                    bookingReportController.setSelectedDropdownValue(newValue!,type: 'zone');
                  },
                ),

              ReportCustomDropdownButton(
                label: 'category'.tr,
                value: bookingReportController.selectedCategoryName,
                items: bookingReportController.categoryNameList,
                onTap: (){
                  //bookingReportController.resetValue();
                },
                onChanged: (newValue){
                  bookingReportController.setSelectedDropdownValue(newValue!,type:'category');
                  //bookingReportController.getSubcategoryList();
                },
              ),
              Row(children: [
                Expanded(
                  child: ReportCustomDropdownButton(
                    label: 'sub_category'.tr,
                    value: bookingReportController.selectedSubcategoryName,
                    items: bookingReportController.subcategoryNameList,
                    onChanged: (newValue){
                      bookingReportController.setSelectedDropdownValue(newValue!,type:'subcategory');
                    },
                  ),
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                Expanded(
                  child: ReportCustomDropdownButton(
                    label: "status".tr,
                    value: bookingReportController.selectedBookingStatus,
                    items: bookingReportController.bookingStatus,
                    onChanged: (newValue){
                      bookingReportController.setSelectedDropdownValue(newValue!,type:'booking_status');
                    },
                  ),
                ),
              ],),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              ReportCustomDropdownButton(
                label: "select_date".tr,
                value: bookingReportController.dateRange,
                items: bookingReportController.dateRangeDropdownValue,
                onChanged: (newValue){
                  bookingReportController.setSelectedDropdownValue(newValue!,type: 'date_range');
                },
              ),
              if(bookingReportController.dateRange=="custom_date")
                Row(crossAxisAlignment: CrossAxisAlignment.end,children: [
                  Expanded(
                    child: CustomDatePicker(
                      title: 'from'.tr,
                      text: bookingReportController.startDate != null ?
                      bookingReportController.dateFormat.format(bookingReportController.startDate!).toString() : 'from_date'.tr,
                      image: Images.calender,
                      requiredField: false,
                      selectDate: () => bookingReportController.selectDate("start", context),
                    ),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                  Expanded(
                    child: CustomDatePicker(
                      title: 'to'.tr,
                      text: bookingReportController.endDate != null ?
                      bookingReportController.dateFormat.format(bookingReportController.endDate!).toString() : 'to_date'.tr,
                      image: Images.calender,
                      requiredField: false,
                      selectDate: () => bookingReportController.selectDate("end", context),
                    ),
                  ),
                ],),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  bookingReportController.isLoading
                  ? SizedBox(width: 100,child: Center(child: CircularProgressIndicator()))
                  :CustomButton(
                    btnTxt: 'filter'.tr,
                    height: 35,
                    width: 100,
                    onPressed: () async {
                      await  bookingReportController.getBookingReportData(1,reload: true);
                      bookingReportController.resetValue();
                      Get.back();
                    },
                  ),
                ],
              )
            ],
          ),
        );
      }):

      GetBuilder<BusinessReportController>(builder: (businessReportController){
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_SMALL,
            horizontal: Get.width*.04,
          ),
          decoration: BoxDecoration(
            color: Get.isDarkMode?Theme.of(context).cardColor.withOpacity(0.5) :Theme.of(context).cardColor,
          ),
          child: Column(
            children: [

              if(businessReportController.zoneNameList.length>1)
                ReportCustomDropdownButton(
                  label: 'select_zone'.tr,
                  value: businessReportController.selectedZoneName,
                  items: businessReportController.zoneNameList,
                  onChanged: (newValue){
                    businessReportController.setSelectedDropdownValue(newValue!,type: 'zone');
                  },
                ),

              ReportCustomDropdownButton(
                label: 'category'.tr,
                value: businessReportController.selectedCategoryName,
                items: businessReportController.categoryNameList,
                onChanged: (newValue){
                  businessReportController.setSelectedDropdownValue(newValue!,type:'category');
                },
              ),
              ReportCustomDropdownButton(
                label: 'sub_category'.tr,
                value: businessReportController.selectedSubcategoryName,
                items: businessReportController.subcategoryNameList,
                onChanged: (newValue){
                  businessReportController.setSelectedDropdownValue(newValue!,type:'subcategory');
                },
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              ReportCustomDropdownButton(
                label: "select_date".tr,
                value: businessReportController.dateRange,
                items: businessReportController.dateRangeDropdownValue,
                onChanged: (newValue){
                  businessReportController.setSelectedDropdownValue(newValue!,type: 'date_range');
                },
              ),
              if(businessReportController.dateRange=="custom_date")
                Row(crossAxisAlignment: CrossAxisAlignment.end,children: [
                  Expanded(
                    child: CustomDatePicker(
                      title: 'from'.tr,
                      text: businessReportController.startDate != null ?
                      businessReportController.dateFormat.format(businessReportController.startDate!).toString() : 'from_date'.tr,
                      image: Images.calender,
                      requiredField: false,
                      selectDate: () => businessReportController.selectDate("start", context),
                    ),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                  Expanded(
                    child: CustomDatePicker(
                      title: 'to'.tr,
                      text: businessReportController.endDate != null ?
                      businessReportController.dateFormat.format(businessReportController.endDate!).toString() : 'to_date'.tr,
                      image: Images.calender,
                      requiredField: false,
                      selectDate: () => businessReportController.selectDate("end", context),
                    ),
                  ),
                ],),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  businessReportController.isLoading
                  ? SizedBox(width: 100,child: Center(child: CircularProgressIndicator()))
                  :CustomButton(
                    btnTxt: 'filter'.tr,
                    height: 35,
                    width: 100,
                    onPressed: ()async{
                      int tabIndex = businessReportController.businessReportTabController?.index??0;

                      if(tabIndex==1) {
                        await businessReportController.getBusinessReportEarningData(1,reload: true);
                        Get.back();
                      }else if(tabIndex==2){
                        await businessReportController.getBusinessReportExpenseData(1,reload: true);
                        Get.back();
                      }else{
                        await businessReportController.getBusinessReportOverviewData(1,reload: true);
                        businessReportController.resetValue();
                        Get.back();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        );
      })    
    );
  }
}
