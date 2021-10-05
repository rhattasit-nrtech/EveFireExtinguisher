import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evefireextin/models/user_model.dart';
import 'package:evefireextin/states/add_extin.dart';
import 'package:evefireextin/states/admin_service.dart';
import 'package:evefireextin/states/authen.dart';
import 'package:evefireextin/states/main_home.dart';
import 'package:evefireextin/states/officer_service.dart';
import 'package:evefireextin/utility/my_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> map = {
  '/mainHome': (BuildContext context) => const MainHome(),
  '/authen': (BuildContext context) => const Authen(),
  '/adminService': (BuildContext context) => const AdminService(),
  '/officerService': (BuildContext context) => const OfficerService(),
  '/addExtin': (BuildContext context) => const AddExtin(),
};

String? firstState;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      // print('## event ==>> $event');
      if (event == null) {
        firstState = MyConstant.routMainHome;
        runApp(MyApp());
      } else {
        String uid = event.uid;
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .get()
            .then((value) {
          UserModel model = UserModel.fromMap(value.data()!);
          switch (model.type) {
            case 'admin':
              firstState = MyConstant.routAdminService;
              runApp(MyApp());
              break;
            case 'officer':
              firstState = MyConstant.routOfficerService;
              runApp(MyApp());
              break;
            default:
          }
        });
      }
    });
  });
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
