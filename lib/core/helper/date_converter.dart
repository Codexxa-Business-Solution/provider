import 'package:intl/intl.dart';

class DateConverter {
  static String stringYear(DateTime ? dateTime) {
    return DateFormat('y').format(dateTime!);
  }

  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
  }

  static String dateToDateAndTime(DateTime ? dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime!);
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('HH:mm aa').format(DateFormat('HH:mm aa').parse(dateTime));
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm aa').format(isoStringToLocalDate(dateTime));
  }

  static String dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static DateTime dateTimeString(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime);
  }

  static DateTime isoUtcStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static DateTime isoUtcStringToLocalTimeOnly(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String convertStringTimeToDate(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  static String dateMonthYearTime(DateTime ? dateTime) {
    return DateFormat('d MMM,y HH:mm').format(dateTime!);
  }

  static String dateStringMonthYear(DateTime ? dateTime) {
    return DateFormat('d MMM,y').format(dateTime!);
  }


  static String formatDate(DateTime date) => DateFormat.yMd().format(date);



  static String countDays(DateTime ? dateTime) {
    final startDate = dateTime!;
    final endDate = DateTime.now();
    final difference = endDate.difference(startDate).inDays;
    return difference.toString();
  }

  static String _timeFormatter() {
    // return Get.find<SplashController>().configModel.timeformat == '24' ? 'HH:mm' : 'hh:mm a';
    return 'hh:mm a';
  }

}