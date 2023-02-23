import 'package:get/get.dart';
import 'package:demandium_provider/core/helper/core_export.dart';

class DashBoardRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  DashBoardRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> getDashBoardData() async {
    return await apiClient.getData(AppConstants.DASHBOARD_URI+"?sections=top_cards,earning_stats,booking_stats,recent_bookings,my_subscriptions,serviceman_list");
  }

  Future<Response> getMonthlyDashBoardChartData(String year,String month) async {
    return await apiClient.getData(AppConstants.DASHBOARD_URI+"?sections=earning_stats&stats_type=full_month&month=$month&year=$year");
  }

  Future<Response> getYearlyDashBoardChartData(String year) async {
    return await apiClient.getData(AppConstants.DASHBOARD_URI+"?sections=earning_stats&stats_type=full_year&year=${year}");
  }
}