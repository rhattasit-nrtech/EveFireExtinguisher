import 'package:flutter/material.dart';

class MyConstant {
  // field
  static String routMainHome = '/mainHome';
  static String routShowDetail = '/showDetail';
  static String routAuthen = '/authen';
  static String routAdminService = '/adminService';
  static String routOfficerService = '/officerService';

  static String appName = 'Eve Fire Extinguisher';

  static Color primary = Colors.purple;
  static Color dark = Colors.purple.shade900;
  static Color lite = Colors.purple.shade200;

  // method
  TextStyle h1Style() => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: dark,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: dark,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: dark,
      );
}
