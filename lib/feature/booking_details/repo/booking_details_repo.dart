import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class BookingDetailsRepo{
  final ApiClient apiClient;

  BookingDetailsRepo({required this.apiClient});

  Future<Response> getBookingDetailsData(String bookingID) async {
    return await apiClient.getData(AppConstants.BOOKING_DETAILS_URL+"/"+bookingID);
  }

  Future<Response> acceptBookingRequest(String bookingID) async {
    return await apiClient.putData(AppConstants.BOOKING_ACCEPT_STATUS_URL+"/"+bookingID,{'method':'put'});
  }

  Future<Response> changeSchedule(String bookingID,String schedule) async {
    return await apiClient.putData(AppConstants.CHANGE_SCHEDULE_URL+"/"+bookingID,{'schedule': schedule});
  }

  Future<Response> changeBookingStatus(String bookingID,String status) async {
    return await apiClient.putData(AppConstants.CHANGE_BOOKING_STATUS_URL+"/"+bookingID,{'booking_status':'${status}'});
  }
}