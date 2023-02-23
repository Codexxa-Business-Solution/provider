import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorResources {

  static Color getRightBubbleColor() {
    return Get.isDarkMode ? Color(0xFF4E5787):  Color(0xFFBBD0E3);
  }
  static Color getLeftBubbleColor() {
    return Get.isDarkMode ? Color(0xFF6C537F):  Color(0xFFD2CECE);
  }
  static const Map<String, Color> buttonBackgroundColorMap ={
    'pending': Color(0xffE6EFF6),
    'accepted': Color(0xffEAF4FF),
    'ongoing': Color(0xffEAF4FF),
    'completed': Color(0xffe6f2eb),
    'settled': Color(0xffc8f9e3),
    'canceled': Color(0xffFFEBEB),
    'approved': Color(0xffdbfee9),
    'denied': Color(0xffFFEBEB),
  };

  static const Map<String, Color> buttonTextColorMap ={
    'pending': Color(0xff0461A5),
    'accepted': Color(0xff2B95FF),
    'ongoing': Color(0xff2B95FF),
    'completed': Color(0xff4ccb81),
    'settled': Color(0xff16B559),
    'canceled': Color(0xffFF3737),
    'approved': Color(0xff16B559),
    'denied':  Color(0xffFF3737),
  };
}
List<BoxShadow>? shadow = Get.isDarkMode? null:[
  BoxShadow(
  offset: Offset(0, 1),
  blurRadius: 2,
  color: Colors.black.withOpacity(0.15),
)];
