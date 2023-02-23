import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class ReportRepo{
  final ApiClient apiClient;
  ReportRepo({required this.apiClient});


  Future<Response> getTransactionReportData(int offset, Map<String,dynamic> body) async {
    return await apiClient.postData(
        AppConstants.GET_TRANSACTION_REPORT_DATA +"?limit=10&offset=$offset",body

    );
  }

  Future<Response> getBusinessReportOverviewData(int offset, Map<String,dynamic> body
      ) async {
    return await apiClient.postData(
        AppConstants.GET_BUSINESS_OVERVIEW_DATA+"?limit=20&offset=$offset",body
    );
  }

  Future<Response> getBusinessReportEarningData(int offset, Map<String,dynamic> body
      ) async {
    return await apiClient.postData(
        AppConstants.GET_BUSINESS_EARNING_DATA+"?limit=10&offset=$offset",body
    );
  }
  Future<Response> getBusinessReportExpenseData(int offset, Map<String,dynamic> body
      ) async {
    return await apiClient.postData(
        AppConstants.GET_BUSINESS_EXPENSE_DATA+"?limit=10&offset=$offset",body
    );
  }



  Future<Response> getBookingReportData(int offset, Map<String,dynamic> body
      ) async {
    return await apiClient.postData(
        AppConstants.GET_BOOKING_REPORT_DATA+"?limit=10&offset=$offset",body
    );
  }
}