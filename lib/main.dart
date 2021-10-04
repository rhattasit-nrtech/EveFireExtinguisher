import 'package:evefireextin/states/admin_service.dart';
import 'package:evefireextin/states/authen.dart';
import 'package:evefireextin/states/main_home.dart';
import 'package:evefireextin/states/officer_service.dart';
import 'package:evefireextin/states/show_detail.dart';
import 'package:evefireextin/utility/my_constant.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> map = {
  '/mainHome': (BuildContext context) => const MainHome(),
  '/showDetail': (BuildContext context) => const ShowDetail(),
  '/authen': (BuildContext context) => const Authen(),
  '/adminService': (BuildContext context) => const AdminService(),
  '/officerService': (BuildContext context) => const OfficerService(),
};

String? firstState;

main() {
  firstState = MyConstant.routMainHome;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: firstState,
      title: MyConstant.appName,
    );
  }
}
